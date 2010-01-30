//
//  iRocLevelTableView.h
//  iRoc
//
//  Created by Rocrail on 14.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iRocTableView.h"
#import "iRocLevelView.h"
#import "Model.h"
#import "ZLevel.h"


@interface iRocLevelTableView : iRocTableView {
  iRocLevelView *levelView;
  UILabel *planTitle;
  Model *model;
	id delegate;
}
IBOutlet iRocLevelView *levelView;
@property (nonatomic, retain) iRocLevelView *levelView;

- (id)initWithDelegate:(id)_delegate andModel:(Model*)_model;
- (void)planLoaded;

@end
