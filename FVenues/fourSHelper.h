//
//  fourSHelper.h
//  FVenues
//
//  Created by Hannu Lantto on 17/04/15.
//  Copyright (c) 2015 dummy. All rights reserved.
//

@import Foundation;
@import CoreLocation;
@import UIKit;

typedef void (^SearchCompleteHandler)(NSArray *venues);

@interface fourSHelper : NSObject

-(void) makeSearch:(NSString*)keyword location:(CLLocation*) location completionHandler:(SearchCompleteHandler) completionHandler;

@end
