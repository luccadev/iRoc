//
//  Schedule.m
//  iRoc
//
//  Created by Rocrail on 07.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Schedule.h"


@implementation Schedule
@synthesize ID, state;

- (void)dealloc {
  [ID release];
  [super dealloc];
}

@end
