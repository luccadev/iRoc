//
//  Signal.m
//  iRoc
//
//  Created by Rocrail on 09.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Signal.h"


@implementation Signal

@synthesize ID, type, state;


- (NSString*) getImgName {
	NSString *imgname = @"signal-r-4.png";
	
  if( [self.state isEqual:@"red"])
		imgname = @"signal-r-4.png";
  else if( [self.state isEqual:@"green"])
		imgname = @"signal-g-4.png";
  else if( [self.state isEqual:@"yellow"])
		imgname = @"signal-y-4.png";
	else 
		imgname = @"signal-w-4.png";
  
	return imgname;
}



- (void)dealloc {
  [ID release];
	[type release];
  [super dealloc];
}

@end
