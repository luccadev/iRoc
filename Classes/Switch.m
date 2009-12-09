//
//  Switch.m
//  iRoc
//
//  Created by Jean-Michel Fischer on 09.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Switch.h"


@implementation Switch
@synthesize swid, type;

- (void)dealloc {
    [swid release];
	[type release];
    [super dealloc];
}
@end
