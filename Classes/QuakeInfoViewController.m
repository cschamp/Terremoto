//
//  QuakeInfoViewController.m
//  QuakeInfo
//
//  Created by Craig Schamp on 7/26/09.
//  Copyright Craig Schamp 2009. All rights reserved.
//

#import "QuakeInfoViewController.h"

@implementation QuakeInfoViewController

@synthesize mapView;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	USGSParser *parser = [USGSParser parser];
	parser.delegate = self;
	[parser parseForData];
	// This really should run later, after we have annotations on the map.
	// At this point in time, we don't yet know the user location.
	[self zoomToCurrentLocation];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

- (void) zoomToCurrentLocation {
	if (self.mapView.userLocation.updating == NO) {
		CLLocationCoordinate2D usercoord = self.mapView.userLocation.location.coordinate;
		MKCoordinateRegion region;
		region.center.latitude = usercoord.latitude;
		region.center.longitude = usercoord.longitude;
		region.span.latitudeDelta = 2 * 70.0;	// 1 degree = approx 69 miles.
		region.span.longitudeDelta = 2 * 70.0;
		[self.mapView setRegion:region];
	}
}

#pragma mark USGSParser Delegates

- (void)addEarthquake:(Earthquake *)earthquake {
	EarthquakeAnnotation *annot = [[[EarthquakeAnnotation alloc] initWithEarthquake:earthquake] autorelease];
	[self.mapView addAnnotation:annot];
	NSLog([earthquake description]);
}

- (void)parserFinished {
	NSLog(@"Parser finished");
	[self zoomToCurrentLocation];
}

@end
