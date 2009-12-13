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
@synthesize viewController;
@synthesize lcTableView, rtTableView, swTableView, coTableView, menuTableView, lcIndexList;

@synthesize rtList, swList, coList, lcList, rrconnection, menuItems;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
	
	application.idleTimerDisabled = YES;
	
	[viewController setDelegate:self];

    // read preferences
	NSUserDefaults *defaults = [[NSUserDefaults standardUserDefaults] retain];
  
    // Optional move event.
	if( [defaults boolForKey:@"moveevents_preference"]) {
		[viewController processAllEvents:[defaults integerForKey:@"vdelta_preference"]];
	}
	[window addSubview:tabBarController.view];	
	
	lcList = [[NSMutableArray array] retain];
	lcIndexList = [[NSMutableArray array] retain];
	
	rtList = [[NSMutableArray array] retain];
	swList = [[NSMutableArray array] retain];
	coList = [[NSMutableArray array] retain];
	menuItems = [[NSMutableArray array] retain];
	

	lcTableView = [[iRocLcTableView alloc] initWithNibName:@"iRocLcTableView" bundle:nil];
	[lcTableView setLcList:self.lcList];
	[lcTableView setDelegate:self];
	[lcTableView setMenuname:@"Locomotives"];

	swTableView = [[iRocSwTableView alloc] initWithNibName:@"iRocSwTableView" bundle:nil];
	[swTableView setSwList:self.swList];
	[swTableView setDelegate:self];
	[swTableView setMenuname:@"Switches"];
	
	rtTableView = [[iRocRtTableView alloc] initWithNibName:@"iRocRtTableView" bundle:nil];
	[rtTableView setRtList:self.rtList];
	[rtTableView setDelegate:self];
	[rtTableView setMenuname:@"Routes"];
	
	coTableView = [[iRocCoTableView alloc] initWithNibName:@"iRocCoTableView" bundle:nil];
	[coTableView setCoList:self.coList];
	[coTableView setDelegate:self];
	[coTableView setMenuname:@"Outputs"];
	
	[menuItems addObject:lcTableView];
	[menuItems addObject:rtTableView];
	[menuItems addObject:swTableView];
	[menuItems addObject:coTableView];
	[menuTableView setMenuItems:menuItems];
	
	// read preferences
	defaults = [[NSUserDefaults standardUserDefaults] retain];
	
	rrconnection = [[IRocConnector alloc] init];
	[rrconnection setDomain:[defaults stringForKey:@"ip_preference"]];
	[rrconnection setPort:[defaults integerForKey:@"port_preference"]];
	[rrconnection setDelegate:self];
	[rrconnection setLocList:self.lcList];
	[rrconnection setLocIndexList:self.lcIndexList];
	[rrconnection setRtList:self.rtList];
	[rrconnection setSwList:self.swList];
	[rrconnection setCoList:self.coList];
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
}


- (void)connectThread { 
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	[rrconnection connect];

	[pool release]; 
} 

// Delegate Methods
- (void)lcListLoaded {
	//NSLog(@"Reload Data in Loc View");
	[lcTableView.tableView reloadData];
}

- (void)rtListLoaded {
	//NSLog(@"Reload Data in Route View");
	[rtTableView.tableView reloadData];
}

- (void)swListLoaded {
	//NSLog(@"Reload Data in Route View");
	[swTableView.tableView reloadData];
}

- (void)coListLoaded {
	//NSLog(@"Reload Data in Route View");
	[coTableView.tableView reloadData];
}

- (void)rtAction:(NSString *)rtid {	
	NSLog(@"rtAction: %@", rtid);
	[rrconnection sendMessage:@"st" message:[[NSString alloc] initWithString: [NSString stringWithFormat: @"<st id=\"%@\" cmd=\"go\"/>", rtid]]];
}

- (void)swAction:(NSString *)swid {	
	NSLog(@"swAction: %@", swid);
	[rrconnection sendMessage:@"sw" message:[[NSString alloc] initWithString: [NSString stringWithFormat: @"<sw id=\"%@\" cmd=\"flip\"/>", swid]]];
}

- (void)coAction:(NSString *)coid {	
	NSLog(@"coAction: %@", coid);
	[rrconnection sendMessage:@"co" message:[[NSString alloc] initWithString: [NSString stringWithFormat: @"<co id=\"%@\" cmd=\"on\"/>", coid]]];
}

- (void)lcAction:(NSString *)lcid {	
	NSLog(@"lcAction: %@", lcid);
	self.viewController.textfieldLoc.text = lcid;
	[self.tabBarController setSelectedViewController:viewController];
	[[NSUserDefaults standardUserDefaults] setObject:(NSString*)[self.viewController.textfieldLoc text] forKey:@"loc_preference"];
	
	[self.tabBarController dismissModalViewControllerAnimated:YES];
	
	Loc *loc = [self.lcList objectAtIndex:[lcIndexList indexOfObject:lcid]];
	UIImage *img = [loc getImage]; //[((Loc*) [self.lcList objectAtIndex:[lcIndexList indexOfObject:lcid]]) getImage];
	
	
	int breite = 60*(img.size.width/img.size.height);
	int diff = 150 - breite;
	CGRect imageframe = CGRectMake(160 + diff,10,breite,60);	
	 
	//[imageview removeFromSuperview];
	
	//CGRect imageframe = CGRectMake(164,21,136,69);
	
	imageview = [[UIImageView alloc] initWithFrame:imageframe];
	imageview.image = img;

	[viewController.view addSubview:imageview];

	[imageview release];
	
	// The new one:
	[viewController.locProps setLoc:loc];
	
	
}

- (void)askForLocpic:(NSString *)lcid withFilename:(NSString*)filename {
	[rrconnection requestLocpic:lcid withFilename:filename];
}

- (void)lcTextFieldAction {
	[self.tabBarController presentModalViewController:lcTableView animated:YES];
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
