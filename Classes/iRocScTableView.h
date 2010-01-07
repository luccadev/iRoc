  //
  //  iRocScTableView.h
  //  iRoc
  //
  //  Created by Rocrail on 07.01.10.
  //  Copyright 2010 __MyCompanyName__. All rights reserved.
  //

#import <UIKit/UIKit.h>
#import "iRocTableView.h"
#import "Schedule.h"
#import "Container.h"


@interface iRocScTableView : iRocTableView {
	Container *scContainer;
	id _delegate;
	NSString *menuname;
}

- (id)delegate;
- (void)setDelegate:(id)new_delegate;

@property (nonatomic, retain) Container *scContainer;
@property (nonatomic, retain) NSString *menuname;

@end

@interface NSObject (iRocScTableView)

- (void)bkAction:(NSString *)scid;

@end
