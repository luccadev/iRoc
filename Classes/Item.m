//
//  Item.m
//  iRoc
//
//  Created by Rocrail on 14.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Item.h"
#import "Globals.h"


@implementation Item
@synthesize x, y, z, show, ori;


- (id) initWithAttributeDict: (NSDictionary *)attributeDict {
  if( self = [super init] ) {
    NSString *tmp = [Globals getAttribute:@"x" fromDict:attributeDict withDefault:@"0"];
    x = [tmp intValue];
    [tmp release];
    tmp = [Globals getAttribute:@"y" fromDict:attributeDict withDefault:@"0"];
    y = [tmp intValue];
    [tmp release];
    tmp = [Globals getAttribute:@"z" fromDict:attributeDict withDefault:@"0"];
    z = [tmp intValue];
    [tmp release];
    tmp = [Globals getAttribute:@"show" fromDict:attributeDict withDefault:@"true"];
    show = [tmp isEqual:@"true"];
    
    ori = [Globals getAttribute:@"ori" fromDict:attributeDict withDefault:@"west"]; 
    
    NSLog(@"x=%d y=%d z=%d ori=%@", x, y, z, ori);
  }
  return self;
}


- (NSString*) getImgName {
  return @"?";
}

@end
