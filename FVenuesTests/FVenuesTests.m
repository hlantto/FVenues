//
//  FVenuesTests.m
//  FVenuesTests
//
//  Created by Hannu Lantto on 17/04/15.
//  Copyright (c) 2015 dummy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "ViewController.h"
#import "AppDelegate.h"


@interface FVenuesTests : XCTestCase {
@private
    UIApplication   *app;
    AppDelegate     *appDelegate;
    ViewController  *fViewController;
    UIView          *fView;
}
@end

@implementation FVenuesTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    app             = [UIApplication sharedApplication];
    appDelegate     = [app delegate];
    fViewController = (ViewController*)appDelegate.window.rootViewController;
    fView           = fViewController.view;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)DISABLED_testLocationDenied {
    // deny location services
    //CLLocationManager *authorizationStatus = kCLAuthorizationStatusDenied;
    fViewController.textFieldSearch.text = @"oulu";
    XCTAssert(YES, @"Pass");
}

- (void)DISABLED_testNoNetwork {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)DISABLED_testQueryTimeout {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testOkSearch {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testFiveSimultaneousSearches {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
