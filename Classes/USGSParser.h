//
//  USGSParser.h
//  QuakeInfo
//
//  Created by Craig Schamp on 7/26/09.
//  Copyright 2009 Craig Schamp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Earthquake.h"

@class Earthquake, QuakeInfoViewController;

@protocol USGSParserDelegate

- (void)addEarthquake:(Earthquake *)earthquake;

@end

@interface USGSParser : NSObject {
	NSMutableArray *earthquakeList;
	id<USGSParserDelegate> delegate;
	NSOperationQueue *opQueue;
	Earthquake *currentEarthquake;
	NSMutableString *propertyValue;
}

@property (nonatomic, assign) id<USGSParserDelegate> delegate;
@property (nonatomic, retain) NSOperationQueue *opQueue;
@property (nonatomic, retain) NSMutableString *propertyValue;
@property (nonatomic, retain) Earthquake *currentEarthquake;

+ (id) parser;

- (NSOperationQueue *) opQueue;
- (BOOL)parseForData;

@end
