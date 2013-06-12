//
//  MenuView.m
//  wikiPath
//
//  Created by HARADA SHINYA on 5/29/13.
//  Copyright (c) 2013 HARADA SHINYA. All rights reserved.
//

#import "MenuView.h"

@implementation MenuView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self setBackgroundColor:[UIColor orangeColor]];
        // Initialization code
    }
    return self;
}
// add buttons.
-(void)setup
{
//    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [menuBtn setBackgroundImage:[UIImage imageNamed:@"menu_btn.png"] forState:UIControlStateNormal];
//    [self addSubview:menuBtn];
//    [menuBtn setFrame:CGRectMake(320-30,0, 30, 30)];
//    menuBtn.layer.zPosition = 100;
    
    
//    UIButton *btn = [[UIButton alloc] init];
//    btn.frame = CGRectMake(0, 0,44,44);
//    [btn setTitle:@"↑" forState:UIControlStateNormal];
//    [btn.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:22]];
//    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(onTappedTop:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:btn];
    
    
    
    
    
    // for debug
    // for back
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 13, 44, 44)];
    [backBtn setTitle:@"◁" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(onTappedBack:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setBackgroundColor:[UIColor darkGrayColor]];
    [self addSubview:backBtn];
    
    backBtn.layer.cornerRadius  = 22;
    
    // for next
    UIButton *nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(320 - 44 - 10, 13, 44, 44)];
    [nextBtn setTitle:@"▷" forState:UIControlStateNormal];
    [nextBtn setBackgroundColor:[UIColor darkGrayColor]];
    [nextBtn addTarget:self action:@selector(onTappedNext:) forControlEvents:UIControlEventTouchUpInside];
    nextBtn.layer.cornerRadius  = 22;
    [self addSubview:nextBtn];
    

    
    
    
    
//    UILabel *s = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
//    [s setTextAlignment:NSTextAlignmentCenter];
//    [s setBackgroundColor:[UIColor orangeColor]];
//    [s setTextColor:[UIColor whiteColor]];
//    [s setShadowColor:[UIColor whiteColor]];
//    [s setShadowOffset:CGSizeMake(0, 0.5)];
//    [s setFont:[UIFont boldSystemFontOfSize:20]];
//    [s setText:@"Go Rome"];
//    [self addSubview:s];
    
}

- (void)drawRect:(CGRect)rect
{
    [self setup];
}
-(void)onTappedBack:(id)sender
{
    [(MainViewController *)self.parentViewController back];
    
}
-(void)onTappedNext:(id)sender
{
    
    [(MainViewController *)self.parentViewController next];
    
}

-(void)onTappedTop:(id)sender
{
    NSLog(@"toggle");
    [(MainViewController *)self.parentViewController backTop];
}
@end
