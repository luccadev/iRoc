//
//  iRocLevelView.m
//  iRoc
//
//  Created by Rocrail on 14.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "iRocLevelView.h"


@implementation iRocLevelView
@synthesize model, zlevel;

- (id)init {
  if( self = [super init] ) {
  }
  return self;
}

- (void)reView {
  NSLog(@"reView level %@", zlevel.title);
    // remove the existing items
  NSArray *its = scrollView.subviews;
  int cnt = [its count];
  NSLog(@"remove %d items", cnt);
  for( int i = 0; i < cnt; i++ ) {
    iRocItem* it = (iRocItem *)[its objectAtIndex:i];
    [it removeFromSuperview];
    [it release];
  }
    // add the items for this level
  cnt = [model.swContainer count];
  NSLog(@"add %d items for level %@", cnt, zlevel.title);
  for( int i = 0; i < cnt; i++ ) {
    Item * item = (Item *)[model.swContainer objectAtIndex:i];
    if( item.z == zlevel.level ) {
      iRocItem *it = [[iRocItem alloc] initWithItem:item];
      [scrollView addSubview:it];
    }
  }
}


- (void)loadView {
  [super loadView];
  [super.view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0]];
  CGRect bounds = [[UIScreen mainScreen] applicationFrame];
  scrollView = [[UIScrollView alloc] initWithFrame: bounds];
  CGSize plansize = CGSizeMake(ITEMSIZE*80, ITEMSIZE*60);	
  scrollView.contentSize = plansize;
  scrollView.delegate = self;
  [scrollView setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1.0]];
  self.view = scrollView;
  [self reView];
}


@end
