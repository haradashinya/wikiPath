//
//  Data.h
//  wikiPath
//
//  Created by HARADA SHINYA on 5/29/13.
//  Copyright (c) 2013 HARADA SHINYA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Data : NSObject
+(Data *)shared;
@property(nonatomic) int loadCount;
@property(nonatomic) NSUserDefaults *ud;
@property(nonatomic) NSString *currentProblem;
@property(nonatomic) NSDictionary *saveData;
@property(nonatomic) NSString *title;
@property (nonatomic) BOOL isPlain;

-(void)saveProblem:(NSString *)word;

@end
