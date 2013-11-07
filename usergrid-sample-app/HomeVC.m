//
//  HomeVC.m
//  usergrid-sample-app
//
//  Created by Michael Hayes on 11/7/13.
//  Copyright (c) 2013 MHayes Design. All rights reserved.
//

#import "HomeVC.h"
#import "User.h"

#define METERS_PER_MILE 1609.344

@interface HomeVC ()

@end

@implementation HomeVC
@synthesize map, locationManager, loginRegVC, user;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.map = MKMapView.new;
    self.map.mapType = MKMapTypeHybrid;
    self.map.delegate = self;
    
    //NSLog(@"%lu", self.map.mapType);
    
    [self startStandardUpdates];
    
    [self setMapCurrentLocation:self.locationManager.location.coordinate.latitude
                            lon:self.locationManager.location.coordinate.longitude];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:true];
    
    if (self.user.loggedIn==false) {
        self.loginRegVC = LoginRegisterVC.new;
        self.loginRegVC.user = self.user;
        [self presentViewController:self.loginRegVC animated:true completion:nil];
    }
}

- (void)startStandardUpdates
{
    if (nil == self.locationManager)
        self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    
    self.locationManager.distanceFilter = 500; // meters
    
    [self.locationManager startUpdatingLocation];
}

-(void)setMapCurrentLocation:(float)lat lon:(float)lon
{
    currentLocation = CLLocationCoordinate2DMake(lat, lon);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(currentLocation,
                                                                   0.5*METERS_PER_MILE,
                                                                   0.5*METERS_PER_MILE);
    [self.map setRegion:region animated:true];
}
@end
