//
//  EarthquakeAnnotation.m
//  QuakeInfo
//
//  Created by Craig Schamp on 7/28/09.
//  Copyright 2009 Craig Schamp. All rights reserved.
//

#import "EarthquakeAnnotation.h"

@implementation EarthquakeAnnotation

@synthesize coordinate;
@synthesize title;
@synthesize subtitle;

- (id) initWithEarthquake:(Earthquake *)earthquake {
	if (self = [super init]) {
		coordinate.latitude = earthquake.location.coordinate.latitude;
		coordinate.longitude = earthquake.location.coordinate.longitude;
		self.title = earthquake.place;
		// XXX use NSDateFormatter
		self.subtitle = [NSString stringWithFormat:@"%@ M%@", earthquake.lastUpdate, earthquake.magnitude];
	}
	return self;
}

@end
