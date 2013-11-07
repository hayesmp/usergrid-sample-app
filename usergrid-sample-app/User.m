//
//  User.m
//  usergrid-sample-app
//
//  Created by Michael Hayes on 11/7/13.
//  Copyright (c) 2013 MHayes Design. All rights reserved.
//

#import "User.h"

@implementation User
@synthesize apigeeUser, loggedIn;

-(void)loginUser:(ApigeeUser*)aUser
{
    self.apigeeUser = aUser;
    self.loggedIn = true;
}

@end
