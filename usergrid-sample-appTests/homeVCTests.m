//
//  rackspace_helios_ios7Tests.m
//  rackspace-helios-ios7Tests
//
//  Created by Michael Hayes on 9/20/13.
//  Copyright (c) 2013 MHayes Design. All rights reserved.
//

#import <XCTest/XCTest.h>
#include "HomeVC.h"

@interface homeVCTests : XCTestCase {
    HomeVC* homeVC;
}

@end

@implementation homeVCTests

- (void)setUp
{
    [super setUp];
    
    homeVC = HomeVC.new;
    [homeVC viewDidLoad];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testHomeHasCameraButton
{
    XCTAssertNotNil(homeVC.camera, @"Camera is not nil");
}

- (void)testHomeCameraButtonLaunchesModalCameraVC
{
    [homeVC.camera.target performSelector:NSSelectorFromString(@"capture:x")];
    XCTAssertNotNil(homeVC.cameraView, @"CamerView is not nil.");
    
}

- (void)testHomeHasMap
{
    XCTAssertNotNil(homeVC.map, @"Map is not nil.");
}

- (void)testHomeHasMapTypeHybrid
{
    XCTAssertEqual(homeVC.map.mapType, 2, @"Map type is hybrid(2)");
}

- (void)testHomeHasMapWithMyLocation
{
    [homeVC setMapCurrentLocation:37.785834 lon:-122.406417];
    CLLocationCoordinate2D checkpoint = CLLocationCoordinate2DMake(37.785834, -122.406417);
    XCTAssertEqual(homeVC.map.centerCoordinate.latitude, checkpoint.latitude, @"Map shows my location.");
}



@end
