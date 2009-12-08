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

@synthesize locList, rrconnection;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
	application.idleTimerDisabled = YES;

  // read preferences
	NSUserDefaults *defaults = [[NSUserDefaults standardUserDefaults] retain];
  
  // Optional move event.
	if( [defaults boolForKey:@"moveevents_preference"]) {
		[viewController processAllEvents:[defaults integerForKey:@"vdelta_preference"]];
	}
	[window addSubview:tabBarController.view];	
	
	//locList = [[NSMutableArray array] retain];
	//[rrconnection setLocList:locList];
	
	
	
	NSArray *testarray;
	testarray = [[NSArray arrayWithObjects: @"OneApp", @"TwoApp", @"ThreeApp", nil] retain];
	[locTableViewControllerApp setLocList:testarray];
	

	
	// read preferences
	defaults = [[NSUserDefaults standardUserDefaults] retain];
	
	rrconnection = [[IRocConnector alloc] init];
	[rrconnection setDomain:[defaults stringForKey:@"ip_preference"]];
	[rrconnection setPort:[defaults integerForKey:@"port_preference"]];
	[rrconnection setDelegate:self];
	viewController.textfieldLoc.text = [defaults stringForKey:@"loc_preference"];
	
	
	// Connect Thread
	rrconnection.isConnected = FALSE;
	[NSThread detachNewThreadSelector:@selector(connectThread) toTarget:self withObject:nil]; 
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	
	int retry = 10;
	while( retry > 0 ) {
		NSLog( @"retry=%d isConnected=%d",retry,rrconnection.isConnected);
		retry--;  
		if( rrconnection.isConnected ) {
			[rrconnection requestPlan];
			break;
		} 
		else
			[NSThread sleepForTimeInterval:1];
	}
	
	
	[viewController setRrconnection:self.rrconnection];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

}


- (void)connectThread { 
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	[rrconnection connect];

	[pool release]; 
} 


- (void)lcListLoaded {
	
	NSLog(@"HA #########");
	
}



- (void)dealloc {
	[tabBarController release];
	[rrconnection release];
    [window release];
    [super dealloc];
}


-(void) applicationWillResignActive:(UIApplication *)application {
	//[[self rrconnection] stop];
}

-(void) applicationDidBecomeActive:(UIApplication *)application {
	//[[self rrconnection] connect];
}


@end
