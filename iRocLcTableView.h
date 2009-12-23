//
//  iRocLocTableViewController.h
//  iRoc
//
//  Created by Jean-Michel Fischer on 07.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iRocTableView.h"
#import "Loc.h"


@interface iRocLcTableView : iRocTableView  <UIActionSheetDelegate> {
	NSArray *lcList;
	id _delegate;
	NSString *menuname;
}

- (id)delegate;
- (void)setDelegate:(id)new_delegate;
- (void)addCellImage:(NSIndexPath *)indexPath;

@property (nonatomic, retain) NSArray *lcList;
@property (nonatomic, retain) NSString *menuname;

@end

@interface NSObject (iRocLcTableView)

- (void)lcAction:(NSString *)rtid;

- (void)askForLocpic:(NSString *)lcid withFilename:(NSString *)filename;

@end
