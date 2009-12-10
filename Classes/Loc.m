//
//  Loc.m
//  iRoc
//
//  Created by Jean-Michel Fischer on 07.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Loc.h"


@implementation Loc

@synthesize locid, locpic;

- (void)dealloc {
    [locid release];
	[locpic release];
    [super dealloc];
}

@end
