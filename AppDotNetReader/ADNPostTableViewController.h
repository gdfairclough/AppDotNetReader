//
//  ADNPostTableViewController.h
//  AppDotNetReader
//
//  Created by Gerald Fairclough, Jr on 2/6/16.
//  Copyright © 2016 Gerald Fairclough, Jr. All rights reserved.
//

@interface ADNPostTableViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UITableView *postsTableView;
@property (strong, nonatomic) UIActivityIndicatorView *spinner;

- (IBAction)refresh:(UIRefreshControl *)sender;

/**
 method for initiating a background fetch in order to provide the app with fresh data on launch
 */
-(void)fetchNewDataWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completion;

@end
