//
//  ViewController.h
//  FVenues
//
//  Created by Hannu Lantto on 17/04/15.
//  Copyright (c) 2015 dummy. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreLocation;

@interface ViewController : UIViewController <CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *textFieldSearch;
- (IBAction)keywordChanged:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

