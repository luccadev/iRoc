//
//  iRocSwTableView.h
//  iRoc
//
//  Created by Jean-Michel Fischer on 09.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iRocTableView.h"
#import "Switch.h"

@interface iRocSwTableView : iRocTableView {
	NSArray *swList;
	id _delegate;
	NSString *menuname;
}

- (id)delegate;
- (void)setDelegate:(id)new_delegate;

@property (nonatomic, retain) NSArray *swList;
@property (nonatomic, retain) NSString *menuname;

@end

@interface NSObject (iRocSwTableView)

- (void)swAction:(NSString *)swid;

@end
