//
//  Output.m
//  iRoc
//
//  Created by Jean-Michel Fischer on 09.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Output.h"
#import "iRocAppDelegate.h"


@implementation Output
@synthesize coid;

- (id) initWithAttributeDict: (NSDictionary *)attributeDict {
  if( self = [super initWithAttributeDict:attributeDict] ) {
  }
  return self;
}

- (void)dealloc {
    [coid release];
    [super dealloc];
}

- (NSString*) getImgName {
	NSString *imgname = @"button-on.png";
	
	if( [self.state isEqual:@"on"])
		imgname = @"button-on.png";
	else if( [self.state isEqual:@"active"])
		imgname = @"button-active.png";
	else 
		imgname = @"button-off.png";
		
	return imgname;
}

- (void)flip {
	NSLog(@"flip co %@", Id);
	[delegate sendMessage:@"co" message:[[NSString alloc] initWithString: 
                                       [NSString stringWithFormat: @"<co id=\"%@\" cmd=\"flip\"/>", Id]]];
}

- (void)updateEvent {
	NSLog(@"update event co %@", Id);
  if( myview != nil )
    [myview updateEvent];
}


@end
