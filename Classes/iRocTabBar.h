//
//  iRocTabBar.h
//  iRoc
//
//  Created by Rocrail on 17.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UITabBarController.h>

@interface iRocTabBar : UITabBarController <UITabBarControllerDelegate> {
  NSMutableArray *views;
}
@property (nonatomic, retain) NSMutableArray *views;

- (void)addPage: (UIView *)page;

@end

