//
//  iRocAppDelegate.m
//  iRoc
//
//  Created by Jean-Michel Fischer on 17.11.09.
//  Copyright rocrail.net 2009. All rights reserved.
//

#import "iRocAppDelegate.h"
#import "iRocViewController.h"

@implementation iRocAppDelegate

@synthesize window;
@synthesize tabBarController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
	application.idleTimerDisabled = YES;

  // read preferences
	NSUserDefaults *defaults = [[NSUserDefaults standardUserDefaults] retain];
  
  // Optional move event.
  if( [defaults boolForKey:@"moveevents_preference"])
  	[(iRocViewController*) [tabBarController.viewControllers objectAtIndex:0] processAllEvents: [defaults integerForKey:@"vdelta_preference"]];
	
	[window addSubview:tabBarController.view];	
}


- (void)dealloc {
	[tabBarController release];
    [window release];
    [super dealloc];
}


-(void) applicationWillResignActive:(UIApplication *)application {
	[[(iRocViewController*) [tabBarController.viewControllers objectAtIndex:0] rrconnection] stop];
}

-(void) applicationDidBecomeActive:(UIApplication *)application {
	[[(iRocViewController*) [tabBarController.viewControllers objectAtIndex:0] rrconnection] connect];
}


@end
