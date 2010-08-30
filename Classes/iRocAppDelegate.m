/*
 Rocrail - Model Railroad Software
 
 Copyright (C) 2009-2010 - Rob Versluis <r.j.versluis@rocrail.net>, Jean-Michel Fischer <jmf@polygonpunkt.de>
 
 This program is free software; you can redistribute it and/or
 modify it under the terms of the GNU General Public License
 as published by the Free Software Foundation; either version 2
 of the License, or (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 */

#import "iRocAppDelegate.h"
#import "iRocViewController.h"
#import "iRocTabBar.h"


@implementation iRocAppDelegate

@synthesize window;
@synthesize tabBar;
@synthesize viewController;
@synthesize lcTableView, rtTableView, swTableView, coTableView, bkTableView, scTableView, sgTableView, 
      menuTableView, levelTableView, systemView, lcAutoView, lcSettingsView, model, blockView;

@synthesize rrconnection, menuItems, aboutView;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
  NSLog(@"applicationDidFinishLaunching");
	
  CGRect screenBounds = [[UIScreen mainScreen] bounds];
  CGRect windowBounds = screenBounds;
  windowBounds.origin.y = 0.0;
  
  self.window = [[[UIWindow alloc] initWithFrame: screenBounds] autorelease];
  
  
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
	[[UIApplication sharedApplication] setStatusBarHidden:FALSE];
	
	// read preferences
	NSUserDefaults *defaults = [[NSUserDefaults standardUserDefaults] retain];
  
    // the model
  model = [[Model alloc] init];
	
	//sleep_preferences
	if( [defaults boolForKey:@"sleep_preferences"]) {
		application.idleTimerDisabled = NO;
	} else {
		application.idleTimerDisabled = YES;
	}
	
  viewController = [[iRocViewController alloc] init];
  systemView = [[iRocSystemView alloc] init];
  aboutView = [[iRocAboutView alloc] initWithDelegate:self andModel:model];
  menuTableView = [[iRocMenuTableView alloc] init];
  lcAutoView = [[iRocLcAutoView alloc] init];
  lcSettingsView = [[iRocLcSettingsView alloc] init];
  levelTableView = [[iRocLevelTableView alloc] initWithDelegate:self andModel:model];

	[viewController setDelegate:self];
  
    // Optional move event.
	if( [defaults boolForKey:@"moveevents_preference"]) {
		[viewController processAllEvents:[defaults integerForKey:@"vdelta_preference"]];
	}
  
  viewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:
                               NSLocalizedString(@"Loco", @"")
                              image:[UIImage imageNamed:@"loco.png"] tag:1];

  menuTableView.tabBarItem = [[UITabBarItem alloc] initWithTitle:
                               NSLocalizedString(@"Menu", @"")
                               image:[UIImage imageNamed:@"menu.png"] tag:3];
  
  levelTableView.tabBarItem = [[UITabBarItem alloc] initWithTitle:
                               NSLocalizedString(@"Plan", @"")
                               image:[UIImage imageNamed:@"enter.png"] tag:4];
  
  UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:viewController];
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

  layoutNavi = [[UINavigationController alloc] initWithRootViewController:levelTableView];
  layoutNavi.navigationBar.tintColor = [UIColor blackColor];

  UINavigationController *menuNavi = [[UINavigationController alloc] initWithRootViewController:menuTableView];
  menuNavi.navigationBar.tintColor = [UIColor blackColor];
  
    // Tab 1 = Loco
    // Tab 2 = System
    // Tab 3 = Menu
    // Tab 4 = Layout
  tabBar = [[iRocTabBar alloc] initWithDelegate:self];
  
  [tabBar addPage: (UIView *)navi];
  [tabBar addPage: (UIView *)systemView];
  [tabBar addPage: (UIView *)menuNavi];
  [tabBar addPage: (UIView *)layoutNavi];
  
  [window addSubview:tabBar.view];

    // Override point for customization after application launch
  [window makeKeyAndVisible];
	
  lcAutoView.bkContainer = model.bkContainer;
  lcAutoView.scContainer = model.scContainer;

	menuItems = [[NSMutableArray array] retain];
	
	lcTableView = [[iRocLcTableView alloc] init];
	[lcTableView setLcContainer:model.lcContainer];
	[lcTableView setDelegate:self];
	[lcTableView setMenuname:NSLocalizedString(@"Locomotives", @"")];

	swTableView = [[iRocSwTableView alloc] init];
	[swTableView setSwContainer:model.swContainer];
	[swTableView setDelegate:self];
	[swTableView setMenuname:NSLocalizedString(@"Switches", @"")];
	
	rtTableView = [[iRocRtTableView alloc] init];
	[rtTableView setRtContainer:model.rtContainer];
	[rtTableView setDelegate:self];
	[rtTableView setMenuname:NSLocalizedString(@"Routes", @"")];
	
	coTableView = [[iRocCoTableView alloc] init];
	[coTableView setCoContainer:model.coContainer];
	[coTableView setDelegate:self];
	[coTableView setMenuname:NSLocalizedString(@"Outputs", @"")];
	
	bkTableView = [[iRocBkTableView alloc] init];
	[bkTableView setBkContainer:model.bkContainer];
	[bkTableView setDelegate:self];
	[bkTableView setMenuname:NSLocalizedString(@"Blocks", @"")];
	
	scTableView = [[iRocScTableView alloc] init];
	[scTableView setScContainer:model.scContainer];
	[scTableView setDelegate:self];
	[scTableView setMenuname:NSLocalizedString(@"Schedules", @"")];
	
	sgTableView = [[iRocSgTableView alloc] init];
	[sgTableView setSgContainer:model.sgContainer];
	[sgTableView setDelegate:self];
	[sgTableView setMenuname:NSLocalizedString(@"Signals", @"")];
	
	// BlockView
	blockView = [[iRocBlockView alloc] init];
	[blockView set_delegate:self];
  blockView.lcContainer = model.lcContainer;


	[aboutView setMenuname:NSLocalizedString(@"Info", @"")];
	
	[menuItems addObject:lcTableView];
	[menuItems addObject:rtTableView];
	[menuItems addObject:swTableView];
	[menuItems addObject:sgTableView];
	[menuItems addObject:coTableView];
    //[menuItems addObject:bkTableView];
    //[menuItems addObject:scTableView];
	[menuItems addObject:aboutView];
	[menuTableView setMenuItems:menuItems];
	
	// read preferences
	defaults = [[NSUserDefaults standardUserDefaults] retain];
	
	
	//NSLog(@" ###### DEFAULTS: %@",  [defaults stringForKey:@"last_connections"]);
	  
	    
	
	
	rrconnection = [[IRocConnector alloc] init];
	[rrconnection setDomain:[defaults stringForKey:@"ip_preference"]];
	[rrconnection setPort:[defaults integerForKey:@"port_preference"]];
	[rrconnection setDelegate:self withModel:model];
//	viewController.textfieldLoc.text = [defaults stringForKey:@"loc_preference"];
  viewController.imageviewLoc = nil;
	
	
	startAlert = [[UIAlertView alloc] 
								initWithTitle:nil
								message:[NSString stringWithFormat: 
												 @"Connecting to: \n%@:%d \n", 
												 [defaults stringForKey:@"ip_preference"], 
												 [defaults integerForKey:@"port_preference"]]
								delegate:self 
								cancelButtonTitle:nil 
								otherButtonTitles:nil];
	[startAlert show];
	
	UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	indicator.center = CGPointMake(startAlert.bounds.size.width * 0.5f, startAlert.bounds.size.height * 0.65f);
	
	[indicator startAnimating];
	[startAlert addSubview:indicator];
	[indicator release];
	
	
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
      //[self.tabBarController setSelectedViewController:aboutView];
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
  if( alertView == connectAlert) {
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
	//NSLog(@"update loco cell...");
  [lcTableView addCellLocoImage:loc];
  
	//NSLog(@"informing locProps of image...");
  [viewController.locProps imageLoaded];
}

- (void)setSelectedLoc:(Loc *)loc {
  lcAutoView.loc = loc;
  lcSettingsView.loc = loc;
  [viewController updateFnState];

	[viewController setSlider:[loc getVpercent] withDir:loc.dir];
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

- (void)sgListLoaded {
	[sgTableView.tableView reloadData];
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

- (void)sgAction:(NSString *)sgid {	
	NSLog(@"sgAction: %@", sgid);
	[rrconnection sendMessage:@"sg" message:[[NSString alloc] initWithString: [NSString stringWithFormat: 
                  @"<sg id=\"%@\" cmd=\"flip\"/>", sgid]]];
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
	
	//self.viewController.textfieldLoc.text = lcid;
	[self.tabBar setSelectedViewController:viewController.navigationController];
	[[NSUserDefaults standardUserDefaults] setObject:(NSString*)lcid forKey:@"loc_preference"];
	
	[self.tabBar dismissModalViewControllerAnimated:YES];
	Loc *loc = (Loc*) [model.lcContainer objectWithId:lcid];
	
	// The new one:
	[viewController.locProps setLoc:loc];

	[viewController updateFnState];
  [lcSettingsView setLoco:loc];
  [lcAutoView setLoco:loc];
	
	[viewController setSlider:[loc getVpercent] withDir:loc.dir];
}

- (Loc*)getLoc:(NSString *)lcid {
	NSLog(@"getLoc for: %@ 0x%08X", lcid, model.lcContainer);
  if( lcid != NULL ) {
	  return (Loc*) [model.lcContainer objectWithId:lcid];
  }
  return nil;
}

- (void)askForAllLocPics {
	
	// inform some views of plan loaded
  [levelTableView planLoaded];
	
	[startAlert dismissWithClickedButtonIndex:0 animated:YES];

	if ( [model.donkey isEqual:@"false"] ) {
		donkeyAlert = [[UIAlertView alloc] 
									 initWithTitle:@"Warning" 
									 message:[NSString stringWithFormat: 
														@"The server at %@:%d\n has no valid donation key. \n please request one at rocrail.net",[rrconnection domain], [rrconnection port]] 
									 delegate:self 
									 cancelButtonTitle:nil 
									 otherButtonTitles:@"OK",nil];
		[donkeyAlert show];
	}
	
	int i;
	for( i = 0; i< [model.lcContainer count]; i++){	
		Loc *loc;
		loc = (Loc*)[model.lcContainer objectAtIndex:i];
		if( loc != nil && loc.hasImage && ![loc.imgname isEqualToString:@""] ) {
			[self askForLocpic:loc.locid withFilename:loc.imgname];
		}
	}	
}

- (void)askForLocpic:(NSString *)lcid withFilename:(NSString*)filename {
	[rrconnection requestLocpic:lcid withFilename:filename];
}

- (void)locSetSlider {
	[viewController setSlider:0 withDir:@"true"];
}

- (void)lcTextFieldAction {
	//[lcTableView.tableView reloadData];
	[self.tabBar presentModalViewController:lcTableView animated:YES];
}

- (void)presentBlockView:(Block*)block {
	
	[blockView setBlock:block];
	
	[self.viewController presentModalViewController:blockView animated:YES];
}

-(void) dismissModalViewController {
	//[levelTableView.levelView dismissModalViewControllerAnimated:YES];
	
	[self.viewController dismissModalViewControllerAnimated:YES];
}


- (void)dealloc {
	[tabBar release];
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

- (void)setAuto:(NSString *)state {
  if( systemView != nil )
    [systemView setAuto:[state isEqualToString:@"on"]];
  if( lcAutoView != nil )
    [lcAutoView setAuto:[state isEqualToString:@"on"]];
}

- (BOOL)sendMessage:(NSString *)name message:(NSString *)msg {
  return [rrconnection sendMessage:name message:msg];
}


- (Model *)getModel {
  return model;
}

- (IRocConnector *)getConnector {
  return rrconnection;
}

@end
