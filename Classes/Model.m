//
//  Model.m
//  iRoc
//
//  Created by Rocrail on 14.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Model.h"


@implementation Model
@synthesize levelContainer, swContainer, tkContainer, fbContainer;

- (id) init {
  if( self = [super init] ) {
    levelContainer = [[[Container alloc] init] retain];
    swContainer    = [[[Container alloc] init] retain];
    tkContainer    = [[[Container alloc] init] retain];
    fbContainer    = [[[Container alloc] init] retain];
  }
  return self;
}


@end
