//
//  Route.m
//  iRoc
//
//  Created by Jean-Michel Fischer on 08.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Route.h"


@implementation Route

@synthesize rtid;

- (void)dealloc {
    [rtid release];
    [super dealloc];
}

@end
