//
//  iRocTabBar.m
//  iRoc
//
//  Created by Rocrail on 17.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "iRocTabBar.h"
#import "iRocViewController.h"


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
  NSLog(@"rotation message: will be rotated...");
  BOOL toLandscape = TRUE;
  if( toInterfaceOrientation == UIDeviceOrientationPortrait || toInterfaceOrientation == UIDeviceOrientationPortraitUpsideDown ) {
    toLandscape = FALSE;
  }
  if( self.selectedIndex == 3 ) {
      //self.tabBar.hidden = toLandscape;
    return YES;
  }
  else if( toInterfaceOrientation == UIDeviceOrientationPortrait || toInterfaceOrientation == UIDeviceOrientationPortraitUpsideDown ) {
      //self.tabBar.hidden = FALSE;
    return YES;
  }
  
  return NO;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
  NSLog(@"rotation message for tabcontroller");
  [self.selectedViewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
  if( fromInterfaceOrientation == UIDeviceOrientationPortrait || fromInterfaceOrientation == UIDeviceOrientationPortraitUpsideDown ) {
    NSLog(@"rotation message: will be rotated to landscape...");
      //self.tabBar.hidden = TRUE;
  }
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
}

@end
