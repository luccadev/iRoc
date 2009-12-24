//
//  Output.m
//  iRoc
//
//  Created by Jean-Michel Fischer on 09.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Output.h"


@implementation Output
@synthesize coid, state;

- (void)dealloc {
    [coid release];
    [super dealloc];
}

- (NSString*) getImgName {
	NSString *imgname = @"on.png";
	
	if( [self.state isEqual:@"on"])
		imgname = @"on.png";
	else 
		imgname = @"off.png";
		
	return imgname;
}

@end
