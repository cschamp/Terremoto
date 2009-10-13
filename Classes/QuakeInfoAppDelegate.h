//
//  QuakeInfoAppDelegate.h
//  QuakeInfo
//
//  Created by Craig Schamp on 7/26/09.
//  Copyright Craig Schamp 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QuakeInfoViewController;

@interface QuakeInfoAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UIViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UIViewController *viewController;

@end

