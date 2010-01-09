  //
  //  iRocCoTableView.h
  //  iRoc
  //
  //  Created by Jean-Michel Fischer on 09.12.09.
  //  Copyright 2009 __MyCompanyName__. All rights reserved.
  //

#import <UIKit/UIKit.h>
#import "iRocTableView.h"
#import "Signal.h"
#import "Container.h"


@interface iRocSgTableView : iRocTableView {
	Container *sgContainer;
	id _delegate;
	NSString *menuname;
}

- (id)delegate;
- (void)setDelegate:(id)new_delegate;

@property (nonatomic, retain) Container *sgContainer;
@property (nonatomic, retain) NSString *menuname;

@end

@interface NSObject (iRocSgTableView)

- (void)sgAction:(NSString *)sgid;

@end
