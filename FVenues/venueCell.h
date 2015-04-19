//
//  venueCell.h
//  FVenues
//
//  Created by Hannu Lantto on 17/04/15.
//  Copyright (c) 2015 dummy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface venueCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *venueName;
@property (strong, nonatomic) IBOutlet UILabel *venueAddress;
@property (strong, nonatomic) IBOutlet UILabel *venueDistance;

@end
