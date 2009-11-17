//
//  DetailsViewController.m
//  QuakeInfo
//
//  Created by Craig Schamp on 7/31/09.
//  Copyright 2009 Craig Schamp. All rights reserved.
//

#import <MobileCoreServices/UTCoreTypes.h>
#import "DetailsViewController.h"

@implementation DetailsViewController

@synthesize webView;
@synthesize toolBar;
@synthesize url;

- (void)viewDidLoad {
    [super viewDidLoad];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	[self.webView loadRequest:[[[NSURLRequest alloc] initWithURL:self.url] autorelease]];
}

- (void)webViewDidFinishLoad:(UIWebView *)view {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	NSLog(@"didFailLoadWithError");
	// XXX Do something. [schamp 20090801]
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	self.webView = nil;
}

- (void)dealloc {
	self.webView = nil;
	self.toolBar = nil;
	self.url = nil;
    [super dealloc];
}

- (IBAction)doneButtonAction:(id)sender {
	[self.webView stopLoading];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[self dismissModalViewControllerAnimated:YES]; 
}

- (IBAction)actionButtonAction:(id)sender {
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Details URL Action"
                                                    delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                                    destructiveButtonTitle:@"Open in Safari"
                                                    otherButtonTitles:@"Copy URL", nil];
	[actionSheet showInView:self.view];
	[actionSheet release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == [actionSheet destructiveButtonIndex])
        [[UIApplication sharedApplication] openURL:self.url];
    else if (buttonIndex != [actionSheet cancelButtonIndex])	// XXX Should check specifically for Copy button. [schamp 20090801]
        [[UIPasteboard generalPasteboard] setValue:self.url forPasteboardType:(NSString *)kUTTypeURL];	// XXX NSString cast shouldn't be required. [schamp 20090801]
}

@end
