//
//  ADNPostsStore.h
//  AppDotNetReader
//
//  Created by Gerald Fairclough, Jr on 2/6/16.
//  Copyright © 2016 Gerald Fairclough, Jr. All rights reserved.
//

@class ADNPost;

@interface ADNPostsStore : NSObject

@property (nonatomic,strong, readonly) NSArray *posts;

+(instancetype)sharedStore;

/**
 Add a post to the post array which will be read by the table view controller
 @param post A ADNPost object
 */
-(void)addPostToStore:(ADNPost *)post;

-(void)refreshPosts:(void (^)(void))reload;

@end
