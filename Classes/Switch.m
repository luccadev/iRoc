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


- (NSString*) getImgName {
	NSString *imgname = @"turnout-rs-1.png";
	
	if( [self.type isEqual:@"right"]) {
		imgname = @"turnout-rs-1.png";
	} else if( [self.type isEqual:@"dcrossing"] ){
		imgname = @"dcross-rs-1.png";
	} else {
		imgname = @"turnout-ls-1.png";
	}
	
	return imgname;
}



- (void)dealloc {
    [swid release];
	[type release];
    [super dealloc];
}
@end
