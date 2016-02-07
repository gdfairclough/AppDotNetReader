//
//  ADNPost.h
//  AppDotNetReader
//
//  Created by Gerald Fairclough, Jr on 2/6/16.
//  Copyright © 2016 Gerald Fairclough, Jr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADNPost : NSObject

@property (nonatomic,strong) NSString *user;
@property (nonatomic,strong) NSDate *createdAt;
@property (nonatomic,strong) NSString *avatarImageURL;
@property (nonatomic,strong) UIImage* avatarImage;
@property (nonatomic,strong) NSString *text; 

@end
