//
//  IntroViewController.h
//  Pods
//
//  Created by HARADA SHINYA on 5/31/13.
//
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "GameKitHelper.h"
#import "Data.h"
#import "GADBannerView.h"

@interface IntroViewController : UIViewController<UIWebViewDelegate>
{
    Data *data;
    GADBannerView *bannerView;
}
- (IBAction)onTappedStart:(id)sender;
- (IBAction)onTappedChangeProblem:(id)sender;
- (IBAction)onTappedPlayFromLastData:(id)sender;

@end
