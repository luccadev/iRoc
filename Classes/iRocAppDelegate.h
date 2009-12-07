//
//  iRocAppDelegate.h
//  iRoc
//
//  Created by Jean-Michel Fischer on 17.11.09.
//  Copyright rocrail.net 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iRocLocTableViewController.h"
#import "iRocViewController.h"

@class iRocViewController;

@interface iRocAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    iRocViewController *viewController;
	UITabBarController *tabBarController;
	
	IBOutlet iRocLocTableViewController *locTableViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet iRocViewController *viewController;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@property (nonatomic, retain) IBOutlet iRocLocTableViewController *locTableViewController;


@end

