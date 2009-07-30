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
@synthesize earthquake;

- (id) initWithEarthquake:(Earthquake *)quake {
	if (self = [super init]) {
		coordinate.latitude = quake.location.coordinate.latitude;
		coordinate.longitude = quake.location.coordinate.longitude;
		self.title = quake.place;

		NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
		[formatter setDateStyle:NSDateFormatterMediumStyle];
		[formatter setTimeStyle:NSDateFormatterMediumStyle];
		// XXX I think this leaks, since subtitle is copied. Double check that logic.
		self.subtitle = [NSString stringWithFormat:@"M%@ // %@", quake.magnitude, [formatter stringFromDate:quake.lastUpdate]];
		self.earthquake = quake;
	}
	return self;
}

@end
