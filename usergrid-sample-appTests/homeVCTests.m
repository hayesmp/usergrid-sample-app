//
//  rackspace_helios_ios7Tests.m
//  rackspace-helios-ios7Tests
//
//  Created by Michael Hayes on 9/20/13.
//  Copyright (c) 2013 MHayes Design. All rights reserved.
//

#import <XCTest/XCTest.h>
#include "HomeVC.h"
#include "User.h"

@class User;

@interface homeVCTests : XCTestCase {
    HomeVC* homeVC;
}

@end

@implementation homeVCTests

- (void)setUp
{
    [super setUp];
    
    homeVC = [[HomeVC alloc] initWithNibName:@"HomeVC" bundle:nil];
    [homeVC viewDidLoad];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testHomeHasMap
{
    XCTAssertNotNil(homeVC.map, @"Map is not nil.");
}

- (void)testHomeHasMapTypeHybrid
{
    XCTAssertEqual(homeVC.map.mapType, MKMapTypeHybrid, @"Map type is hybrid(2)");
}

- (void)testHomeHasMapWithMyLocation
{
    [homeVC setMapCurrentLocation:37.785834 lon:-122.406417];
    CLLocationCoordinate2D checkpoint = CLLocationCoordinate2DMake(37.785834, -122.406417);
    XCTAssertEqual(homeVC.map.centerCoordinate.latitude, checkpoint.latitude, @"Map shows my location.");
}

- (void)testIfNoUserIsLoggedInShowLoginScreen
{
    homeVC.user = User.new;
    [homeVC viewDidAppear:false];
    XCTAssertNotNil(homeVC.loginRegVC, @"Login Screen is not nil");
}

- (void)testIfUserIsLoggedInDontShowLoginScreen
{
    homeVC.user = User.new;
    ApigeeUser* aUser = ApigeeUser.new;
    [homeVC.user loginUser:aUser];
    XCTAssertNil(homeVC.loginRegVC, @"Login screen is nil");
}


@end
