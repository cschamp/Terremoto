//
//  EarthquakeAnnotation.h
//  QuakeInfo
//
//  Created by Craig Schamp on 7/28/09.
//  Copyright 2009 Craig Schamp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Earthquake.h"


@interface EarthquakeAnnotation : NSObject <MKAnnotation> {
	CLLocationCoordinate2D coordinate;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (id) initWithEarthquake:(Earthquake *)earthquake;

@end
