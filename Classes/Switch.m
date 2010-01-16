//
//  Switch.m
//  iRoc
//
//  Created by Jean-Michel Fischer on 09.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Switch.h"
#import "iRocAppDelegate.h"


@implementation Switch
@synthesize swid;

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
	
	if( [self.type isEqual:@"right"]) {
		if( [self.state isEqual:@"straight"])
			imgname = [NSString stringWithFormat:@"turnout-rs-%d.png", orinr];
		else 
			imgname = [NSString stringWithFormat:@"turnout-rt-%d.png", orinr];
		
	} else if( [self.type isEqual:@"left"]) {
			if( [self.state isEqual:@"straight"])
				imgname = [NSString stringWithFormat:@"turnout-ls-%d.png", orinr];
			else 
				imgname = [NSString stringWithFormat:@"turnout-lt-%d.png", orinr];
	
	} else if( [self.type isEqual:@"threeway"]) {
    if( [self.state isEqual:@"straight"])
      imgname = [NSString stringWithFormat:@"threeway-s-%d.png", orinr];
    else if( [self.state isEqual:@"left"])
      imgname = [NSString stringWithFormat:@"threeway-l-%d.png", orinr];
    else 
      imgname = [NSString stringWithFormat:@"threeway-r-%d.png", orinr];
    
	} else if( [self.type isEqual:@"dcrossing"] ){
		imgname = [NSString stringWithFormat:@"dcross-rs-%d.png", orinr];
	} else {
		imgname = @"cross.png";
	}
	
	return imgname;
}

- (void)flip {
	NSLog(@"flip sw %@", Id);
	[delegate sendMessage:@"sw" message:[[NSString alloc] initWithString: [NSString stringWithFormat: @"<sw id=\"%@\" cmd=\"flip\"/>", swid]]];
}

- (void)updateEvent {
	NSLog(@"update event sw %@", Id);
  if( myview != nil )
    [myview updateEvent];
}

- (void)dealloc {
    [swid release];
	[type release];
    [super dealloc];
}
@end
