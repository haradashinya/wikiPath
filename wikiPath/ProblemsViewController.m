//
//  ProblemsViewController.m
//  wikiPath
//
//  Created by HARADA SHINYA on 6/3/13.
//  Copyright (c) 2013 HARADA SHINYA. All rights reserved.
//

#import "ProblemsViewController.h"

@interface ProblemsViewController ()

@end

@implementation ProblemsViewController

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
    UIButton *b = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [b.layer setCornerRadius:0];
    [b setFrame:CGRectMake(-10, 0, 340, 44)];
    [b setTitle:@"Close x" forState:UIControlStateNormal];
    [b.layer setBackgroundColor:[UIColor blackColor].CGColor];
    [b addTarget:self action:@selector(onClose) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:b];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 44, 320, self.view.frame.size.height - 44)];
    [webView.scrollView setScrollEnabled:NO];
    webView.delegate = self;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:5000"]]];
//    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://pickalize.info:4000"]]];
    // set current index
    
    
    [self.view addSubview:webView];
	// Do any additional setup after loading the view.
}

-(void)onClose
{
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"lflfl");
}


-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIAlertView *v = [[UIAlertView alloc] initWithTitle:@"" message:@"Network error happend." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [v show];
}


-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *s = [request.URL description];
    NSArray *linkS = [s componentsSeparatedByString:@"//"];
    NSLog(@"linkS is %@",linkS);
    if ([linkS[0] isEqual:@"api:"]){
        [[Data shared] saveProblem:[linkS objectAtIndex:2]];
        
        return NO;
    }
    return YES;
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"start");
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"clcllccll");
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *s = [ud objectForKey:@"currentProblem"];
    NSString *code = [NSString stringWithFormat:@"window.setIndex('%@');",s];
    [webView stringByEvaluatingJavaScriptFromString:code];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
