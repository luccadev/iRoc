//
//  iRocLocTableViewController.h
//  iRoc
//
//  Created by Jean-Michel Fischer on 07.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Loc.h"


@interface iRocLocTableViewController : UITableViewController  <UIActionSheetDelegate> {
	NSArray *locList;
}

@property (nonatomic, retain) NSArray *locList;

@end
