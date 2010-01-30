//
//  iRocAppDelegate.h
//  iRoc
//
//  Created by Jean-Michel Fischer on 17.11.09.
//  Copyright rocrail.net 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "iRocTabBar.h"

#import "iRocLcTableView.h"
#import "iRocRtTableView.h"
#import "iRocSwTableView.h"
#import "iRocCoTableView.h"
#import "iRocBkTableView.h"
#import "iRocScTableView.h"
#import "iRocSgTableView.h"

#import "iRocMenuTableView.h"
#import "iRocLevelTableView.h"
#import "iRocSystemView.h"
#import "IRocConnector.h"
#import "iRocAboutView.h"
#import "iRocLocProps.h"
#import "iRocLcAutoView.h"
#import "iRocLcSettingsView.h"
#import "iRocBlockView.h"

#import "Container.h"
#import "Model.h"


@class iRocViewController;

@interface iRocAppDelegate : NSObject {
  UIWindow *window;
	iRocTabBar *tabBar;
  iRocViewController *viewController;
	UINavigationController *layoutNavi;
  
	IBOutlet iRocLcTableView *lcTableView;
	IBOutlet iRocRtTableView *rtTableView;
	IBOutlet iRocSwTableView *swTableView;
	IBOutlet iRocCoTableView *coTableView;
	IBOutlet iRocBkTableView *bkTableView;
	IBOutlet iRocScTableView *scTableView;
	IBOutlet iRocSgTableView *sgTableView;
	
	IBOutlet iRocMenuTableView *menuTableView;
	IBOutlet iRocLevelTableView *levelTableView;
	IBOutlet iRocSystemView *systemView;
	IBOutlet iRocLcAutoView *lcAutoView;
	IBOutlet iRocLcSettingsView *lcSettingsView;
	IBOutlet iRocBlockView *blockView;

	iRocAboutView IBOutlet *aboutView;
  
	Model *model;
  
	NSMutableArray *menuItems;
	
	IRocConnector *rrconnection;
	UIImageView *imageview;
  
  UIAlertView *connectAlert;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet iRocViewController *viewController;
@property (nonatomic, retain) IBOutlet iRocTabBar *tabBar;

@property (nonatomic, retain) IBOutlet iRocLcTableView *lcTableView;
@property (nonatomic, retain) IBOutlet iRocRtTableView *rtTableView;
@property (nonatomic, retain) IBOutlet iRocSwTableView *swTableView;
@property (nonatomic, retain) IBOutlet iRocCoTableView *coTableView;
@property (nonatomic, retain) IBOutlet iRocBkTableView *bkTableView;
@property (nonatomic, retain) IBOutlet iRocScTableView *scTableView;
@property (nonatomic, retain) IBOutlet iRocSgTableView *sgTableView;
@property (nonatomic, retain) IBOutlet iRocMenuTableView *menuTableView;
@property (nonatomic, retain) IBOutlet iRocLevelTableView *levelTableView;
@property (nonatomic, retain) IBOutlet iRocSystemView *systemView;
@property (nonatomic, retain) IBOutlet iRocLcAutoView *lcAutoView;
@property (nonatomic, retain) IBOutlet iRocLcSettingsView *lcSettingsView;
@property (nonatomic, retain) IBOutlet iRocBlockView *blockView;

@property (nonatomic, retain) IBOutlet iRocAboutView *aboutView;

@property(nonatomic, retain) NSMutableArray *menuItems;
@property(nonatomic, retain) Model *model;

@property (nonatomic, retain) IRocConnector *rrconnection;

- (void)lcListLoaded;
- (void)lcListUpdateCell:(Loc *)loc;
- (Loc*)getLoc:(NSString *)lcid;
- (void)setSelectedLoc:(Loc *)loc;

- (void) locSetSlider;
- (void)setPower:(NSString *)state;
- (void)setAuto:(NSString *)state;
- (BOOL)sendMessage:(NSString *)name message:(NSString *)msg;
- (Model *)getModel;
- (IRocConnector *)getConnector;
- (void)presentBlockView;
- (void)dismissModalViewController;

@end

