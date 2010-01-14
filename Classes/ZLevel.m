//
//  ZLevel.m
//  iRoc
//
//  Created by Rocrail on 14.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ZLevel.h"
#import "Globals.h"


@implementation ZLevel
@synthesize level, title, zlevel, menuname;


- (id) initWithAttributeDict: (NSDictionary *)attributeDict {
  if( self = [super init] ) {
    
    zlevel = [Globals getAttribute:@"z"     fromDict:attributeDict withDefault:@""]; 
    title  = [Globals getAttribute:@"title" fromDict:attributeDict withDefault:@""]; 

    level = [zlevel intValue];
    menuname = [[NSString alloc] initWithFormat:@"%02d - %@", level, title];
    
    NSLog(@"zlevel z=%d title=%@", level, title);
  }
  return self;
}

@end
