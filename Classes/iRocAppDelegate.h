//
//  iRocAppDelegate.h
//  iRoc
//
//  Created by Jean-Michel Fischer on 17.11.09.
//  Copyright rocrail.net 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "iRocLcTableView.h"
#import "iRocRtTableView.h"
#import "iRocSwTableView.h"
#import "iRocCoTableView.h"

#import "iRocMenuTableView.h"
#import "IRocConnector.h"
#import "iRocAboutView.h"


@class iRocViewController;

@interface iRocAppDelegate : NSObject {
    UIWindow *window;
    iRocViewController *viewController;
	UITabBarController *tabBarController;
	
	IBOutlet iRocLcTableView *lcTableView;
	IBOutlet iRocRtTableView *rtTableView;
	IBOutlet iRocSwTableView *swTableView;
	IBOutlet iRocCoTableView *coTableView;
	
	IBOutlet iRocMenuTableView *menuTableView;

	iRocAboutView IBOutlet *aboutView;
	
	NSMutableArray *lcList;	
	NSMutableArray *lcIndexList;	
	
	NSMutableArray *rtList;
	NSMutableArray *swList;
	NSMutableArray *coList;
	
	NSMutableArray *menuItems;
	
	IRocConnector *rrconnection;
	UIImageView *imageview;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet iRocViewController *viewController;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@property (nonatomic, retain) IBOutlet iRocLcTableView *lcTableView;
@property (nonatomic, retain) IBOutlet iRocRtTableView *rtTableView;
@property (nonatomic, retain) IBOutlet iRocSwTableView *swTableView;
@property (nonatomic, retain) IBOutlet iRocCoTableView *coTableView;
@property (nonatomic, retain) IBOutlet iRocMenuTableView *menuTableView;

@property (nonatomic, retain) IBOutlet iRocAboutView *aboutView;


@property(nonatomic, retain) NSMutableArray *lcList;
@property(nonatomic, retain) NSMutableArray *lcIndexList;

@property(nonatomic, retain) NSMutableArray *rtList;
@property(nonatomic, retain) NSMutableArray *swList;
@property(nonatomic, retain) NSMutableArray *coList;

@property(nonatomic, retain) NSMutableArray *menuItems;

@property (nonatomic, retain) IRocConnector *rrconnection;

- (void)lcListLoaded;
- (void)lcListReloadRow:(NSNumber*)row;


@end

