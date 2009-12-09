//
//  iRocMenuTableView.h
//  iRoc
//
//  Created by Jean-Michel Fischer on 09.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iRocRtTableView.h"


@interface iRocMenuTableView : UITableViewController {
	NSMutableArray *menuItems;
}

@property(nonatomic, retain) NSMutableArray *menuItems;

@end
