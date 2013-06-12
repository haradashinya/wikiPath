//
//  MainViewController.m
//  wikiPath
//
//  Created by HARADA SHINYA on 5/29/13.
//  Copyright (c) 2013 HARADA SHINYA. All rights reserved.
//

#import "MainViewController.h"
//wikitter http://wikitter.info/search/i でゴールがあるやつだけを載せる。
// ステージを表示
// 最期のステージに達したら、問題の難易度をリセットして一から遊べるようにする。
// {
// apple -> tree
// tree -> The_Beatles
//
// ほそ
// }

@interface MainViewController ()

@end

@implementation MainViewController
{
    int loadCount;
    MenuView *menuView;
    UIWebView *webView;
    Data *data;
    ScoreLabel *scoreLabel;
    Boolean *hasVisited;
    NSString *title;
    NSUserDefaults *ud;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];

    data = [Data shared];
    // if data.currentProblem is Null , then set Rome (fix for launches first time.)
    if (!data.currentProblem){
        data.currentProblem = @"Rome";
    }
    NSLog(@"currentProblem is %@",data.currentProblem);
    
    NSLog(@"data.loadCount is %i",data.loadCount);
    self.navigationController.navigationBarHidden = NO;
    
    CGRect frame = self.view.frame;
    webView = [[UIWebView alloc] initWithFrame:frame];
    NSLog(@"title is %@",data.title);
    NSURL *url;
    // if data.isPlay is Yes , then start game from scratch.
    if (data.isPlain == YES){
        
       url = [NSURL URLWithString:@"http://en.wikipedia.org/wiki/Apple"];
        
    }else{
        url = [NSURL URLWithString:[NSString stringWithFormat:@"http://en.wikipedia.org/wiki/%@",data.title]];
    }
    
    
    
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    webView.delegate = self;
    [self.view addSubview:webView];
	// Do any additional setup after loading the view, typically from a nib.
    //UIWebViewの検索フィールドの上にLabelを載せる。
    // Javascript
    menuView = [[MenuView alloc] initWithFrame:CGRectMake(0, 0, 320, 70)];
    menuView.layer.opacity =  0.9;
    [menuView setBackgroundColor:[UIColor blackColor]];
    [menuView setParentViewController:self];
    [self.view addSubview:menuView];
    scoreLabel = [[ScoreLabel alloc] initWithFrame:CGRectMake(160-80,13,160, 44)];
    [scoreLabel setText:@"Load"];
    [scoreLabel setTextColor:[UIColor whiteColor]];
    [self.view addSubview:scoreLabel];
    hasVisited = NO;
    
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,45,45)] ;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.text = [NSString stringWithFormat:@"Let's find '%@' link",data.currentProblem];
    self.navigationItem.titleView = label;
    [label sizeToFit];
    [self.navigationController.navigationBar.layer setBorderColor:[UIColor colorWithWhite:0.250 alpha:1.000].CGColor];
    [self.navigationController.navigationBar.layer setBorderWidth:1.0];
    
    // セーブしたら、今のリンクを記憶して、そこから、ゲームを再開できる。
    UIBarButtonItem *saveBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(onSave)];
    [self.navigationItem setRightBarButtonItem:saveBtn];

    
    bannerView = [[GADBannerView alloc] initWithFrame:CGRectMake(0,self.view.frame.size.height - 90, 320, 50)];
    bannerView.adUnitID = @"a151b5dc1851880";
    bannerView.rootViewController = self;
    [self.view addSubview:bannerView];
    [bannerView loadRequest:[GADRequest request]];
    bannerView.layer.zPosition = 100;

    
}

// save last url and load times.
-(void)onSave
{
    NSDictionary *d = @{@"link": title,@"loadCount": @(data.loadCount)};
    ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:d forKey:@"saveData"];
    [ud synchronize];
    
}
-(void)viewDidAppear:(BOOL)animated

{
    if (scoreLabel){
        [scoreLabel reload];
    }
}

-(void)goGameOver
{
    
}

// back to top pos of webView.
-(void)backTop
{
    [webView stringByEvaluatingJavaScriptFromString:@"window.scroll(0,0)"];
    
    
}
-(void)back
{
    
    if ([title isEqual:@"Apple"] || data.loadCount == 0 || [title isEqual:data.title]){
        return;
    }
    
    [webView stringByEvaluatingJavaScriptFromString:@"window.history.back()"];
    data.loadCount += 1;
    [scoreLabel reload];
}
-(void)next
{
    [webView stringByEvaluatingJavaScriptFromString:@"window.history.forward()"];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
    UIAlertView *v = [[UIAlertView alloc] initWithTitle:@"" message:@"Network error happend." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [v show];
}


//validate
// if url start with wikipedia , go it otherwise alert something.
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSArray *paths = [request.URL.description componentsSeparatedByString:@"/"];
    title = [paths lastObject];
    NSLog(@"title is %@",title);
    NSLog(@"data.title is %@",data.title);
    
    if ([title isEqual:@"Apple"] || [title isEqual:data.title]){
        NSLog(@"start");
        return YES;
    }
    NSLog(@"title %@",title);
    
    // if url is doesn't contain wikipedia then should not redirect.
    if (![[paths objectAtIndex:2] isEqual:@"en.m.wikipedia.org"]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Oops! Against the Rule! Please visit in the wikipedia's english site" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        
        [alertView show];
        return NO;
    }
    
    
    if ([title isEqual:[data currentProblem]] || [title isEqual:@"Apple_Inc."]){
        data.loadCount += 1;
        [scoreLabel reload];
        GameOverViewController *gvc = [[GameOverViewController alloc] initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:gvc animated:YES];
        GameKitHelper *gk = [GameKitHelper sharedGameKitHelper];
        [gk submitScore:data.loadCount category:@"com.nobinobiru.wiki.score"];

        NSLog(@"game clear!");
        return NO;
    }else{
        data.loadCount += 1;
        [scoreLabel reload];
        
    }
    // if url has goal matched , then go to game over view controlller
    // otherwise, inc the loadCount and view load.
    return YES;
}

-(void)reloadScoreLabel
{
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
