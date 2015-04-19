//
//  ViewController.m
//  FVenues
//
//  Created by Hannu Lantto on 17/04/15.
//  Copyright (c) 2015 dummy. All rights reserved.
//

#import "ViewController.h"
#import "venueData.h"
#import "venueCell.h"
#import "fourSHelper.h"

@interface ViewController ()

@end

@implementation ViewController {
    CLLocationManager *_locationManager;
    CLLocation *_currentLocation;
    NSArray *_venues; // venues got from FS are stored here
    NSString *_keyWord; // stores the last used keyword
}

static NSString * const reuseIdentifier = @"venueCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // get current location
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.distanceFilter = 10;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.pausesLocationUpdatesAutomatically = TRUE;
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse) {
        // ask users approval
        [_locationManager requestWhenInUseAuthorization];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)keywordChanged:(id)sender {
    NSString *newKeyWord = _textFieldSearch.text;
    
    // check that keyword has changed
    if (_keyWord != newKeyWord) {
        NSLog(@"new keyword: %@", newKeyWord);
        _keyWord = newKeyWord;
        
        if ([_keyWord isEqualToString:@""]) {
            // make no search with empty string -> last search results are shown
            return;
        }
            
        // make search
        [[[fourSHelper alloc] init] makeSearch:_keyWord location:_currentLocation completionHandler:^(NSArray *venues) {
            _venues = venues;
            // view refresh needs to be done in main thread
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }];
    }
}


#pragma mark - CLLocationManagerDelegate

// location changed
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    _currentLocation = [locations lastObject];
    NSLog(@"new location %f %f", _currentLocation.coordinate.latitude, _currentLocation.coordinate.longitude);
}

// user granted/denied location query
- (void)locationManager:(CLLocationManager*)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined: {
            NSLog(@"User cannot make up their mind");
            _textFieldSearch.text = @"Location services are required.";
            _textFieldSearch.enabled = FALSE;
        } break;
        case kCLAuthorizationStatusDenied: {
            NSLog(@"User denied access to location services");
            _textFieldSearch.text = @"Location services are required.";
            _textFieldSearch.enabled = FALSE;
        } break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        case kCLAuthorizationStatusAuthorizedAlways: {
            [_locationManager startUpdatingLocation];
            _textFieldSearch.text = @"";
            _textFieldSearch.enabled = TRUE;
        } break;
        default:
            break;
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // only one section in table
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _venues.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    venueCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    venueData* obj = _venues[indexPath.row];
    cell.venueName.text = obj.name;
    if (obj.address == nil) {
        cell.venueAddress.text = @"address unknown";
    } else {
        cell.venueAddress.text = obj.address;
    }
    if (obj.distance == nil) {
        cell.venueDistance.text = @"distance unknown";
    } else {
        cell.venueDistance.text = [NSString stringWithFormat:@"distance: %d m", [obj.distance intValue]];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.textFieldSearch resignFirstResponder];
}

@end
