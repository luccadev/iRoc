//
//  iRocAppDelegate.m
//  iRoc
//
//  Created by Jean-Michel Fischer on 17.11.09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "iRocAppDelegate.h"
#import "iRocViewController.h"

@implementation iRocAppDelegate

@synthesize window;
//@synthesize viewController;
@synthesize tabBarController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    //[window addSubview:viewController.view];
    //[window makeKeyAndVisible];
	[window addSubview:tabBarController.view];
}


- (void)dealloc {
    //[viewController release];
	[tabBarController release];
    [window release];
    [super dealloc];
}


@end
