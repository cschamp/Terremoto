//
//  Earthquake.h
//  QuakeInfo
//
//  Created by Craig Schamp on 7/26/09.
//  Copyright 2009 Craig Schamp. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface Earthquake : NSObject {
	NSString *detailsURL;
	NSNumber *magnitude;
	NSString *place;
	CLLocation *location;
	NSDate *lastUpdate;
}

@property (nonatomic, copy) NSString *detailsURL;
@property (nonatomic, copy) NSNumber *magnitude;
@property (nonatomic, copy) NSString *place;
@property (nonatomic, retain) CLLocation *location;
@property (nonatomic, retain) NSDate *lastUpdate;

@end
