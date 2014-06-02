/*
 Rocrail - Model Railroad Software
 
 Copyright (C) 2009-2010 - Rob Versluis <r.j.versluis@rocrail.net>, Jean-Michel Fischer <jmf@polygonpunkt.de>
 
 This program is free software; you can redistribute it and/or
 modify it under the terms of the GNU General Public License
 as published by the Free Software Foundation; either version 2
 of the License, or (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 */


#import "iRocLevelView.h"


@implementation iRocLevelView
@synthesize model, zlevel;

- (id)init {
  if( (self = [super init]) ) {
    NSLog(@"levelView init");
  }
	
	self.navigationItem.rightBarButtonItem=[[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Loco", @"") style:UIBarButtonItemStylePlain target:self action:@selector(gotoLocoTab)] autorelease];
  
	// hide the tabs
	self.hidesBottomBarWhenPushed = YES;
	
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
  int cnt = (int)[its count];
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
  
  
  int cx = 0;
  int cy = 0;
    // add the items for this level
	float lcnt = 0;
	date = [NSDate date];
	
  NSEnumerator * itemEnum = [model.tkContainer getEnumerator];
  Item * item = nil;
  while ((item = (Item*)[itemEnum nextObject])) {
    if( item.z == zlevel.level ) {
      lcnt++;
      iRocItem *it = [[iRocItem alloc] initWithItem:item];
      if( item.x + item.cx > cx ) cx = item.x + item.cx;
      if( item.y + item.cy > cy ) cy = item.y + item.cy;
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
      if( item.x + item.cx > cx ) cx = item.x + item.cx;
      if( item.y + item.cy > cy ) cy = item.y + item.cy;
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
      if( item.x + item.cx > cx ) cx = item.x + item.cx;
      if( item.y + item.cy > cy ) cy = item.y + item.cy;
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
      if( item.x + item.cx > cx ) cx = item.x + item.cx;
      if( item.y + item.cy > cy ) cy = item.y + item.cy;
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
      if( item.x + item.cx > cx ) cx = item.x + item.cx;
      if( item.y + item.cy > cy ) cy = item.y + item.cy;
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
      if( item.x + item.cx > cx ) cx = item.x + item.cx;
      if( item.y + item.cy > cy ) cy = item.y + item.cy;
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
      if( item.x + item.cx > cx ) cx = item.x + item.cx;
      if( item.y + item.cy > cy ) cy = item.y + item.cy;
      [scrollView addSubview:it];
    }
  }
    
    NSLog(@"Time: %f sec per item", [date timeIntervalSinceNow]/lcnt*(-1));
    lcnt = 0;
	date = [NSDate date];
    
	itemEnum = [model.ttContainer getEnumerator];
    item = nil;
    while ((item = (Item*)[itemEnum nextObject])) {
        if( item.z == zlevel.level ) {
            lcnt++;
            iRocItem *it = [[iRocItem alloc] initWithItem:item];
            if( item.x + item.cx > cx ) cx = item.x + item.cx;
            if( item.y + item.cy > cy ) cy = item.y + item.cy;
            [scrollView addSubview:it];
        }
    }
	
	NSLog(@"Time: %f sec per item", [date timeIntervalSinceNow]/lcnt*(-1));
	date = [NSDate date];
  
	NSLog(@"cx=%d, cy=%d", cx, cy);
  CGSize plansize = CGSizeMake(ITEMSIZE*cx, ITEMSIZE*cy);	
  scrollView.contentSize = plansize;
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

- (void)viewWillAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	//NSLog(@"view will appear");
	//[[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewDidAppear:animated];
	//NSLog(@"view will disappear");
  //[[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
  NSLog(@"rotation message: will be rotated...");
  return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
  NSLog(@"rotation message: rearange the layout... from: %d", (int)fromInterfaceOrientation);
}

- (void)gotoLocoTab {
	[self.tabBarController setSelectedIndex:0];
}

@end
