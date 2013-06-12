//
//  Data.m
//  wikiPath
//
//  Created by HARADA SHINYA on 5/29/13.
//  Copyright (c) 2013 HARADA SHINYA. All rights reserved.
//

#import "Data.h"

@implementation Data
{
}
static Data *data;
+(Data *)shared
{
    if (!data){
        data = [[Data alloc] init];
        data.ud = [NSUserDefaults standardUserDefaults];
        data.currentProblem = [data.ud objectForKey:@"currentProblem"];
        if (![data.ud objectForKey:@"currentProblem"]){
            [data.ud setObject:@"Rome" forKey:@"currentProblem"];
            [data.ud synchronize];
        }
    
    }
    return data;
    
}
-(void)saveProblem:(NSString *)word
{
    [self.ud setObject:word forKey:@"currentProblem"];
    [self.ud synchronize];
    
    self.currentProblem = [self.ud objectForKey:@"currentProblem"];
    NSLog(@"currentProblem: %@",[self.ud objectForKey:@"currentProblem"]);
    
}

@end
