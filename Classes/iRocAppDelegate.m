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
@synthesize rtTableView, swTableView, menuTableView;

@synthesize rtList, swList, locList, rrconnection, menuItems;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
	application.idleTimerDisabled = YES;

  // read preferences
	NSUserDefaults *defaults = [[NSUserDefaults standardUserDefaults] retain];
  
  // Optional move event.
	if( [defaults boolForKey:@"moveevents_preference"]) {
		[viewController processAllEvents:[defaults integerForKey:@"vdelta_preference"]];
	}
	[window addSubview:tabBarController.view];	
	
	locList = [[NSMutableArray array] retain];
	rtList = [[NSMutableArray array] retain];
	swList = [[NSMutableArray array] retain];
	menuItems = [[NSMutableArray array] retain];
	
	[locTableViewControllerApp setLocList:self.locList];

	swTableView = [[iRocSwTableView alloc] initWithNibName:@"iRocSwTableView" bundle:nil];
	[swTableView setSwList:self.swList];
	[swTableView setDelegate:self];
	[swTableView setMenuname:@"Switches"];
	
	rtTableView = [[iRocRtTableView alloc] initWithNibName:@"iRocRtTableView" bundle:nil];
	[rtTableView setRtList:self.rtList];
	[rtTableView setDelegate:self];
	[rtTableView setMenuname:@"Routes"];
	
	[menuItems addObject:rtTableView];
	[menuItems addObject:swTableView];
	[menuTableView setMenuItems:menuItems];
	
	
	// read preferences
	defaults = [[NSUserDefaults standardUserDefaults] retain];
	
	rrconnection = [[IRocConnector alloc] init];
	[rrconnection setDomain:[defaults stringForKey:@"ip_preference"]];
	[rrconnection setPort:[defaults integerForKey:@"port_preference"]];
	[rrconnection setDelegate:self];
	[rrconnection setLocList:self.locList];
	[rrconnection setRtList:self.rtList];
	[rrconnection setSwList:self.swList];
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

// Delegate Methods
- (void)lcListLoaded {
	NSLog(@"Reload Data in Loc View");
	[locTableViewControllerApp.tableView reloadData];
}

- (void)rtListLoaded {
	NSLog(@"Reload Data in Route View");
	[rtTableView.tableView reloadData];
}

- (void)rtAction:(NSString *)rtid {	
	NSLog(@"rtAction: %@", rtid);
	[rrconnection sendMessage:@"st" message:[[NSString alloc] initWithString: [NSString stringWithFormat: @"<st id=\"%@\" cmd=\"go\"/>", rtid]]];
}

- (void)swAction:(NSString *)swid {	
	NSLog(@"swAction: %@", swid);
	[rrconnection sendMessage:@"sw" message:[[NSString alloc] initWithString: [NSString stringWithFormat: @"<sw id=\"%@\" cmd=\"flip\"/>", swid]]];
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
