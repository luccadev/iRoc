//
//  Text.m
//  iRoc
//
//  Created by Rocrail on 16.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Text.h"


@implementation Text

- (id) initWithAttributeDict: (NSDictionary *)attributeDict {
  if( self = [super initWithAttributeDict:attributeDict] ) {
    text = [Globals getAttribute:@"text" fromDict:attributeDict withDefault:@""]; 
  }
  return self;
}

- (NSString*) getImgName {
	return nil;
}


@end
