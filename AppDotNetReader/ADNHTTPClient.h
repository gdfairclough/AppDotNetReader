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
/**
 Retrieve new posts from App.net API
 @param view view controller to show alert view if an error occurs during data fetch
 @param completion completion handler for reloading table data
 */
-(void)retrievePostArray:(ADNPostTableViewController *)view completion:(void (^)(void))completion;


@end
