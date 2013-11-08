//
//  Marker.m
//  rackspace-helios-ios7
//
//  Created by Michael Hayes on 11/6/13.
//  Copyright (c) 2013 MHayes Design. All rights reserved.
//

#import "Marker.h"

@interface Marker ()
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) CLLocationCoordinate2D theCoordinate;
@end

@implementation Marker

- (id)initWithName:(NSString*)ptName coordinate:(CLLocationCoordinate2D)coordinate {
    if ((self = [super init])) {
        if ([ptName isKindOfClass:[NSString class]]) {
            self.title = ptName;
        }
        self.theCoordinate = coordinate;
    }
    return self;
}

- (NSString *)title {
    return _title;
}

- (CLLocationCoordinate2D)coordinate {
    return _theCoordinate;
}


@end
