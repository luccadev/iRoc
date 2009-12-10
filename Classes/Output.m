//
//  Output.m
//  iRoc
//
//  Created by Jean-Michel Fischer on 09.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Output.h"


@implementation Output
@synthesize coid;

- (void)dealloc {
    [coid release];
    [super dealloc];
}
@end
