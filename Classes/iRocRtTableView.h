//
//  iRocRtTableView.h
//  iRoc
//
//  Created by Jean-Michel Fischer on 08.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Route.h"


@interface iRocRtTableView : UITableViewController {
	NSArray *rtList;
	id _delegate;
}

- (id)delegate;
- (void)setDelegate:(id)new_delegate;

@property (nonatomic, retain) NSArray *rtList;

@end

@interface NSObject (iRocRtTableView)

- (void)rtAction:(NSString *)rtid;

@end
