//
//  iRocBkTableView.h
//  iRoc
//
//  Created by Rocrail on 07.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iRocTableView.h"
#import "Block.h"
#import "Container.h"


@interface iRocBkTableView : iRocTableView {
	Container *bkContainer;
	id _delegate;
	NSString *menuname;
}

- (id)delegate;
- (void)setDelegate:(id)new_delegate;

@property (nonatomic, retain) Container *bkContainer;
@property (nonatomic, retain) NSString *menuname;

@end

@interface NSObject (iRocBkTableView)

- (void)bkAction:(NSString *)coid;

@end
