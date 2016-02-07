//
//  ADNHTTPClient.m
//  AppDotNetReader
//
//  Created by Gerald Fairclough, Jr on 2/6/16.
//  Copyright © 2016 Gerald Fairclough, Jr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"
#import "ADNHTTPClient.h"
#import "AFNetworking.h"
#import "ADNPost.h"
#import "ADNPostsStore.h"
#import "ADNPostTableViewController.h"


#define kBaseURI @"https://alpha-api.app.net/"
#define kPath @"stream/0/posts/stream/global"

@implementation ADNHTTPClient

//create the default session configuration

NSURLSessionConfiguration *configuration;

NSURL *baseURL;

AFHTTPSessionManager *httpSessionManager;

static ADNHTTPClient *sharedClient;

+(instancetype)sharedClient{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[ADNHTTPClient alloc]init];
        configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        baseURL = [NSURL URLWithString:kBaseURI];
        httpSessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL sessionConfiguration:configuration];
    });
    return sharedClient;
}

-(void)retrievePostArray:(ADNPostTableViewController *)view completion:(void (^)(void))completion{
    
    
    [httpSessionManager GET:kPath parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //show spinner while progress < 100%
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self parseDataIntoPosts:responseObject completion:completion];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        UIAlertController *alert = [UIAlertController
                                    alertControllerWithTitle:@"Network Error"
                                    message:@"Error retreiving posts"
                                    preferredStyle:UIAlertControllerStyleAlert
                                    ];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [view presentViewController:alert animated:YES completion:nil];
        
    }];
    
}

-(void)parseDataIntoPosts:(id)responseObject completion:(void (^)(void))completion{
    
    NSArray *postsArray = [responseObject valueForKey:@"data"];
    
    //NSLog(@"%@",postsArray[0]);
    
    NSDictionary *userDict;
   
    for (id postDict in postsArray) {
        
        ADNPost *post = [[ADNPost alloc] init];
        userDict = [postDict valueForKey:@"user"];
        post.user = [userDict valueForKey:@"username"];
        post.createdAt = [postDict valueForKey:@"created_at"];
        post.text = [postDict valueForKey:@"text"];
        post.avatarImageURL = [[userDict valueForKey:@"avatar_image"] valueForKey:@"url"];
        
        
        //save to the store
        [[ADNPostsStore sharedStore] addPostToStore:post];
    }

    //set the avatar images for each post
    NSArray *posts = [[ADNPostsStore sharedStore] posts];
    
    for (ADNPost * post in posts) {
      
        if (post.avatarImageURL){
            
            NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
            AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
            
            //response will be created as an UIImage
            manager.responseSerializer = [[AFImageResponseSerializer alloc] init];
            
            NSURL *URL = [NSURL URLWithString:post.avatarImageURL];
            NSURLRequest *request = [NSURLRequest requestWithURL:URL];
            
            NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
                if (error) {
                    NSLog(@"Error: %@", error);
                } else {
                    //NSLog(@"%@ %@", response, responseObject);
                    post.avatarImage = responseObject;
                    completion();
                }
            }];
            [dataTask resume];
        
        }
    }
    
}

@end