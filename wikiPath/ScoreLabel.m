//
//  ScoreLabel.m
//  wikiPath
//
//  Created by HARADA SHINYA on 5/29/13.
//  Copyright (c) 2013 HARADA SHINYA. All rights reserved.
//

#import "ScoreLabel.h"

@implementation ScoreLabel
{
    UILabel *strLabel;
    Data *data;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor darkGrayColor];
        data = [Data shared];
        
        
        // Initialization code
    }
    return self;
}
- (void)drawRect:(CGRect)rect
{
    strLabel = [[UILabel alloc] initWithFrame:rect];
    [self renderStrLabel];
    [strLabel setTextColor:[UIColor orangeColor]];
    [strLabel setBackgroundColor:[UIColor clearColor]];
    [strLabel setTextAlignment:NSTextAlignmentCenter];
    [strLabel setFont:[UIFont boldSystemFontOfSize:18]];
    strLabel.layer.zPosition = 100;
    [self addSubview:strLabel];
}
-(void)renderStrLabel
{
    NSString *s = [NSString stringWithFormat:@"Load %d times" , data.loadCount];
    [strLabel setText:s];
}
-(void)reload
{
    
    NSString *s = [NSString stringWithFormat:@"Load %d times" , data.loadCount];
    [strLabel setText:s];
    
}
-(void)render
{
    
}

@end
