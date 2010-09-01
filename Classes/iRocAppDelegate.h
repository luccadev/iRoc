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
#import "iRocLcAutoView.h"
#import "iRocLcSettingsView.h"
#import "iRocBlockView.h"

#import "Container.h"
#import "Model.h"
#import "Block.h"


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
	UIAlertView *donkeyAlert;
	UIAlertView *startAlert;
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
//- (Loc*)getLoc:(NSString *)lcid;
//- (void)setSelectedLoc:(Loc *)loc;

- (void)updateLabels;
- (void)locSetSlider;
- (void)setPower:(NSString *)state;
- (void)setAuto:(NSString *)state;
- (BOOL)sendMessage:(NSString *)name message:(NSString *)msg;
- (Model *)getModel;
- (IRocConnector *)getConnector;
- (void)presentBlockView:(Block*)block;
- (void)dismissModalViewController;

@end

