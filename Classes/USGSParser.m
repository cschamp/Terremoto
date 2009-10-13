//
//  USGSParser.m
//  QuakeInfo
//
//  Created by Craig Schamp on 7/26/09.
//  Copyright 2009 Craig Schamp. All rights reserved.
//


#import "QuakeInfoViewController.h"
#import "Earthquake.h"
#import "USGSParser.h"

static NSString *feedURLString = @"http://earthquake.usgs.gov/eqcenter/catalogs/7day-M2.5.xml";

@implementation USGSParser

@synthesize delegate;
@synthesize opQueue;
@synthesize currentEarthquake;
@synthesize propertyValue;

+(id) parser {
	return [[[self class] alloc] init];
}

- (void)dealloc {
	self.currentEarthquake = nil;
	self.propertyValue = nil;
 	self.delegate = nil;
	self.opQueue = nil;
	[super dealloc];
}

#pragma mark Managing the Parser Operations

- (NSOperationQueue *) opQueue {
	if (self.opQueue == nil) {
		self.opQueue = [[NSOperationQueue alloc] init];
	}
	return self.opQueue;
}

- (void)fetchData {
	NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self 
																	 selector:@selector(parseForData) 
																	   object:nil];
	[self.opQueue addOperation:op];
	[op release];
}

// this method is fired by the operation created in
// getEarthquakeData so its on an alternate thread
- (BOOL)parseForData {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	NSURL *url = [NSURL URLWithString:feedURLString];
	BOOL success = NO;
	NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
	[parser setDelegate:self];
	[parser setShouldProcessNamespaces:NO];
	[parser setShouldReportNamespacePrefixes:NO];
	[parser setShouldResolveExternalEntities:NO];
	success = [parser parse];
	NSError *parseError = [parser parserError];
	if (parseError) {
		NSLog(@"parse error = %@", parseError);
	}
	[parser release];
	[pool drain];
	return success;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[self autorelease];
}

#pragma mark Parsing the Data

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict {

	if (qName != nil) {
		elementName = qName; // swap for the qName if we have a name space
	}

	if ([elementName isEqualToString:@"entry"]) {
		self.currentEarthquake = [[[Earthquake alloc] init] autorelease];
	} else if ([elementName isEqualToString:@"link"]) {
		// ignore the related content and just grab the alternate
		if ([[attributeDict valueForKey:@"rel"] isEqualToString:@"alternate"]) {
			NSString *link = [attributeDict valueForKey:@"href"];
			self.currentEarthquake.detailsURL = 
			[NSString stringWithFormat:@"http://earthquake.usgs.gov/%@", link];     // XXX Put constant DNS name in a header
		}
	} else if ([elementName isEqualToString:@"title"] || 
		[elementName isEqualToString:@"updated"] ||
		[elementName isEqualToString:@"georss:point"]) {
		self.propertyValue = [NSMutableString string];
	} else {
		self.propertyValue = nil;
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if (self.propertyValue != nil) {
		[self.propertyValue appendString:string];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
	namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {     

	if (qName) {
		elementName = qName; // switch for the qName
	}

	if ([elementName isEqualToString:@"title"]) {
		//<title>M 5.8, Banda Sea</title>
		NSArray *components = [self.propertyValue componentsSeparatedByString:@","];
		if (components.count > 1) {
			// strip the M
			NSString *magString = [[[components objectAtIndex:0] componentsSeparatedByString:@" "] objectAtIndex:1];
			NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
			self.currentEarthquake.magnitude = [formatter numberFromString:magString];
			self.currentEarthquake.place = [components objectAtIndex:1];
			[formatter release];
		}
	} else if ([elementName isEqualToString:@"updated"]) {
		//<updated>2008-04-29T19:10:01Z</updated>
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
		self.currentEarthquake.lastUpdate = [formatter dateFromString:self.propertyValue];
		[formatter release];
	} else if ([elementName isEqualToString:@"georss:point"]) {
		NSArray *comp = [self.propertyValue componentsSeparatedByString:@" "];
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		NSNumber *latituide = [formatter numberFromString:[comp objectAtIndex:0]];
		NSNumber *longitude = [formatter numberFromString:[comp objectAtIndex:1]];
		[formatter release];
		CLLocation *location = [[CLLocation alloc] initWithLatitude:latituide.floatValue
														  longitude:longitude.floatValue];
		self.currentEarthquake.location = location;
		[location release];
	} else if([elementName isEqualToString:@"entry"]) {
		[(id)[self delegate] performSelectorOnMainThread:@selector(addEarthquake:)
											  withObject:self.currentEarthquake
										   waitUntilDone:NO];
	}
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	if (parseError.code != NSXMLParserDelegateAbortedParseError) {
		NSLog(@"parser error %@, userInfo %@", parseError, [parseError userInfo]);
	}
}

@end