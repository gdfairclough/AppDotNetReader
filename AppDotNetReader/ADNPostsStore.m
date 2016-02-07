//
//  ADNPostsStore.m
//  AppDotNetReader
//
//  Created by Gerald Fairclough, Jr on 2/6/16.
//  Copyright © 2016 Gerald Fairclough, Jr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADNPostsStore.h"
#import "ADNPost.h"

@interface ADNPostsStore()

@property (nonatomic,strong) NSMutableArray *privatePosts;

@end

@implementation ADNPostsStore

static ADNPostsStore *sharedStore;

+(instancetype)sharedStore{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedStore = [[ADNPostsStore alloc]init];
        sharedStore.privatePosts = [NSMutableArray array];
    });
    return sharedStore;
}

-(NSArray *)posts{
    //return posts sorted by date
    NSSortDescriptor *sortDescriptor =[[NSSortDescriptor alloc] initWithKey:@"createdAt" ascending:NO];
    
    
    return [self.privatePosts sortedArrayUsingDescriptors:@[sortDescriptor]];
}

-(void)addPostToStore:(ADNPost *)post{
   
    [self.privatePosts addObject:post];
}



@end