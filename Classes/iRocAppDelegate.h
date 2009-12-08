//
//  iRocAppDelegate.h
//  iRoc
//
//  Created by Jean-Michel Fischer on 17.11.09.
//  Copyright rocrail.net 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iRocLocTableViewController.h"
#import "IRocConnector.h"

@class iRocViewController;

@interface iRocAppDelegate : NSObject {
    UIWindow *window;
    iRocViewController *viewController;
	UITabBarController *tabBarController;
	
	IBOutlet iRocLocTableViewController *locTableViewControllerApp;
	
	NSMutableArray *locList;
	
	IRocConnector *rrconnection;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet iRocViewController *viewController;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@property (nonatomic, retain) IBOutlet iRocLocTableViewController *locTableViewControllerApp;

@property(nonatomic, retain) NSMutableArray *locList;
@property (nonatomic, retain) IRocConnector *rrconnection;

@end

