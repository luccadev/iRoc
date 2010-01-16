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
  int orinr = [self getOriNr];

    // symbol naming fix (see rocrail/impl/pclient.c line 250)
  if( orinr == 1 )
    orinr = 3;
  else if( orinr == 3 )
    orinr = 1;
  
	NSString *imgname = @"";
	
  if( [self.state isEqual:@"red"])
		imgname = [NSString stringWithFormat:@"signal-r-%d.png", orinr];
  else if( [self.state isEqual:@"green"])
		imgname = [NSString stringWithFormat:@"signal-g-%d.png", orinr];
  else if( [self.state isEqual:@"yellow"])
		imgname = [NSString stringWithFormat:@"signal-y-%d.png", orinr];
	else 
		imgname = [NSString stringWithFormat:@"signal-w-%d.png", orinr];
  
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
