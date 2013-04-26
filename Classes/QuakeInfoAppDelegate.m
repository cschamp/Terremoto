//
//  QuakeInfoAppDelegate.m
//  QuakeInfo
//
//  Created by Craig Schamp on 7/26/09.
//  Copyright Craig Schamp 2009. All rights reserved.
//

#import "QuakeInfoAppDelegate.h"
#import "QuakeInfoViewController.h"
#import "NetAccessViewController.h"
#import "Reachability.h"

@implementation QuakeInfoAppDelegate

@synthesize window;
@synthesize viewController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    if ([[Reachability sharedReachability] internetConnectionStatus] == NotReachable) {
        // Can't reach the Internet. Inform user that we need the Internet.
        // http://github.com/cschamp/Terremoto/issues/#issue/6
        
        // XXX This is kind of a hack. Normally, we rely on stuff setup in IB
        // XXX to load the "normal" application view controller, with the MapKit view
        // XXX and so on. But in this case, for the time being, just throw that away
        // XXX and create a new view controller that displays the "network unreachable"
        // XXX message. This requires the least amount of change. Make it elegant next.
        // XXX [schamp 20091013]
        
        [viewController release];
        viewController = [[[NetAccessViewController alloc] init] autorelease];
    }
    window.rootViewController = viewController;
    [window makeKeyAndVisible];
}

- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}

@end
