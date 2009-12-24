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
@synthesize lcTableView, rtTableView, swTableView, coTableView, menuTableView;

@synthesize rtList, coList, rrconnection, menuItems, aboutView, swContainer, lcContainer;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
  NSLog(@"applicationDidFinishLaunching");

	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
	[[UIApplication sharedApplication] setStatusBarHidden:FALSE];
	
	application.idleTimerDisabled = YES;
	
	[viewController setDelegate:self];

    // read preferences
	NSUserDefaults *defaults = [[NSUserDefaults standardUserDefaults] retain];
  
    // Optional move event.
	if( [defaults boolForKey:@"moveevents_preference"]) {
		[viewController processAllEvents:[defaults integerForKey:@"vdelta_preference"]];
	}
	[window addSubview:tabBarController.view];	
	
	//lcList = [[NSMutableArray array] retain];
	//lcIndexList = [[NSMutableArray array] retain];
	
	rtList = [[NSMutableArray array] retain];
	
	swContainer = [[[Container alloc] init] retain];
	lcContainer = [[[Container alloc] init] retain];
	
	coList = [[NSMutableArray array] retain];
	menuItems = [[NSMutableArray array] retain];
	

	lcTableView = [[iRocLcTableView alloc] initWithNibName:@"iRocLcTableView" bundle:nil];
	[lcTableView setLcContainer:self.lcContainer];
	[lcTableView setDelegate:self];
	[lcTableView setMenuname:@"Locomotives"];

	swTableView = [[iRocSwTableView alloc] initWithNibName:@"iRocSwTableView" bundle:nil];
	//[swTableView setSwList:self.swList];
	//[swTableView setSwList:[swContainer objectList]];
	[swTableView setSwContainer:self.swContainer];
	
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
	[rrconnection setLcContainer:self.lcContainer];
	//[rrconnection setLocIndexList:self.lcIndexList];
	[rrconnection setRtList:self.rtList];
	//[rrconnection setSwList:self.swList];
	[rrconnection setSwContainer:swContainer];
	//[rrconnection setSwIndexList:self.swIndexList];
	[rrconnection setCoList:self.coList];
	viewController.textfieldLoc.text = [defaults stringForKey:@"loc_preference"];
	
	// Connect Thread
	rrconnection.isConnected = FALSE;
	[NSThread detachNewThreadSelector:@selector(connectThread) toTarget:self withObject:nil]; 
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	
	int retry = 11;
	while( retry > 0 ) {
		NSLog( @"retry=%d isConnected=%d",retry,rrconnection.isConnected);
		retry--;  
		if( rrconnection.readyConnecting ) {
  		NSLog( @"ready connecting: isConnected=%d",rrconnection.isConnected);
			break;
		} 
		else
			[NSThread sleepForTimeInterval:1];
	}

  NSLog( @"end of retry loop: isConnected=%d readyConnecting=%d",rrconnection.isConnected,rrconnection.readyConnecting);
  if( rrconnection.isConnected ) {
    NSLog( @"connected; request plan");
    [rrconnection requestPlan];
  }
  else {
    // no connection possible: show a message or jump to the Info Page. (Extend the info page with connection details...)
    NSLog( @"no connection: offline");
    [self.tabBarController setSelectedViewController:aboutView];
  }
  
  [viewController setRrconnection:self.rrconnection];
}


- (void)connectThread { 
  NSLog( @"connectThread started");
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	[rrconnection connect];

	[pool release]; 
  NSLog( @"connectThread ended");
} 

// Delegate Methods
- (void)lcListLoaded {
	//NSLog(@"Reload Data in Loc View");
	[lcTableView.tableView reloadData];
}

- (void)lcListReloadRow:(NSNumber*)row {
	//NSLog(@"Reload Data in Loc View");
  NSIndexPath* indexPath = [NSIndexPath indexPathForRow:[row intValue] inSection:0];
  [lcTableView addCellImage:indexPath];
  
  //[lcTableView.tableView reloadRowsAtIndexPaths:[NSArray	arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
  
  [viewController.locProps imageLoaded];
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
	
	//Loc *loc = [self.lcList objectAtIndex:[lcIndexList indexOfObject:lcid]];
	Loc *loc = (Loc*) [self.lcContainer objectWithId:lcid];

	// The new one:
	[viewController.locProps setLoc:loc];
}

- (Loc*)getLoc:(NSString *)lcid {
	NSLog(@"getLoc for: %@ 0x%08X", lcid, lcContainer);
  if( lcid != NULL ) {
	  return (Loc*) [self.lcContainer objectWithId:lcid];
  }
  return nil;
}

- (void)askForAllLocPics {
	int i;
	for( i = 0; i< [lcContainer count]; i++){	
		Loc *loc;
		loc = (Loc*)[lcContainer objectAtIndex:i];
		if( loc.hasImage && ![loc.imgname isEqualToString:@""] ) {
			[self askForLocpic:loc.locid withFilename:loc.imgname];
		}
	}	
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
	NSLog(@"applicationWillResignActive");
	[[self rrconnection] stop];
	exit(0);
}

-(void) applicationDidBecomeActive:(UIApplication *)application {
	NSLog(@"applicationDidBecomeActive");
	//[[self rrconnection] connect];
	//[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
}


@end
