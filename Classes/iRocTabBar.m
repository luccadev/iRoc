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
	
  NSLog(@"rotation message: will be rotated... (iRocTabBar)");
  BOOL toLandscape = TRUE;

  if( toInterfaceOrientation == UIDeviceOrientationPortrait || toInterfaceOrientation == UIDeviceOrientationPortraitUpsideDown ) {
    toLandscape = FALSE;
  }
	
  if( toLandscape) {
    NSLog(@"TabBar rotates to landscape");
      
      // The plan is allways rotating      
      if( self.selectedIndex == 3 ) {
          return YES;
      }
      
      /* Rotate to Plan? */
      if( self.selectedIndex == 0 && [[Globals getDefaults] boolForKey:@"rotatetoplan"]) {
          self.selectedIndex = 3;
          return YES;
      }

      
  } else { // Portrait
      NSLog(@"TabBar rotates to portrait");

      /* Rotate to Throttle? */
      if ( [[Globals getDefaults] boolForKey:@"rotatetoplan"]) {
          self.selectedIndex = 0;
          
      }
      return YES;
  } 
    
   /*   
  else if( !toLandscape ) {
    return YES;
  }
    */
	  
  return NO;
}


- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	
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
