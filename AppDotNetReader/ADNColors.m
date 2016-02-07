//
//  ADNColors.m
//  AppDotNetReader
//
//  Created by Gerald Fairclough, Jr on 2/7/16.
//  Copyright © 2016 Gerald Fairclough, Jr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ADNColors.h"
#include <stdlib.h>

@implementation ADNColors

static ADNColors *sharedInstance;

+(instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ADNColors alloc] init];
        
        
    });
    
    return sharedInstance;
}

-(UIColor *)createColor{
    
    return [UIColor colorWithHue:0.6 saturation:0.5 brightness:0.5 alpha:0.6];
}

@end