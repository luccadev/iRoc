//
//  iRocItem.h
//  iRoc
//
//  Created by Rocrail on 14.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"


@interface iRocItem : UIControl {
  Item *item;
  UIImage *image;
  UIImageView *imageview;
}

- (id)initWithItem:(Item *)_item;
- (void)updateEvent;

@end
