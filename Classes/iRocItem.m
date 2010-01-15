//
//  iRocItem.m
//  iRoc
//
//  Created by Rocrail on 14.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "iRocItem.h"


@implementation iRocItem

- (id)initWithItem:(Item *)_item {
  item = _item;
	CGRect itemframe = CGRectMake(ITEMSIZE * item.x, ITEMSIZE * item.y, ITEMSIZE, ITEMSIZE);	
  if( self = [super initWithFrame:itemframe] ) {
    NSLog(@"item image=%@ x,y=%d,%d", [item getImgName], item.x, item.y);
  	image = [UIImage imageNamed:[item getImgName]];
    CGRect imageframe = CGRectMake(0, 0, ITEMSIZE, ITEMSIZE);	
	  imageview = [[UIImageView alloc] initWithFrame:imageframe];
  	imageview.image = image; 
    [item setView:self];
	  [self addSubview:imageview];  
  }
  
  return self;

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  NSLog(@"touches ended for item %@", item.Id);
  [item flip];
}

- (void)updateEvent {
  NSLog(@"update event for item %@", item.Id);
  image = [UIImage imageNamed:[item getImgName]];
  imageview.image = image; 
}

- (id)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
	}
  return self;
}

- (void)dealloc {
  [item setView:nil];
  [imageview release];
  [image release];
  [super dealloc];
}


@end
