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
#import "Container.h"


@interface iRocCoTableView : iRocTableView {
	Container *coContainer;
	id _delegate;
	NSString *menuname;
}

- (id)delegate;
- (void)setDelegate:(id)new_delegate;

@property (nonatomic, retain) Container *coContainer;
@property (nonatomic, retain) NSString *menuname;

@end

@interface NSObject (iRocCoTableView)

- (void)coAction:(NSString *)coid;

@end
