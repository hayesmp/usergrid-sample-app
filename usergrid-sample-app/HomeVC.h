//
//  HomeVC.h
//  usergrid-sample-app
//
//  Created by Michael Hayes on 11/7/13.
//  Copyright (c) 2013 MHayes Design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"
#import "LoginRegisterVC.h"

@class User;

@interface HomeVC : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate> {
    IBOutlet MKMapView* map;
    CLLocationManager* locationManager;
    CLLocationCoordinate2D currentLocation;
    LoginRegisterVC* loginRegVC;
    
    User* user;

}
@property(nonatomic, strong)IBOutlet LoginRegisterVC* loginRegVC;
@property(nonatomic, strong)User* user;
@property(nonatomic, strong)IBOutlet MKMapView* map;
@property(nonatomic, strong)CLLocationManager* locationManager;
@property(nonatomic)CLLocationCoordinate2D currentLocation;


-(void)setMapCurrentLocation:(float)lat lon:(float)lon;
@end
