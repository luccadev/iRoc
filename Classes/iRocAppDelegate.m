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
@synthesize lcTableView, rtTableView, swTableView, coTableView, bkTableView, scTableView, menuTableView, systemView, lcAutoView, lcSettingsView;

@synthesize coContainer, rrconnection, menuItems, aboutView, swContainer, lcContainer, rtContainer, bkContainer, scContainer;

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
	
  systemView = [[iRocSystemView alloc] init];
  lcAutoView = [[iRocLcAutoView alloc] init];
  lcSettingsView = [[iRocLcSettingsView alloc] init];

  viewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:
                               NSLocalizedString(@"Loco", @"")
                              image:[UIImage imageNamed:@"loco.png"] tag:1];

  menuTableView.tabBarItem = [[UITabBarItem alloc] initWithTitle:
                               NSLocalizedString(@"Menu", @"")
                                                            image:[UIImage imageNamed:@"menu.png"] tag:3];
  
  aboutView.tabBarItem = [[UITabBarItem alloc] initWithTitle:
                              NSLocalizedString(@"Info", @"")
                                                           image:[UIImage imageNamed:@"info.png"] tag:4];
  
  NSMutableArray* views = [[NSMutableArray alloc] init];
  [views addObjectsFromArray:tabBarController.viewControllers];

  UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:[views objectAtIndex:0]];
  navi.navigationBar.tintColor = [UIColor blackColor];

  UIBarButtonItem *lcAutoButton = [[[UIBarButtonItem alloc]
                                initWithTitle: NSLocalizedString(@"Automatic", @"")
                                style:UIBarButtonItemStylePlain
                                target: self
                                action: @selector(pushLcAuto)] autorelease];
  
  viewController.navigationItem.rightBarButtonItem = lcAutoButton;
  
  UIBarButtonItem *lcSettingsButton = [[[UIBarButtonItem alloc]
                                initWithTitle: NSLocalizedString(@"Settings", @"")
                                style:UIBarButtonItemStylePlain
                                target: self
                                action: @selector(pushLcSettings)] autorelease];
  
  viewController.navigationItem.leftBarButtonItem = lcSettingsButton;

    //viewController.title = @"Loco";
  
  
  
    //systemView.navigationItem.rightBarButtonItem = lcButton;
  
    // Tab 1 = Loco
    // Tab 2 = System
    // Tab 3 = Menu
    // Tab 4 = Info
  [views replaceObjectAtIndex:0 withObject:navi];
  [views replaceObjectAtIndex:3 withObject:[views objectAtIndex:2]];
  [views replaceObjectAtIndex:2 withObject:[views objectAtIndex:1]];
  [views replaceObjectAtIndex:1 withObject:systemView];
  tabBarController.viewControllers = views;
  
  
	[window addSubview:tabBarController.view];

  
  
  rtContainer = [[[Container alloc] init] retain];
	swContainer = [[[Container alloc] init] retain];
	lcContainer = [[[Container alloc] init] retain];
	coContainer = [[[Container alloc] init] retain];
	bkContainer = [[[Container alloc] init] retain];
	scContainer = [[[Container alloc] init] retain];

  lcAutoView.bkContainer = bkContainer;
  lcAutoView.scContainer = scContainer;

	menuItems = [[NSMutableArray array] retain];
	

	lcTableView = [[iRocLcTableView alloc] initWithNibName:@"iRocLcTableView" bundle:nil];
	[lcTableView setLcContainer:self.lcContainer];
	[lcTableView setDelegate:self];
	[lcTableView setMenuname:NSLocalizedString(@"Locomotives", @"")];

	swTableView = [[iRocSwTableView alloc] initWithNibName:@"iRocSwTableView" bundle:nil];
	[swTableView setSwContainer:self.swContainer];
	
	[swTableView setDelegate:self];
	[swTableView setMenuname:NSLocalizedString(@"Switches", @"")];
	
	rtTableView = [[iRocRtTableView alloc] initWithNibName:@"iRocRtTableView" bundle:nil];
	[rtTableView setRtContainer:self.rtContainer];
	[rtTableView setDelegate:self];
	[rtTableView setMenuname:NSLocalizedString(@"Routes", @"")];
	
	coTableView = [[iRocCoTableView alloc] initWithNibName:@"iRocCoTableView" bundle:nil];
	[coTableView setCoContainer:self.coContainer];
	[coTableView setDelegate:self];
	[coTableView setMenuname:NSLocalizedString(@"Outputs", @"")];
	
	bkTableView = [[iRocBkTableView alloc] init];
	[bkTableView setBkContainer:self.bkContainer];
	[bkTableView setDelegate:self];
	[bkTableView setMenuname:NSLocalizedString(@"Blocks", @"")];
	
	scTableView = [[iRocScTableView alloc] init];
	[scTableView setScContainer:self.scContainer];
	[scTableView setDelegate:self];
	[scTableView setMenuname:NSLocalizedString(@"Schedules", @"")];
	
	[menuItems addObject:lcTableView];
	[menuItems addObject:rtTableView];
	[menuItems addObject:swTableView];
	[menuItems addObject:coTableView];
	[menuItems addObject:bkTableView];
	[menuItems addObject:scTableView];
	[menuTableView setMenuItems:menuItems];
	
	// read preferences
	defaults = [[NSUserDefaults standardUserDefaults] retain];
	
	rrconnection = [[IRocConnector alloc] init];
	[rrconnection setDomain:[defaults stringForKey:@"ip_preference"]];
	[rrconnection setPort:[defaults integerForKey:@"port_preference"]];
	[rrconnection setDelegate:self];
	[rrconnection setLcContainer:self.lcContainer];
	[rrconnection setRtContainer:self.rtContainer];
	[rrconnection setSwContainer:self.swContainer];
	[rrconnection setCoContainer:self.coContainer];
	[rrconnection setBkContainer:self.bkContainer];
	[rrconnection setScContainer:self.scContainer];
	viewController.textfieldLoc.text = [defaults stringForKey:@"loc_preference"];
  viewController.imageviewLoc = nil;
  
  systemView.rrconnection = rrconnection;
  lcAutoView.rrconnection = rrconnection;
  lcSettingsView.rrconnection = rrconnection;
	
	// Connect Thread
	rrconnection.isConnected = FALSE;
	[NSThread detachNewThreadSelector:@selector(connectThread) toTarget:self withObject:nil]; 
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	
	while( !rrconnection.readyConnecting ) {
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
    connectAlert = [[UIAlertView alloc] 
                   initWithTitle:@"Warning" 
                   message:[NSString stringWithFormat: 
                           @"Could not connect to %@:%d.\nPlease check the Settings.\niRoc will exit.",[rrconnection domain], [rrconnection port]] 
                   delegate:self 
                   cancelButtonTitle:nil 
                   otherButtonTitles:@"OK",nil];
    [connectAlert show];
  }
  
  [viewController setRrconnection:self.rrconnection];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  if( alertView == connectAlert ) {
    exit(0);
  }
}


- (void)connectThread { 
  NSLog( @"connectThread started");
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	[rrconnection connect];

	[pool release]; 
  NSLog( @"connectThread ended");
} 


- (void)pushLcAuto {
  [viewController.navigationController pushViewController: lcAutoView animated:YES];
}

- (void)pushLcSettings {
  [viewController.navigationController pushViewController: lcSettingsView animated:YES];
}

  // Delegate Methods
- (void)lcListLoaded {
	//NSLog(@"Reload Data in Loc View");
	[lcTableView.tableView reloadData];
}

- (void)lcListUpdateCell:(Loc *)loc {
	NSLog(@"update loco cell...");
  [lcTableView addCellLocoImage:loc];
  
	NSLog(@"informing locProps of image...");
  [viewController.locProps imageLoaded];
}

- (void)setSelectedLoc:(Loc *)loc {
  lcAutoView.loc = loc;
  lcSettingsView.loc = loc;
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

- (void)bkListLoaded {
	[bkTableView.tableView reloadData];
}

- (void)scListLoaded {
	[scTableView.tableView reloadData];
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
	// TODO: we need a flip command in rocrail ...
	[rrconnection sendMessage:@"co" message:[[NSString alloc] initWithString: [NSString stringWithFormat: @"<co id=\"%@\" cmd=\"flip\"/>", coid]]];
}

- (void)bkAction:(NSString *)bkid {	
	NSLog(@"bkAction: %@", bkid);
    // TODO: we need a flip command in rocrail ...
    //[rrconnection sendMessage:@"co" message:[[NSString alloc] initWithString: [NSString stringWithFormat: @"<co id=\"%@\" cmd=\"flip\"/>", coid]]];
}

- (void)scAction:(NSString *)scid {	
	NSLog(@"scAction: %@", scid);
    // TODO: we need a flip command in rocrail ...
    //[rrconnection sendMessage:@"co" message:[[NSString alloc] initWithString: [NSString stringWithFormat: @"<co id=\"%@\" cmd=\"flip\"/>", coid]]];
}

- (void)lcAction:(NSString *)lcid {	
	NSLog(@"lcAction: %@", lcid);
	self.viewController.textfieldLoc.text = lcid;
	[self.tabBarController setSelectedViewController:viewController.navigationController];
	[[NSUserDefaults standardUserDefaults] setObject:(NSString*)[self.viewController.textfieldLoc text] forKey:@"loc_preference"];
	
	[self.tabBarController dismissModalViewControllerAnimated:YES];
	Loc *loc = (Loc*) [self.lcContainer objectWithId:lcid];

	// The new one:
	[viewController.locProps setLoc:loc];
	[viewController updateFnState];
  [lcSettingsView setLoco:loc];
  [lcAutoView setLoco:loc];
	//[self locSetSlider];
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

- (void)locSetSlider{

	if( ((Loc*)[viewController.locProps getLoc]) != NULL) {
		NSLog( @"LLLLLLL: %@", ((Loc*)[viewController.locProps getLoc]).locid);
	
		Loc *lc = (Loc*)[viewController.locProps getLoc];

	//if( [lcidi isEqualToString:[((Loc*)[self.locProps getLoc:lcid]) getlocid])
	
		NSLog(@"vint: %d", [lc getVint]);

		[viewController setSlider:[lc getVint] withDir:lc.dir];
		
	}
	
}

- (void)lcTextFieldAction {
	//[lcTableView.tableView reloadData];
	[self.tabBarController presentModalViewController:lcTableView animated:YES];
}

- (void)dealloc {
	[tabBarController release];
	[rrconnection release];
    [window release];
    [super dealloc];
}

-(void) applicationWillTerminate:(UIApplication *)application {
	NSLog(@"applicationWillTerminate");
}

-(void) applicationWillResignActive:(UIApplication *)application {
	NSLog(@"applicationWillResignActive");
	[[self rrconnection] stop];
	exit(0);
}

-(void) applicationDidBecomeActive:(UIApplication *)application {
	NSLog(@"applicationDidBecomeActive");
	//[[self rrconnection] connect];
}

- (void)setPower:(NSString *)state {
  if( systemView != nil )
    [systemView setPower:[state isEqualToString:@"true"]];
}

@end
