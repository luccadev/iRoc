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
	CGRect itemframe = CGRectMake(ITEMSIZE * item.x, ITEMSIZE * item.y, ITEMSIZE * item.cx, ITEMSIZE * item.cy);	
  if( self = [super initWithFrame:itemframe] ) {
    NSLog(@"item image=%@ x,y=%d,%d", [item getImgName], item.x, item.y);
    [self addTarget:self action: @selector(itemAction:)
   forControlEvents: UIControlEventTouchDown ];
    
  	image = [UIImage imageNamed:[item getImgName]];
    CGRect imageframe = CGRectMake(0, 0, ITEMSIZE * item.cx, ITEMSIZE * item.cy);	
	  imageview = [[UIImageView alloc] initWithFrame:imageframe];
  	imageview.image = image; 
    [item setView:self];
	  [self addSubview:imageview];  
    
    if( item.text != nil && [item.text length] > 0 ) {
      UILabel* label = [[[UILabel alloc] initWithFrame:CGRectMake(5, 6, ITEMSIZE * item.cx - 10, ITEMSIZE / 2 )] autorelease];
      label.font = [UIFont boldSystemFontOfSize:12];
      label.textColor = [UIColor grayColor];
      label.backgroundColor = [UIColor clearColor];
      label.text = item.text;
      label.textAlignment = UITextAlignmentCenter;
      [self addSubview:label];  
    }
  }
  
  return self;

}


- (NSString *)getId {
  return item.Id;
}

- (void)itemAction:(id)sender {
  NSLog(@"action for item %@", item.Id);
  [self setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:0 alpha:1.0]];
  [item flip];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  NSLog(@"touches ended for item %@", item.Id);
  [self setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1.0]];
    //[item flip];
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

- (void)disable {
  imageview.hidden = YES;
  [item setView:nil];
}

- (void)dealloc {
  [imageview removeFromSuperview];
  [imageview release];
  [super dealloc];
}


@end
