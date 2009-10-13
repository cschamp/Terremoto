//
//  QuakeInfoViewController.m
//  QuakeInfo
//
//  Created by Craig Schamp on 7/26/09.
//  Copyright Craig Schamp 2009. All rights reserved.
//

#import "QuakeInfoViewController.h"
#import "DetailsViewController.h"

@implementation QuakeInfoViewController

@synthesize mapView;

- (void)viewDidLoad {
    [super viewDidLoad];
    USGSParser *parser = [USGSParser parser];
    parser.delegate = self;
    [parser parseForData];
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
	self.mapView = nil;
    [super dealloc];
}

- (void) zoomToCurrentLocation {
	CLLocationCoordinate2D usercoord = self.mapView.userLocation.location.coordinate;
	MKCoordinateRegion region;
	region.center.latitude = usercoord.latitude;
	region.center.longitude = usercoord.longitude;
	region.span.latitudeDelta = 4.0;	// 1 degree = approx 69 miles.
	region.span.longitudeDelta = 4.0;
	[self.mapView setRegion:region animated:YES];
}

#pragma mark USGSParser Delegates

- (void)addEarthquake:(Earthquake *)earthquake {
	EarthquakeAnnotation *annot = [[[EarthquakeAnnotation alloc] initWithEarthquake:earthquake] autorelease];
	[self.mapView addAnnotation:annot];
}

#pragma mark MKMapView Delegates

#define	quakeAnnotationID @"quakeAnnotationID"

- (MKAnnotationView *)mapView:(MKMapView *)view viewForAnnotation:(id <MKAnnotation>)annotation {
	if (annotation == view.userLocation) {
		// XXX Checking a boolean before zooming seems kind of cheesy. Isn't there an event?
		// XXX If we were using Location Services directly, there would be an event.
		if (initialZoom == NO) {
			[self zoomToCurrentLocation];
			initialZoom = YES;
		}
		return nil;
	}

	EarthquakeAnnotation *annot = (EarthquakeAnnotation *) annotation;
	MKAnnotationView *annotationView = [self.mapView dequeueReusableAnnotationViewWithIdentifier:quakeAnnotationID];
	if (annotationView == nil) {
		// Create a new annotationView since we can't find one to reuse.
		annotationView = [[[MKPinAnnotationView alloc] initWithAnnotation:annot reuseIdentifier:quakeAnnotationID] autorelease];
		// XXX should assert here that annotationView isn't nil
	}
	// Add custom information and properties to the annotation
	float magnitude = [annot.earthquake.magnitude floatValue];
	if (magnitude >= 5.0f) {
		[(MKPinAnnotationView *)annotationView setPinColor:MKPinAnnotationColorRed];
	} else if (magnitude >= 3.0f) {
		[(MKPinAnnotationView *)annotationView setPinColor:MKPinAnnotationColorPurple];
	} else /* if (magnitude >= 2.0f) */ {
		[(MKPinAnnotationView *)annotationView setPinColor:MKPinAnnotationColorGreen];
	}
	[(MKPinAnnotationView *)annotationView setAnimatesDrop:NO];
	// setCanShowCallout:YES enables display of the info box when the pin is selected
	[annotationView setCanShowCallout:YES];
    [annotationView setRightCalloutAccessoryView:[UIButton buttonWithType:UIButtonTypeDetailDisclosure]];
	return annotationView;
}

- (void)mapView:(MKMapView *)view annotationView:(MKAnnotationView *)annotationView calloutAccessoryControlTapped:(UIControl *)control {
	EarthquakeAnnotation *annot = (EarthquakeAnnotation *) [annotationView annotation];
	NSURL *url = [NSURL URLWithString:annot.earthquake.detailsURL];
	DetailsViewController *detailsViewControl = [[[DetailsViewController alloc] init] autorelease];
	detailsViewControl.url = url;
	[self presentModalViewController:detailsViewControl animated:YES];
}

@end
