//
//  User.m
//  usergrid-sample-app
//
//  Created by Michael Hayes on 11/7/13.
//  Copyright (c) 2013 MHayes Design. All rights reserved.
//

#import "User.h"

@implementation User
@synthesize apigeeUser, loggedIn, name;

-(void)loginUser:(NSString*)aUserName
{
    self.name = aUserName;
    self.loggedIn = true;
}

-(void)logout
{
    self.name = nil;
    self.loggedIn = false;
}
@end
