//
//  ADNHTTPClient.h
//  AppDotNetReader
//
//  Created by Gerald Fairclough, Jr on 2/6/16.
//  Copyright © 2016 Gerald Fairclough, Jr. All rights reserved.
//

@class ADNPostTableViewController;

@interface ADNHTTPClient : NSObject

+(instancetype)sharedClient;

-(void)retrievePostArray:(ADNPostTableViewController *)view completion:(void (^)(void))completion;


@end
