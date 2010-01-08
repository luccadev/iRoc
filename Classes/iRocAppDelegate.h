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
#import "iRocBkTableView.h"
#import "iRocScTableView.h"

#import "iRocMenuTableView.h"
#import "iRocSystemView.h"
#import "IRocConnector.h"
#import "iRocAboutView.h"
#import "iRocLocProps.h"
#import "iRocLcAutoView.h"
#import "iRocLcSettingsView.h"

#import "Container.h"


@class iRocViewController;

@interface iRocAppDelegate : NSObject {
    UIWindow *window;
    iRocViewController *viewController;
	UITabBarController *tabBarController;
	
	IBOutlet iRocLcTableView *lcTableView;
	IBOutlet iRocRtTableView *rtTableView;
	IBOutlet iRocSwTableView *swTableView;
	IBOutlet iRocCoTableView *coTableView;
	IBOutlet iRocBkTableView *bkTableView;
	IBOutlet iRocScTableView *scTableView;
	
	IBOutlet iRocMenuTableView *menuTableView;
	IBOutlet iRocSystemView *systemView;
	IBOutlet iRocLcAutoView *lcAutoView;
	IBOutlet iRocLcSettingsView *lcSettingsView;

	iRocAboutView IBOutlet *aboutView;
  
	Container *rtContainer;
	Container *swContainer;
	Container *lcContainer;
	Container *coContainer;
	Container *bkContainer;
	Container *scContainer;
	
	NSMutableArray *menuItems;
	
	IRocConnector *rrconnection;
	UIImageView *imageview;
  
  UIAlertView *connectAlert;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet iRocViewController *viewController;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@property (nonatomic, retain) IBOutlet iRocLcTableView *lcTableView;
@property (nonatomic, retain) IBOutlet iRocRtTableView *rtTableView;
@property (nonatomic, retain) IBOutlet iRocSwTableView *swTableView;
@property (nonatomic, retain) IBOutlet iRocCoTableView *coTableView;
@property (nonatomic, retain) IBOutlet iRocBkTableView *bkTableView;
@property (nonatomic, retain) IBOutlet iRocScTableView *scTableView;
@property (nonatomic, retain) IBOutlet iRocMenuTableView *menuTableView;
@property (nonatomic, retain) IBOutlet iRocSystemView *systemView;
@property (nonatomic, retain) IBOutlet iRocLcAutoView *lcAutoView;
@property (nonatomic, retain) IBOutlet iRocLcSettingsView *lcSettingsView;

@property (nonatomic, retain) IBOutlet iRocAboutView *aboutView;

@property(nonatomic, retain) Container *rtContainer;
@property(nonatomic, retain) Container *swContainer;
@property(nonatomic, retain) Container *lcContainer;
@property(nonatomic, retain) Container *coContainer;
@property(nonatomic, retain) Container *bkContainer;
@property(nonatomic, retain) Container *scContainer;

@property(nonatomic, retain) NSMutableArray *menuItems;

@property (nonatomic, retain) IRocConnector *rrconnection;

- (void)lcListLoaded;
- (void)lcListUpdateCell:(Loc *)loc;
- (Loc*)getLoc:(NSString *)lcid;
- (void)setSelectedLoc:(Loc *)loc;

- (void) locSetSlider;

@end

