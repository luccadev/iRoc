//
//  iRocRtTableView.h
//  iRoc
//
//  Created by Jean-Michel Fischer on 08.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iRocTableView.h"
#import "Route.h"
#import "Container.h"


@interface iRocRtTableView : iRocTableView {
	Container *rtContainer;
	id _delegate;
	NSString *menuname;
}

- (id)delegate;
- (void)setDelegate:(id)new_delegate;

@property (nonatomic, retain) Container *rtContainer;
@property (nonatomic, retain) NSString *menuname;

@end

@interface NSObject (iRocRtTableView)

- (void)rtAction:(NSString *)rtid;

@end
