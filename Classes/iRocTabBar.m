//
//  iRocTabBar.m
//  iRoc
//
//  Created by Rocrail on 17.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "iRocTabBar.h"
#import "iRocViewController.h"
#import "Globals.h"

@implementation iRocTabBar
@synthesize views;

- (id)initWithDelegate:(id)_appDelegate {
  self = [super init];
  if( self != nil ) {
    appDelegate = _appDelegate;
    self.views = [[NSMutableArray alloc] init];
    self.viewControllers = views;
    self.delegate = self;
  }
	
  return self;
}

- (void)addPage: (UIView *)page {
  [views addObject: page];
  self.viewControllers = views;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	
	if( ![[Globals getDefaults] boolForKey:@"allowrotation"])
		return NO;
	
	
  NSLog(@"rotation message: will be rotated... (iRocTabBar)");
  BOOL toLandscape = TRUE;

  if( toInterfaceOrientation == UIDeviceOrientationPortrait || toInterfaceOrientation == UIDeviceOrientationPortraitUpsideDown ) {
    toLandscape = FALSE;
  }
	
	if( toLandscape ) {
		NSLog(@"TabBar rotates to landscape");
		// The plan is allways rotating
		if( self.selectedIndex == 3 ) {
			return YES;
		}
		
		// Rotate to Plan?
		if( self.selectedIndex == 0 && [[Globals getDefaults] boolForKey:@"rotatetoplan"]) {
			self.selectedIndex = 3;
			return YES;
		}
		
	} else { // Portrait
		NSLog(@"TabBar rotates to portrait");
		// Rotate to Throttle?
		if ( [[Globals getDefaults] boolForKey:@"rotatetoplan"])
		  self.selectedIndex = 0;
		return YES;
	}
	  
  return NO;
}


- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	
	if( ![[Globals getDefaults] boolForKey:@"allowrotation"])
		return;
	
  NSLog(@"rotation message for tabcontroller");
	
	if( self.selectedIndex == 3 ) {
		[self.selectedViewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
	}
		
  if( fromInterfaceOrientation == UIDeviceOrientationPortrait || fromInterfaceOrientation == UIDeviceOrientationPortraitUpsideDown ) {
    NSLog(@"rotation message: will be rotated to landscape...");
      //self.tabBar.hidden = TRUE;
  }
}


- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
}

@end
