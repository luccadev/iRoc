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
#import "iRocNavigationController.h"


@implementation iRocAppDelegate

@synthesize window;
@synthesize tabBar;
@synthesize viewController;
@synthesize lcTableView, rtTableView, swTableView, coTableView, bkTableView, scTableView, sgTableView, 
menuTableView, levelTableView, systemView, lcAutoView, lcSettingsView, model, blockView, turntableView, mgv136View;

@synthesize rrconnection, menuItems, aboutView, guestLocoView;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//- (void)applicationDidFinishLaunching:(UIApplication *)application {
    NSLog(@"applicationDidFinishLaunching");
	
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGRect windowBounds = screenBounds;
    windowBounds.origin.y = 0.0;
    
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

	offline = FALSE;
    
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
	
    viewController = [[iRocViewController alloc] initWithDelegate:self andModel:model];
    systemView = [[iRocSystemView alloc] init];
    aboutView = [[iRocAboutView alloc] initWithDelegate:self andModel:model];
  guestLocoView = [[GuestLocoView alloc] initWithDelegate:self andModel:model];
    menuTableView = [[iRocMenuTableView alloc] init];
    lcAutoView = [[iRocLcAutoView alloc] init];	
	lcSettingsView = [[iRocLcSettingsView alloc] initWithDelegate:self andModel:model];
    levelTableView = [[iRocLevelTableView alloc] initWithDelegate:self andModel:model];
    mgv136View = [[mgv136 alloc] initWithDelegate:self];
  
  if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
	  viewController.edgesForExtendedLayout = UIRectEdgeNone;
	  aboutView.edgesForExtendedLayout = UIRectEdgeNone;
	  guestLocoView.edgesForExtendedLayout = UIRectEdgeNone;
	  systemView.edgesForExtendedLayout = UIRectEdgeNone;
	  lcAutoView.edgesForExtendedLayout = UIRectEdgeNone;
  }

    // Optional move event.
	if( [defaults boolForKey:@"moveevents_preference"]) {
		[viewController processAllEvents:(int)[defaults integerForKey:@"vdelta_preference"]];
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
    
    iRocNavigationController *navi = [[iRocNavigationController alloc] initWithRootViewController:viewController];
    navi.navigationBar.tintColor = [UIColor blackColor];

  iRocNavigationController *sysnavi = [[iRocNavigationController alloc] initWithRootViewController:systemView];
  sysnavi.navigationBar.tintColor = [UIColor blackColor];
  
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
	 
    layoutNavi = [[iRocNavigationController alloc] initWithRootViewController:levelTableView];
    //layoutNavi.navigationBar.tintColor = [UIColor blackColor];
    
    iRocNavigationController *menuNavi = [[iRocNavigationController alloc] initWithRootViewController:menuTableView];
    //menuNavi.navigationBar.tintColor = [UIColor blackColor];
    
    // Tab 1 = Loco
    // Tab 2 = System
    // Tab 3 = Menu
    // Tab 4 = Layout
    tabBar = [[iRocTabBar alloc] initWithDelegate:self];
    
    [tabBar addPage: (UIView *)navi];
    [tabBar addPage: (UIView *)sysnavi];
    [tabBar addPage: (UIView *)menuNavi];
    [tabBar addPage: (UIView *)layoutNavi];
  
  [self.window setRootViewController:tabBar];

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
    
    // TurntableView
	ttView = [[iRocTurntableView alloc] init];
	[ttView set_delegate:self];
    
    
	[aboutView setMenuname:NSLocalizedString(@"Info", @"")];
	[guestLocoView setMenuname:NSLocalizedString(@"Guest loco", @"")];
	
	[mgv136View setMenuname:NSLocalizedString(@"MGV136", @"")];
	
	[menuItems addObject:lcTableView];
	[menuItems addObject:rtTableView];
	[menuItems addObject:swTableView];
	[menuItems addObject:sgTableView];
	[menuItems addObject:coTableView];
  //[menuItems addObject:bkTableView];
  //[menuItems addObject:scTableView];
	//[menuItems addObject:mgv136View];
	[menuItems addObject:guestLocoView];
	[menuItems addObject:aboutView];
	
	[menuTableView setMenuItems:menuItems];
  
  
  
  
	rrconnection = [[IRocConnector alloc] init];
	[rrconnection setDomain:[defaults stringForKey:@"ip_preference"]];
	[rrconnection setPort:[defaults integerForKey:@"port_preference"]];
	[rrconnection setDelegate:self withModel:model];
    //	viewController.textfieldLoc.text = [defaults stringForKey:@"loc_preference"];
    viewController.imageviewLoc = nil;
	
  NSString* domain = [defaults stringForKey:@"ip_preference"];
  int port = (int)[defaults integerForKey:@"port_preference"];
  
  if( domain == nil || [domain length] == 0 ) {
    domain = @"rocrail.dyndns.org";
  }
  if( port == 0 ) {
    port = 8051;
  }

	NSString* l_message = [NSString stringWithFormat: 
                         @"Connecting to:\n%@:%d", 
                         domain, 
                         port];
  
	startAlert = [[UIAlertView alloc] 
                  initWithTitle:nil
                  message:l_message
                  delegate:self 
                  cancelButtonTitle:nil 
                  otherButtonTitles:nil];
	
	UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	//indicator.center = CGPointMake(startAlert.bounds.size.width * 0.5f, startAlert.bounds.size.height * 0.65f);
	
	
	indicator.center = CGPointMake(143,90);
	[indicator startAnimating];
	[startAlert addSubview:indicator];
	[indicator release];
	
	// date 
	date_formater=[[NSDateFormatter alloc]init];
	[date_formater setDateFormat:@"HH:mm:ss"];
	
    systemView.rrconnection = rrconnection;
    lcAutoView.rrconnection = rrconnection;
    lcSettingsView.rrconnection = rrconnection;
	mgv136View.rrconnection = rrconnection;
	guestLocoView.rrconnection = rrconnection;
	
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
		[startAlert show];
        [rrconnection requestPlan];
		//[rrconnection requestLcList];
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
  return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if( alertView == connectAlert) {
        exit(0);
    }
	if( alertView == donkeyAlert) {
        //exit(0);
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
    //[lcTableView addCellLocoImage:loc];
    
	//NSLog(@"informing locProps of image...");
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
	NSLog(@"lcAction (AppDelegate): %@", lcid);
    
	[[NSUserDefaults standardUserDefaults] setObject:(NSString*)lcid forKey:@"loc_preference"];
	
	//[self.tabBar dismissModalViewControllerAnimated:YES];
	Loc *loc = (Loc*) [model.lcContainer objectWithId:lcid];
    
	[viewController updateFnState];
    [lcAutoView setLoco:loc];
    
	[lcSettingsView dealloc];
	lcSettingsView = [[iRocLcSettingsView alloc] initWithDelegate:self andModel:model];
	lcSettingsView.rrconnection = rrconnection;
	[lcSettingsView setLoco:loc];
    
	
    [viewController updateFnState];
	[viewController setSlider:[loc getVpercent] withDir:loc.dir];
}

- (void)updateLabels {
	[viewController.locProps updateLabels];	
}

/* CALLED WHEN PLAN IS PROCESSED */
- (void)askForAllLocPics {
	
	[startAlert dismissWithClickedButtonIndex:0 animated:YES];
	
	// inform the locoPicker
	Loc *lc = [model.lcContainer objectWithId:[[Globals getDefaults] stringForKey:@"loc_preference"]];
	[viewController.locProps setLoc:lc];
	[self lcAction: [viewController.locProps getLoc].locid];
    
	// inform some views of plan loaded
    [levelTableView planLoaded];
	
 if ( [model.donkey isEqual:@"false"] ) {
   donkeyAlert = [[UIAlertView alloc]
   initWithTitle:@"Support"
   message:[NSString stringWithFormat:
   @"Rocrail runs entirely on volunteer labor. \n "
   "However, Rocrail also needs contributions of money. \n "
   "Your continued support is vital for keeping Rocrail available. \n "
   "If you already did donate you can ask a key to disable this on startup dialog: supportkey@rocrail.net"]
   delegate:self
   cancelButtonTitle:nil
   otherButtonTitles:@"OK",nil];
   [donkeyAlert show];
 }
  
	
	clockIsRuning = YES;
	
	int i;
	for( i = 0; i< [model.lcContainer count]; i++){
		Loc *loc;
		loc = (Loc*)[model.lcContainer objectAtIndex:i];
		if( loc != nil && loc.hasImage && ![loc.imgname isEqualToString:@""] ) {
			[self askForLocpic:loc.locid withFilename:loc.imgname];
		}
	}	
}

- (void) allLocpicsLoaded {
	NSLog(@"All locpics loaded ...");
}


- (void)askForLocpic:(NSString *)lcid withFilename:(NSString*)filename {
	[rrconnection requestLocpic:lcid withFilename:filename];
}

- (void)locSetSlider {
	[viewController setSlider:0 withDir:@"true"];
}

- (void)lcTextFieldAction {
    
}

- (void)presentBlockView:(Block*)block {
	
	[blockView setBlock:block];
	
	[self.viewController presentModalViewController:blockView animated:YES];
}

- (void)presentTurntableView:(Turntable*)tt {
	
	[ttView setTurntable:tt];
	
	[self.viewController presentModalViewController:ttView animated:YES];
    
}

- (void)presentModalViewController:(UIViewController*)view animated:(BOOL)ani{
	[self.viewController presentModalViewController:view animated:ani];
}

-(void) dismissModalViewController {
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

- (void)setClock:(NSString *)state { 
	clocktime = [state intValue];
}   

- (void)setClockState:(NSString *)state { 
	
	if ([state isEqualToString:@"freeze"]) {
		clockIsRuning = NO;
	} else if ( [state isEqualToString:@"sync"] && clockIsRuning ) {
		clockIsRuning = YES;
	} else if ( [state isEqualToString:@"go"]) {
		clockIsRuning = YES;
	}
    
}   

- (void)setClockDivider:(NSString *)state { 
    
	clockdivider = [state intValue];
	
	if (![clockTicker isValid] || prevclockdivider != clockdivider) {
		[clockTicker invalidate];
		[self runTimer];
		prevclockdivider = clockdivider;
	}
	
}


- (void)runTimer {
	
	double timeint = 1.0/(float)clockdivider;
	
    clockTicker = [NSTimer scheduledTimerWithTimeInterval: timeint
                                                   target: self
                                                 selector: @selector(showActivity)
                                                 userInfo: nil
                                                  repeats: YES];
}

- (void)showActivity {
	clockDate = [NSDate dateWithTimeIntervalSince1970: clocktime++];	
	[systemView setClock:clockDate];
	
	
	NSString *clock = @"";
	if (clockdivider > 1) {
		clock = [NSString stringWithFormat:@".%@.",[date_formater stringFromDate:clockDate]];
	} else {
		clock = [date_formater stringFromDate:clockDate];
	}
    
	viewController.navigationItem.title = clock;
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

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window  // iOS 6 autorotation fix
{
	NSLog(@"iRocAppDelegate: supportedInterfaceOrientationsForWindow");
  return UIInterfaceOrientationMaskAll;
}

@end
