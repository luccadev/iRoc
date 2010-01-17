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
    // remove the existing items
  NSArray *its = scrollView.subviews;
  int cnt = [its count];
  NSLog(@"remove %d items", cnt);
  for( int i = 0; i < cnt; i++ ) {
    if( [[its objectAtIndex:i] isKindOfClass:[iRocItem class]] ) {
      iRocItem* it = (iRocItem *)[its objectAtIndex:i];
      NSLog(@"removing %@", [it getId]);
      it.hidden = YES;
      [it disable];
      [it removeFromSuperview];
      [it release];
    }
  }
    // add the items for this level
	
	NSDate *date = [NSDate date];
	
  cnt = [model.swContainer count];
  NSLog(@"add %d switches for level %@", cnt, zlevel.title);
  for( int i = 0; i < cnt; i++ ) {
    Item * item = (Item *)[model.swContainer objectAtIndex:i];
    if( item.z == zlevel.level ) {
      iRocItem *it = [[iRocItem alloc] initWithItem:item];
      [scrollView addSubview:it];
    }
  }

	NSLog(@"Time: %f sec per item", [date timeIntervalSinceNow]/cnt*(-1));
	date = [NSDate date];
	
  cnt = [model.sgContainer count];
  NSLog(@"add %d signals for level %@", cnt, zlevel.title);
  for( int i = 0; i < cnt; i++ ) {
    Item * item = (Item *)[model.sgContainer objectAtIndex:i];
    if( item.z == zlevel.level ) {
      iRocItem *it = [[iRocItem alloc] initWithItem:item];
      [scrollView addSubview:it];
    }
  }
	

	NSLog(@"Time: %f sec per item", [date timeIntervalSinceNow]/cnt*(-1));
	date = [NSDate date];
	
  cnt = [model.tkContainer count];
  NSLog(@"add %d tracks for level %@", cnt, zlevel.title);
  for( int i = 0; i < cnt; i++ ) {
    Item * item = (Item *)[model.tkContainer objectAtIndex:i];
    if( item.z == zlevel.level ) {
      iRocItem *it = [[iRocItem alloc] initWithItem:item];
      [scrollView addSubview:it];
    }
  }
	
	NSLog(@"Time: %f sec per item", [date timeIntervalSinceNow]/cnt*(-1));
	date = [NSDate date];

  cnt = [model.fbContainer count];
  NSLog(@"add %d sensors for level %@", cnt, zlevel.title);
  for( int i = 0; i < cnt; i++ ) {
    Item * item = (Item *)[model.fbContainer objectAtIndex:i];
    if( item.z == zlevel.level ) {
      iRocItem *it = [[iRocItem alloc] initWithItem:item];
      [scrollView addSubview:it];
    }
  }
	
	NSLog(@"Time: %f sec per item", [date timeIntervalSinceNow]/cnt*(-1));
	date = [NSDate date];
  
  cnt = [model.bkContainer count];
  NSLog(@"add %d blocks for level %@", cnt, zlevel.title);
  for( int i = 0; i < cnt; i++ ) {
    Item * item = (Item *)[model.bkContainer objectAtIndex:i];
    if( item.z == zlevel.level ) {
      iRocItem *it = [[iRocItem alloc] initWithItem:item];
      [scrollView addSubview:it];
    }
  }
  
	NSLog(@"Time: %f sec per item", [date timeIntervalSinceNow]/cnt*(-1));
	date = [NSDate date];
	
  cnt = [model.coContainer count];
  NSLog(@"add %d outputs for level %@", cnt, zlevel.title);
  for( int i = 0; i < cnt; i++ ) {
    Item * item = (Item *)[model.coContainer objectAtIndex:i];
    if( item.z == zlevel.level ) {
      iRocItem *it = [[iRocItem alloc] initWithItem:item];
      [scrollView addSubview:it];
    }
  }
	
	NSLog(@"Time: %f sec per item", [date timeIntervalSinceNow]/cnt*(-1));
	date = [NSDate date];
  
  cnt = [model.txContainer count];
  NSLog(@"add %d texts for level %@", cnt, zlevel.title);
  for( int i = 0; i < cnt; i++ ) {
    Item * item = (Item *)[model.txContainer objectAtIndex:i];
    if( item.z == zlevel.level ) {
      iRocItem *it = [[iRocItem alloc] initWithItem:item];
      [scrollView addSubview:it];
    }
  }
	
	NSLog(@"Time: %f sec per item", [date timeIntervalSinceNow]/cnt*(-1));
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
