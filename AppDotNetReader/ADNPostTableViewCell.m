//
//  ADNPostTableViewCell.m
//  AppDotNetReader
//
//  Created by Gerald Fairclough, Jr on 2/6/16.
//  Copyright © 2016 Gerald Fairclough, Jr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"
#import "ADNPostTableViewCell.h"
#include <stdlib.h>
#import "ADNColors.h"

@implementation ADNPostTableViewCell

NSArray *colors;


-(void)addColorToName{
    
    self.username.textColor = [[ADNColors sharedInstance] createColor];
    
}

@end