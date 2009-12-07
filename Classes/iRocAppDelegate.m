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
@synthesize locTableViewControllerApp;
@synthesize viewController;

@synthesize locList;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
	application.idleTimerDisabled = YES;

  // read preferences
	NSUserDefaults *defaults = [[NSUserDefaults standardUserDefaults] retain];
  
  // Optional move event.
	if( [defaults boolForKey:@"moveevents_preference"]) {
		//[(iRocViewController*) [tabBarController.viewControllers objectAtIndex:0] processAllEvents: [defaults integerForKey:@"vdelta_preference"]];
		[viewController processAllEvents:[defaults integerForKey:@"vdelta_preference"]];
	}
	[window addSubview:tabBarController.view];	
	
	NSArray *testarray;
	testarray = [[NSArray arrayWithObjects: @"OneApp", @"TwoApp", @"ThreeApp", nil] retain];
	[locTableViewControllerApp setLocList:testarray];
	
	/*
	//[viewController setRrconnection:[[IRocConnector alloc] init]];
	
	
	self.locList = [[NSMutableArray array] retain];
	
	NSLog(@" Pointer %d", self.locList);
	
	[[viewController rrconnection] setLocList:self.locList];
	
	NSLog(@" Pointer %d", [[viewController rrconnection] locList]);
	
	
	//((iRocLocTableViewController*) [tabBarController.viewControllers objectAtIndex:1]).locList = [[(iRocViewController*) [tabBarController.viewControllers objectAtIndex:0] rrconnection] locList];
	
	
	//testarray = [[(iRocViewController*) [tabBarController.viewControllers objectAtIndex:0] rrconnection] locList];

	NSLog(@" ccc %d", [[[viewController rrconnection] locList] count]);
	
	[locTableViewController setLocList:self.locList];
	*/
}


- (void)dealloc {
	[tabBarController release];
    [window release];
    [super dealloc];
}


-(void) applicationWillResignActive:(UIApplication *)application {
	[[viewController rrconnection] stop];
}

-(void) applicationDidBecomeActive:(UIApplication *)application {
	[[viewController rrconnection] connect];
}


@end
