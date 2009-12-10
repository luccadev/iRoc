//
//  iRocCoTableView.h
//  iRoc
//
//  Created by Jean-Michel Fischer on 09.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iRocTableView.h"
#import "Output.h"


@interface iRocCoTableView : iRocTableView {
	NSArray *coList;
	id _delegate;
	NSString *menuname;
}

- (id)delegate;
- (void)setDelegate:(id)new_delegate;

@property (nonatomic, retain) NSArray *coList;
@property (nonatomic, retain) NSString *menuname;

@end

@interface NSObject (iRocCoTableView)

- (void)coAction:(NSString *)coid;

@end
