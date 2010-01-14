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
  Model *model;
	id _delegate;
}
IBOutlet iRocLevelView *levelView;

- (void)setDelegate:(id)new_delegate withModel:(Model*)_model;

@end
