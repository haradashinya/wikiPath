//
//  MenuView.h
//  wikiPath
//
//  Created by HARADA SHINYA on 5/29/13.
//  Copyright (c) 2013 HARADA SHINYA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "MainAppDelegate.h"
#import "ScoreLabel.h"
#import "GADBannerView.h"

@interface MenuView : UIView
{
    GADBannerView *bannerView;
}
@property (nonatomic,strong) UIViewController *parentViewController;

-(void)hello;
//-(void)addSubview:(UIView *)view
-(void)webViewBackToTop;
-(void)setParentViewController:(UIViewController *)parentViewController;

-(void)backTop;


@end
