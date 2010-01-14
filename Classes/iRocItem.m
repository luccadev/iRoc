//
//  iRocItem.m
//  iRoc
//
//  Created by Rocrail on 14.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "iRocItem.h"


@implementation iRocItem


- (id)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
	}
  return self;
}

- (void)setItem:(Item *)_item {
  item = _item;
}

@end
