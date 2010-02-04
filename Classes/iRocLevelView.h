//
//  iRocLevelView.h
//  iRoc
//
//  Created by Rocrail on 14.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"
#import "ZLevel.h"
#import "iRocItem.h"


@interface iRocLevelView : UIViewController <UIScrollViewDelegate> {
  UIScrollView *scrollView;
  BOOL isLoaded;
  ZLevel *zlevel;
  Model* model;
}
@property (nonatomic, retain) ZLevel *zlevel;
@property (nonatomic, retain) Model *model;

- (void)reView;
- (void)gotoLocoTab;

@end
