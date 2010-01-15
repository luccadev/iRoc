//
//  Block.m
//  iRoc
//
//  Created by Rocrail on 07.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Block.h"


@implementation Block
@synthesize ID;


- (void)dealloc {
  [ID release];
  [super dealloc];
}

@end
