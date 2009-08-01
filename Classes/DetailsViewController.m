//
//  DetailsViewController.m
//  QuakeInfo
//
//  Created by Craig Schamp on 7/31/09.
//  Copyright 2009 Craig Schamp. All rights reserved.
//

#import "DetailsViewController.h"


@implementation DetailsViewController

@synthesize webView;
@synthesize toolBar;
@synthesize url;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	[self.webView loadRequest:[[[NSURLRequest alloc] initWithURL:self.url] autorelease]];
}

- (void)webViewDidFinishLoad:(UIWebView *)view {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
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
	self.webView = nil;
}


- (void)dealloc {
    [super dealloc];
}

- (IBAction)doneButtonAction:(id)sender {
	NSLog(@"doneButtonAction");
	[self.webView stopLoading];
	[self dismissModalViewControllerAnimated:YES]; 
}


@end
