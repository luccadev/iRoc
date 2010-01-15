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

- (id) initWithAttributeDict: (NSDictionary *)attributeDict {
  if( self = [super initWithAttributeDict:attributeDict] ) {
    cx = 4; // TODO: check ori
  }
  return self;
}

- (NSString*) getImgName {
	NSString *imgname = @"block-1.png";
	
	
	return imgname;
}

- (void)dealloc {
  [ID release];
  [super dealloc];
}

@end
