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
    locid    = [Globals getAttribute:@"locid"    fromDict:attributeDict withDefault:@" "]; 
    reserved = [Globals getAttribute:@"reserved" fromDict:attributeDict withDefault:@"false"]; 
    entering = [Globals getAttribute:@"entering" fromDict:attributeDict withDefault:@"false"]; 
    text = locid;
    [self updateTextColor];
  }
  return self;
}

- (void)updateTextColor {
  if( [locid length] > 0 ) {
    if( [reserved isEqual:@"true"] )
      textBackgroundColor = [[UIColor colorWithRed:.4 green:1 blue:1 alpha:1] retain];
    if( [entering isEqual:@"true"] )
      textBackgroundColor = [[UIColor colorWithRed:.4 green:.4 blue:1 alpha:1] retain];
    else
      textBackgroundColor = [[UIColor colorWithRed:1 green:.4 blue:.4 alpha:1] retain];
  }
  else {
    textBackgroundColor = [UIColor clearColor];
  }
}


- (NSString*) getImgName {
  int orinr = [self getOriNr];
	NSString *imgname = @"";

	if( orinr % 2 == 0 ) {
      //vertical
    cx = 1;
    cy = 4;
    textVertical = TRUE;
    imgname = @"block-2.png";
  }
  else {
      //horizontal
    cx = 4;
    cy = 1;
    textVertical = FALSE;
    imgname = @"block-1.png";
  }
  
	
	return imgname;
}


- (void) updateWithAttributeDict: (NSDictionary *)attributeDict {
  [super updateWithAttributeDict:attributeDict]; 
  locid    = [Globals getAttribute:@"locid"    fromDict:attributeDict withDefault:locid]; 
  reserved = [Globals getAttribute:@"reserved" fromDict:attributeDict withDefault:reserved]; 
  entering = [Globals getAttribute:@"entering" fromDict:attributeDict withDefault:entering]; 
  text = locid; 
  [self updateTextColor];
}

- (void)updateEvent {
	NSLog(@"update event bk %@", Id);
  if( myview != nil )
    [myview updateEvent];
}


- (void)dealloc {
  [ID release];
  [super dealloc];
}

@end
