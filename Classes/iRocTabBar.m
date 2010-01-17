//
//  iRocTabBar.m
//  iRoc
//
//  Created by Rocrail on 17.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "iRocTabBar.h"


@implementation iRocTabBar
@synthesize views;

- (id)init {
  self = [super init];
  if( self != nil ) {
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
  return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
  NSLog(@"rotation message for tabcontroller");
  [self.selectedViewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
}

@end