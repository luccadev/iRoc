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
}

- (void)setItem:(Item *)_item;

@end
