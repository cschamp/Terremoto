//
//  DetailsViewController.h
//  QuakeInfo
//
//  Created by Craig Schamp on 7/31/09.
//  Copyright 2009 Craig Schamp. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DetailsViewController : UIViewController <UIWebViewDelegate> {
	UIWebView *webView;
	UIToolbar *toolBar;
	NSURL *url;
}

@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) IBOutlet UIToolbar *toolBar;
@property (nonatomic, retain) NSURL *url;

- (IBAction)doneButtonAction:(id)sender;

@end
