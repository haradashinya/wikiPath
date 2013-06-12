//
//  GameOverViewController.m
//  wikiPath
//
//  Created by HARADA SHINYA on 5/29/13.
//  Copyright (c) 2013 HARADA SHINYA. All rights reserved.
//

#import "GameOverViewController.h"

@interface GameOverViewController ()

@end

@implementation GameOverViewController
{
    UILabel *titleLabel;
    UILabel *resLabel;
    Data *data;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self viewDidLoad];
        // Custom initialization
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden  = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden  = YES;
    [self.view setBackgroundColor:[UIColor darkGrayColor]];
    data = [Data shared];
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [titleLabel setText:@"Congraltation!"];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setBackgroundColor:[UIColor orangeColor]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    
    resLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 320, 44)];
    [resLabel setTextAlignment:NSTextAlignmentCenter];
    [resLabel setText:[NSString stringWithFormat:@"You reached only %d times to Rome." ,data.loadCount]];
    [resLabel setTextColor:[UIColor whiteColor]];
    [resLabel setBackgroundColor:[UIColor clearColor]];
    
    
    [self.view addSubview:titleLabel];
    [self.view addSubview:resLabel];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(10, 200, 300, 44);
    [btn setTitle:@"Play Again" forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [btn addTarget:self action:@selector(tappedPlayAgain:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:btn];
    
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    startBtn.frame = CGRectMake(10, 260, 300, 44);
    [startBtn setTitle:@"Back to Start" forState:UIControlStateNormal];
    [startBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [startBtn addTarget:self action:@selector(onStart:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    
    UIButton *playAgainBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    playAgainBtn.frame = CGRectMake(10,320, 300, 44);
    [playAgainBtn setTitle:@"Rank" forState:UIControlStateNormal];
    [playAgainBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [playAgainBtn addTarget:self action:@selector(tappedRank:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playAgainBtn];
    
    NSLog(@"hello! %i",data.loadCount);
    
	// Do any additional setup after loading the view.
    bannerView = [[GADBannerView alloc] initWithFrame:CGRectMake(0,self.view.frame.size.height - 50, 320, 50)];
    bannerView.adUnitID = @"a151b5dc1851880";
    bannerView.rootViewController = self;
    [self.view addSubview:bannerView];
    [bannerView loadRequest:[GADRequest request]];
    bannerView.layer.zPosition = 100;

}
-(void)onStart:(id)sender
{
    NSLog(@"onStart");
    [self.navigationController popToRootViewControllerAnimated:YES];
//    IntroViewController *ivc = [[IntroViewController alloc] init];
}
-(void)tappedRank:(id)sender
{
    NSLog(@"tapped");

    [[GameKitHelper sharedGameKitHelper] showLeaderboard:@"com.nobinobiru.wiki.score"];

}
-(void)tappedPlayAgain:(id)sender
{
    // reset data.
    data.loadCount = 0;
    MainViewController *mvc = [[MainViewController alloc] initWithNibName:nil bundle:nil];
//    [self.navigationController popToRootViewControllerAnimated:YES];
    [self.navigationController popToViewController:self animated:YES];
    [self.navigationController pushViewController:mvc animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
