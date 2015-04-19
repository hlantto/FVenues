//
//  fourSHelper.m
//  FVenues
//
//  Created by Hannu Lantto on 17/04/15.
//  Copyright (c) 2015 dummy. All rights reserved.
//

#import "fourSHelper.h"
#import "venueData.h"

@implementation fourSHelper {
    SearchCompleteHandler _completionHandler;
}

static NSString * const CLIENT_ID = @"CLIENT_ID";
static NSString * const CLIENT_SECRET = @"CLIENT_SECRET";

-(id) init {
    if (self = [super init]) {

    }
    
    return self;
}

// form the request
-(void) makeSearch:(NSString*)keyword location:(CLLocation*) location completionHandler:(SearchCompleteHandler)completionHandler{

    _completionHandler = [completionHandler copy];
    
    // encode keyword
    NSString *encodedString = [keyword stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];

    NSMutableString *url = [NSMutableString stringWithString:@"https://api.foursquare.com/v2/venues/search"];
    [url appendString:@"?v=20150418"];
    [url appendString:@"&m=foursquare"];
    [url appendFormat:@"&client_id=%@", CLIENT_ID];
    [url appendFormat:@"&client_secret=%@", CLIENT_SECRET];
    [url appendFormat:@"&ll=%f,%f", location.coordinate.latitude, location.coordinate.longitude];
    [url appendFormat:@"&query=%@", encodedString];
    [url appendString:@"&intent=browse"];
    [url appendFormat:@"&radius=%d", 500];
    
    [self executeSearch:url];
}

-(void) executeSearch:(NSString*)url {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            _completionHandler(nil);
        } else {
            [self parseVenues:data];
        }
    }];
    
    [dataTask resume];
}

-(void) parseVenues:(NSData*)data {
    // holds all the parsed venues
    NSMutableArray *parsedVenues = [[NSMutableArray alloc] init];
    
    // parse JSON reply
    NSDictionary *reply = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

    // get response
    NSDictionary *response = [reply objectForKey:@"response"];
    // venues are an array
    NSArray *venues = [response objectForKey:@"venues"];
    // loop venues
    for (NSDictionary *venue in venues) {
        // read name and location:address and location:distance
        NSString *name = [venue objectForKey:@"name"];
        venueData *newVenue = [[venueData alloc] init];
        newVenue.name = name;
        
        NSDictionary *location = [venue objectForKey:@"location"];
        if (location) {
            NSString *address = [location objectForKey:@"address"];
            newVenue.address = address;
            NSNumber *distance = [location objectForKey:@"distance"];
            newVenue.distance = distance;
        }
        
        [parsedVenues addObject:newVenue];
    }
    
    _completionHandler(parsedVenues);
}

@end
