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
    NSLog(@"levelView init");
  }
  return self;
}

- (void)reView {
  if( !isLoaded ) {
    NSLog(@"level %@ is not jet loaded...", zlevel.title);
    return;
  }
  NSLog(@"reView level %@", zlevel.title);
  NSDate *date = [NSDate date];
  // remove the existing items
  NSArray *its = scrollView.subviews;
  int cnt = [its count];
  NSLog(@"remove %d items", cnt);
  for( int i = 0; i < cnt; i++ ) {
    if( [[its objectAtIndex:i] isKindOfClass:[iRocItem class]] ) {
      iRocItem* it = (iRocItem *)[its objectAtIndex:i];
      it.hidden = YES;
      [it disable];
      [it removeFromSuperview];
      [it release];
    }
  }
	NSLog(@"Time: %f sec per deleted item", [date timeIntervalSinceNow]/(float)cnt*(-1));
  
    // add the items for this level
	float lcnt = 0;
	date = [NSDate date];
	
  NSEnumerator * itemEnum = [model.tkContainer getEnumerator];
  Item * item = nil;
  while ((item = (Item*)[itemEnum nextObject])) {
    if( item.z == zlevel.level ) {
      lcnt++;
      iRocItem *it = [[iRocItem alloc] initWithItem:item];
      [scrollView addSubview:it];
    }
  }

	NSLog(@"Time: %f sec per item", [date timeIntervalSinceNow]/lcnt*(-1));
  lcnt = 0;
	date = [NSDate date];
	
	itemEnum = [model.sgContainer getEnumerator];
  item = nil;
  while ((item = (Item*)[itemEnum nextObject])) {
    if( item.z == zlevel.level ) {
      lcnt++;
      iRocItem *it = [[iRocItem alloc] initWithItem:item];
      [scrollView addSubview:it];
    }
  }
	
	NSLog(@"Time: %f sec per item", [date timeIntervalSinceNow]/lcnt*(-1));
  lcnt = 0;
	date = [NSDate date];
	
  itemEnum = [model.swContainer getEnumerator];
  item = nil;
  while ((item = (Item*)[itemEnum nextObject])) {
    if( item.z == zlevel.level ) {
      lcnt++;
      iRocItem *it = [[iRocItem alloc] initWithItem:item];
      [scrollView addSubview:it];
    }
  }
	
	NSLog(@"Time: %f sec per item", [date timeIntervalSinceNow]/lcnt*(-1));
  lcnt = 0;
	date = [NSDate date];

	itemEnum = [model.fbContainer getEnumerator];
  item = nil;
  while ((item = (Item*)[itemEnum nextObject])) {
    if( item.z == zlevel.level && item.show ) {
      lcnt++;
      iRocItem *it = [[iRocItem alloc] initWithItem:item];
      [scrollView addSubview:it];
    }
  }
	
	NSLog(@"Time: %f sec per item", [date timeIntervalSinceNow]/lcnt*(-1));
  lcnt = 0;
	date = [NSDate date];
  
	itemEnum = [model.bkContainer getEnumerator];
  item = nil;
  while ((item = (Item*)[itemEnum nextObject])) {
    if( item.z == zlevel.level ) {
      lcnt++;
      iRocItem *it = [[iRocItem alloc] initWithItem:item];
      [scrollView addSubview:it];
    }
  }
	
	
	NSLog(@"Time: %f sec per item", [date timeIntervalSinceNow]/lcnt*(-1));
  lcnt = 0;
	date = [NSDate date];
	
	
	itemEnum = [model.coContainer getEnumerator];
  item = nil;
  while ((item = (Item*)[itemEnum nextObject])) {
    if( item.z == zlevel.level ) {
      lcnt++;
      iRocItem *it = [[iRocItem alloc] initWithItem:item];
      [scrollView addSubview:it];
    }
  }

	
	NSLog(@"Time: %f sec per item", [date timeIntervalSinceNow]/lcnt*(-1));
  lcnt = 0;
	date = [NSDate date];
  
	itemEnum = [model.txContainer getEnumerator];
  item = nil;
  while ((item = (Item*)[itemEnum nextObject])) {
    if( item.z == zlevel.level ) {
      lcnt++;
      iRocItem *it = [[iRocItem alloc] initWithItem:item];
      [scrollView addSubview:it];
    }
  }
	
	NSLog(@"Time: %f sec per item", [date timeIntervalSinceNow]/lcnt*(-1));
	date = [NSDate date];
  
}


- (void)loadView {
  NSLog(@"levelView loadView");
  [super loadView];
  [super.view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0]];
  CGRect bounds = [[UIScreen mainScreen] applicationFrame];
  scrollView = [[UIScrollView alloc] initWithFrame: bounds];
  CGSize plansize = CGSizeMake(ITEMSIZE*80, ITEMSIZE*60);	
  scrollView.contentSize = plansize;
  scrollView.delegate = self;
	
	NSUserDefaults *defaults = [[NSUserDefaults standardUserDefaults] retain];
	if([[defaults stringForKey:@"plancolor_preference"] isEqual:@"green"])
		[scrollView setBackgroundColor:[UIColor colorWithRed:.7 green:.9 blue:.7 alpha:1.0]];
	else if([[defaults stringForKey:@"plancolor_preference"] isEqual:@"grey"])
	  [scrollView setBackgroundColor:[UIColor colorWithRed:.8 green:.8 blue:.8 alpha:1.0]];
	else
		[scrollView setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1.0]];	
	
  self.view = scrollView;
  isLoaded = TRUE;
  [self reView];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
  NSLog(@"rotation message: will be rotated...");
  return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
  NSLog(@"rotation message: rearange the layout...");
}



@end
