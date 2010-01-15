//
//  Signal.m
//  iRoc
//
//  Created by Rocrail on 09.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Signal.h"
#import "iRocAppDelegate.h"


@implementation Signal

@synthesize ID;

- (id) initWithAttributeDict: (NSDictionary *)attributeDict {
  if( self = [super initWithAttributeDict:attributeDict] ) {
  }
  return self;
}


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

- (void)flip {
	NSLog(@"flip sg %@", Id);
	[delegate sendMessage:@"sg" message:[[NSString alloc] initWithString: 
      [NSString stringWithFormat: @"<sg id=\"%@\" cmd=\"flip\"/>", Id]]];
}

- (void)updateEvent {
	NSLog(@"update event sg %@", Id);
  if( myview != nil )
    [myview updateEvent];
}




- (void)dealloc {
  [super dealloc];
}

@end
