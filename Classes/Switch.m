//
//  Switch.m
//  iRoc
//
//  Created by Jean-Michel Fischer on 09.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Switch.h"


@implementation Switch
@synthesize swid, type, state;


- (NSString*) getImgName {
	NSString *imgname = @"turnout-rs-1.png";
	
	if( [self.type isEqual:@"right"]) {
		if( [self.state isEqual:@"straight"])
			imgname = @"turnout-rs-1.png";
		else 
			imgname = @"turnout-rt-1.png";
		
	} else if( [self.type isEqual:@"left"]) {
			if( [self.state isEqual:@"straight"])
				imgname = @"turnout-ls-1.png";
			else 
				imgname = @"turnout-lt-1.png";
	
	} else if( [self.type isEqual:@"threeway"]) {
    if( [self.state isEqual:@"straight"])
      imgname = @"threeway-s-1.png";
    else if( [self.state isEqual:@"left"])
      imgname = @"threeway-l-1.png";
    else 
      imgname = @"threeway-r-1.png";
    
	} else if( [self.type isEqual:@"dcrossing"] ){
		imgname = @"dcross-rs-1.png";
	} else {
		imgname = @"cross.png";
	}
	
	return imgname;
}



- (void)dealloc {
    [swid release];
	[type release];
    [super dealloc];
}
@end
