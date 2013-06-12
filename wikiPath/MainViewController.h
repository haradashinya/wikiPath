//
//  MainViewController.h
//  wikiPath
//
//  Created by HARADA SHINYA on 5/29/13.
//  Copyright (c) 2013 HARADA SHINYA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuView.h"
#import "Data.h"
#import "ScoreLabel.h"
#import "GameOverViewController.h"
#import "GameKitHelper.h"
#import <QuartzCore/QuartzCore.h>
#import "GADBannerView.h"

// 今までにたどってきた履歴を閲覧することができる機能を追加。
// 難易度を上げていく。一問目: Orange, 二問目: Rome, 三問目: Rome

@interface MainViewController : UIViewController<UIWebViewDelegate>
{
    GADBannerView *bannerView;
}

-(void)webViewBackToTop;
-(void)goTop;
-(void)backTop;
-(void)back;
-(void)next;

@end
