//
//  ADNPostViewController.m
//  AppDotNetReader
//
//  Created by Gerald Fairclough, Jr on 2/7/16.
//  Copyright © 2016 Gerald Fairclough, Jr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ADNPostViewController.h"
#import "ADNPostTableViewController.h"

@implementation ADNPostViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"tableSegue"]) {
        //pass spinner to table view controller to allow it to stop and start the spinner
        ADNPostTableViewController *tableViewController = segue.destinationViewController;
    
        tableViewController.spinner = self.spinner;
    }
}

@end