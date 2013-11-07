//
//  AppDelegate.m
//  usergrid-sample-app
//
//  Created by Michael Hayes on 11/7/13.
//  Copyright (c) 2013 MHayes Design. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeVC.h"
#import "User.h"

NSString* const orgName = @"my_organization"; //YOUR-ORG
NSString* const appName = @"my_app"; //YOUR-APP
NSString* const nodeUrl = @"http://192.237.176.205:8080"; //BASE-URL

@implementation AppDelegate
@synthesize user, homeVC;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //Replace 'AppDelegate' with the name of your app delegate class to instantiate it
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    //Instantiate ApigeeClient to initialize the SDK
    appDelegate.apigeeClient = [[ApigeeClient alloc] initWithOrganizationId:orgName applicationId:appName baseURL:nodeUrl];
    
    //Retrieve instances of ApigeeClient.monitoringClient and ApigeeClient.dataClient
    self.monitoringClient = [appDelegate.apigeeClient monitoringClient]; //used to call App Monitoring methods
    self.dataClient = [appDelegate.apigeeClient dataClient]; //used to call data methods
    
    self.user = User.new;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.homeVC = HomeVC.new;
    self.homeVC.user = self.user;
    
    self.window.rootViewController = homeVC;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
