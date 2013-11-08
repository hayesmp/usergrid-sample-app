//
//  HomeVC.m
//  usergrid-sample-app
//
//  Created by Michael Hayes on 11/7/13.
//  Copyright (c) 2013 MHayes Design. All rights reserved.
//

#import "HomeVC.h"
#import "User.h"
#import "LoginRegisterVC.h"
#import "Marker.h"

#define METERS_PER_MILE 1609.344

@interface HomeVC ()

@end

@implementation HomeVC
@synthesize map, locationManager, loginRegVC, user, currLatitude, currLongitude;
@synthesize currentLocation = _currentLocation;

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
    
    //self.map = MKMapView.new;
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
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    self.locationManager.distanceFilter = 5; // meters
    
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"%f, %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    
    [self setMapCurrentLocation:newLocation.coordinate.latitude lon:newLocation.coordinate.longitude];

}

- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error
{
    
}

-(void)setMapCurrentLocation:(float)lat lon:(float)lon
{
    self.currentLocation = CLLocationCoordinate2DMake(lat, lon);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.currentLocation,
                                                                   0.5*METERS_PER_MILE,
                                                                   0.5*METERS_PER_MILE);
    [self.map setRegion:region animated:true];
    NSLog(@"map center: %f, %f", self.map.centerCoordinate.latitude, self.map.centerCoordinate.longitude);
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[Marker class]]) {
        
        MKPinAnnotationView* pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"ID1"];
        if (!pinView) {
            MKPinAnnotationView* customPinView = [[MKPinAnnotationView alloc]
                                                   initWithAnnotation:annotation reuseIdentifier:@"ID1"];
            customPinView.pinColor = MKPinAnnotationColorRed;
            customPinView.animatesDrop = YES;
            customPinView.canShowCallout = YES;
            //customPinView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            
            return customPinView;
            
        } else {
            pinView.annotation = annotation;
        }
    }
    return nil;
}

-(IBAction)refresh:(id)sender
{
    
}

-(IBAction)checkIn:(id)sender
{
    //create an entity object
	NSMutableDictionary *entity = [[NSMutableDictionary alloc] init ];
	
	//Set entity properties
	[entity setObject:@"map_marker" forKey:@"type"]; //Required. New entity type to create
	[entity setObject:self.user.name forKey:@"label"];
	[entity setObject:[NSString stringWithFormat:@"%f", self.currentLocation.latitude] forKey:@"latitude"];
    [entity setObject:[NSString stringWithFormat:@"%f", self.currentLocation.longitude] forKey:@"longitude"];
    [entity setObject:[self uuid] forKey:@"name"];
	
	AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	//call createEntity to initiate the API call
	ApigeeClientResponse *response = [appDelegate.dataClient createEntity:entity];
	
	@try {
	    NSLog(@"%@", response.rawResponse);
        Marker *annotation = [[Marker alloc] initWithName:self.user.name coordinate:self.currentLocation];
        [self.map addAnnotation:annotation];
        for (Marker* point in self.map.annotations) {
            NSLog(@"%@ %f, %f", point.title, point.coordinate.latitude, point.coordinate.longitude);
        }
	}
	@catch (NSException * e) {
	    UIAlertView* syncFail = [[UIAlertView alloc] initWithTitle:@"Sync Failure" message:e.description delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [syncFail show];
	}
}

-(NSString*)uuid
{
    NSString* str;
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: 10];
    for (int i=0; i<10; i++)
        [randomString appendFormat: @"%c", [letters characterAtIndex: arc4random()%[letters length]]];
    str = [NSString stringWithFormat:@"%@", randomString];
    return str;
}
@end
