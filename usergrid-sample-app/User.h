//
//  User.h
//  usergrid-sample-app
//
//  Created by Michael Hayes on 11/7/13.
//  Copyright (c) 2013 MHayes Design. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ApigeeiOSSDK/ApigeeUser.h>

@interface User : NSObject {
    ApigeeUser* apigeeUser;
    BOOL loggedIn;
}
@property (nonatomic, strong) ApigeeUser* apigeeUser;
@property (nonatomic, assign) BOOL loggedIn;

-(void)loginUser:(ApigeeUser*)aUser;
@end
