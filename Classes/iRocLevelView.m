//
//  iRocLevelView.m
//  iRoc
//
//  Created by Rocrail on 14.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "iRocLevelView.h"


@implementation iRocLevelView

- (id)init {
  if( self = [super init] ) {
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tracks.jpg"]];
  }
  return self;
}

- (void)loadView {
  [super loadView];
  [super.view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0]];
  CGRect bounds = [[UIScreen mainScreen] applicationFrame];
  scrollView = [[UIScrollView alloc] initWithFrame: bounds];
  scrollView.contentSize = imageView.frame.size;
  scrollView.delegate = self;
  [scrollView addSubview: imageView];
  self.view = scrollView;
}


@end
