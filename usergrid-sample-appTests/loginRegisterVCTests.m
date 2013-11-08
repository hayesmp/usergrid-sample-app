//
//  loginRegisterVCTests.m
//  rackspace-helios-ios7
//
//  Created by Michael Hayes on 11/6/13.
//  Copyright (c) 2013 MHayes Design. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LoginRegisterVC.h"

@interface loginRegisterVCTests : XCTestCase {
    LoginRegisterVC* loginRegVC;
}

@end

@implementation loginRegisterVCTests

- (void)setUp
{
    [super setUp];
    loginRegVC = LoginRegisterVC.new;
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testSuccessfulLoginSavesUserData
{
    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

@end
