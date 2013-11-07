//
//  AppDelegate.h
//  usergrid-sample-app
//
//  Created by Michael Hayes on 11/7/13.
//  Copyright (c) 2013 MHayes Design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ApigeeiOSSDK/Apigee.h>

@class HomeVC;
@class User;

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    User* user;
    HomeVC* homeVC;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ApigeeClient *apigeeClient; //object for initializing the App Services SDK
@property (strong, nonatomic) ApigeeMonitoringClient *monitoringClient; //client object for Apigee App Monitoring methods
@property (strong, nonatomic) ApigeeDataClient *dataClient;	//client object for App Services data methods
@property (strong, nonatomic) User* user;
@property (strong, nonatomic) HomeVC* homeVC;
@end
