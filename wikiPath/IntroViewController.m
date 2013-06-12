//
//  IntroViewController.m
//  Pods
//
//  Created by HARADA SHINYA on 5/31/13.
//
//

#import "IntroViewController.h"

@interface IntroViewController ()

@end

@implementation IntroViewController
{
    UILabel *questionLabel;
    NSUserDefaults *ud;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:0 diskCapacity:0 diskPath:nil];
    [NSURLCache setSharedURLCache:sharedCache];

    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    UIButton *infoBtn = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [infoBtn setFrame:CGRectMake(280, 10, 44, 44)];
    [infoBtn addTarget:self action:@selector(onInfo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:infoBtn];
    
    
    UIButton *rankBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rankBtn setBackgroundColor:[UIColor blackColor]];
    [rankBtn setTintColor:[UIColor whiteColor]];
    [rankBtn setTitle:@"Rank" forState:UIControlStateNormal];
    [rankBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [rankBtn.layer setCornerRadius:10];
    rankBtn.frame = CGRectMake(220,100, 80, 44);
    [rankBtn addTarget:self action:@selector(onRank:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rankBtn];
    
    //add admob
    bannerView = [[GADBannerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-50, 320, 50)];
    bannerView.adUnitID = @"a151b5dc1851880";
    bannerView.rootViewController = self;
    [self.view addSubview:bannerView];
    [bannerView loadRequest:[GADRequest request]];
    

//    [self.navigationController setTitle:@"Go Rome"];
    GameKitHelper *gk = [GameKitHelper sharedGameKitHelper];
    [gk authenticateLocalPlayer];
    


	// Do any additional setup after loading the view.
}
-(void)onRank:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    [btn setBackgroundColor:[UIColor darkGrayColor]];
    [self performSelector:@selector(setDefaultColor:) withObject:btn afterDelay:0.5];
    [[GameKitHelper sharedGameKitHelper] showLeaderboard:@"com.nobinobiru.wiki.score"];
    
}
-(void)setDefaultColor:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    [btn setBackgroundColor:[UIColor blackColor]];
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    ud = [NSUserDefaults standardUserDefaults];
    [Data shared].loadCount = 0;
    [Data shared].isPlain = NO;
    self.navigationController.navigationBarHidden = YES;
    
    questionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 160, 320, 44)];
    [questionLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [questionLabel setText:[NSString stringWithFormat:@"Let's found '%@' link.",[Data shared].currentProblem]];
    [questionLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:questionLabel];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTappedStart:(id)sender {
    [Data shared].isPlain = YES;
    NSLog(@"lflflf");
}

- (IBAction)onTappedChangeProblem:(id)sender {
    
//    CGRect frame = self.view.frame;
//    UIWebView *webView = [[UIWebView alloc] initWithFrame:frame];
//    
//    NSURL *url = [NSURL URLWithString:@"http://en.wikipedia.org/wiki/Apple"];
//    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    
}
- (IBAction)onTappedPlayFromLastData:(id)sender {
    MainViewController *mvc = [[MainViewController alloc] init];
    NSDictionary *d = [ud objectForKey:@"saveData"];
    if (d){
        
        [Data shared].loadCount = [[d objectForKey:@"loadCount"] integerValue];
        [Data shared].title = [d  objectForKey:@"link"];
        [self.navigationController pushViewController:mvc animated:YES];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No save data." message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
    }
    
}
-(void)onInfo:(id)sender
{
    NSString *str = [NSString stringWithFormat:@"Let's visit %@ link  from apple link!",[Data shared].currentProblem];
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"How to Play" message:str delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [av show];
    
}
@end
