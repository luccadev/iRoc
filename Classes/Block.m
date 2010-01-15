//
//  Block.m
//  iRoc
//
//  Created by Rocrail on 07.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Block.h"
#import "Globals.h"


@implementation Block
@synthesize ID;

- (id) initWithAttributeDict: (NSDictionary *)attributeDict {
  if( self = [super initWithAttributeDict:attributeDict] ) {
    text = [Globals getAttribute:@"locid"    fromDict:attributeDict withDefault:@""]; 
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
