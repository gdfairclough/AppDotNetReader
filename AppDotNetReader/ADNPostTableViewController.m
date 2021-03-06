//
//  PostTableViewController.m
//  AppDotNetReader
//
//  Created by Gerald Fairclough, Jr on 2/6/16.
//  Copyright © 2016 Gerald Fairclough, Jr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ADNPostTableViewController.h"
#import "ADNPostTableViewCell.h"
#import "ADNPostsStore.h"
#import "ADNPost.h"
#import "ADNHTTPClient.h"

#define kPostReuseId @"postCell"
#define kCellMinHeight 100
#define kLabelLineHeight 21
#define kCharactersPerLine 35
#define REFRESH_INTERVAL 10

@interface ADNPostTableViewController()

@property (nonatomic,strong) NSDate *lastUpdate;

@end

@implementation ADNPostTableViewController

void (^refreshData)(void);

-(void)viewDidLoad{
    
    //register the table view cell nib
    UINib *cellNib = [UINib nibWithNibName:NSStringFromClass([ADNPostTableViewCell class]) bundle:nil];
    [self.postsTableView registerNib:cellNib forCellReuseIdentifier:kPostReuseId];
    
    //set up refresh data block
    
    refreshData = ^{
        [self.postsTableView reloadData];
        [self.spinner stopAnimating];
        self.lastUpdate = [NSDate date];
    };
    
    //only need to display this spinner on loading the table at first, since top indicator will appear at other times
    [self.spinner startAnimating];
    [[ADNHTTPClient sharedClient] retrievePostArray:self completion:refreshData];
    
    [self.postsTableView reloadData];
    
    
    
    //set up for dynamic cell height
    self.postsTableView.rowHeight = UITableViewAutomaticDimension;
    self.postsTableView.estimatedRowHeight = 100;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [[ADNPostsStore sharedStore].posts count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ADNPostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPostReuseId];
    
    //retrieve the posts from the store based off the current index path row and set the values for the cell
    ADNPost *currentPost = [ADNPostsStore sharedStore].posts[indexPath.row];
    
    cell.username.text = currentPost.user;
    cell.avatar.image = currentPost.avatarImage;
    cell.postText.text = currentPost.text;
    [cell addColorToName];
    
    return cell;
}

#pragma MARK: Refresh on pull down



- (IBAction)refresh:(UIRefreshControl *)sender {
    
    NSDate *currentDate = [NSDate date];
    NSDate *dateToUpdate = [self.lastUpdate dateByAddingTimeInterval:REFRESH_INTERVAL];
   
    if ([currentDate timeIntervalSinceReferenceDate] >=  [dateToUpdate timeIntervalSinceReferenceDate]) {
     
    
        [[ADNHTTPClient sharedClient] retrievePostArray:self completion:^{
            [self.postsTableView reloadData];
            self.lastUpdate = [NSDate date];
            [sender endRefreshing];
        
        }];
        NSLog(@"updating..");
    }else{
        NSLog(@"not ready to update");
        [sender endRefreshing];
    }
}


-(void)fetchNewDataWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completion{
    
    [[ADNHTTPClient sharedClient] retrievePostArray:self completion:refreshData];
    
    completion(UIBackgroundFetchResultNewData);
    
}

@end