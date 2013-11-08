//
//  Marker.h
//  rackspace-helios-ios7
//
//  Created by Michael Hayes on 11/6/13.
//  Copyright (c) 2013 MHayes Design. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Marker : NSObject <MKAnnotation>

- (id)initWithName:(NSString*)ptName coordinate:(CLLocationCoordinate2D)coordinate;

@end
