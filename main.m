//
//  main.m
//  QuakeInfo
//
//  Created by Craig Schamp on 7/26/09.
//  Copyright Craig Schamp 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuakeInfoAppDelegate.h"

int main(int argc, char *argv[]) {
    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, NSStringFromClass([QuakeInfoAppDelegate class]));
    [pool release];
    return retVal;
}
