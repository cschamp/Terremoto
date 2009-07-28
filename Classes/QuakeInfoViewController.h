//
//  QuakeInfoViewController.h
//  QuakeInfo
//
//  Created by Craig Schamp on 7/26/09.
//  Copyright Craig Schamp 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "USGSParser.h"
#import "EarthquakeAnnotation.h"

@interface QuakeInfoViewController : UIViewController <MKMapViewDelegate, USGSParserDelegate> {
  MKMapView *mapView;
}

@property(nonatomic, retain) IBOutlet MKMapView *mapView;

- (void)zoomToCurrentLocation;
- (void)addEarthquake:(Earthquake *)earthquake;
- (void)parserFinished;

@end

