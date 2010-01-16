//
//  Sensor.m
//  iRoc
//
//  Created by Rocrail on 15.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Sensor.h"
#import "iRocAppDelegate.h"


@implementation Sensor

- (id) initWithAttributeDict: (NSDictionary *)attributeDict {
  if( self = [super initWithAttributeDict:attributeDict] ) {
  }
  return self;
}

- (NSString*) getImgName {
  int orinr = [self getOriNr];
	NSString *imgname = @"";
	
	if( [self.state isEqual:@"true"]) {
		imgname = [NSString stringWithFormat: @"sensor-on-%d.png", orinr % 2 == 0 ? 2:1];
	}
  else {
		imgname = [NSString stringWithFormat: @"sensor-off-%d.png", orinr % 2 == 0 ? 2:1];
  }
	
	return imgname;
}

- (void)flip {
	NSLog(@"flip fb %@", Id);
	[delegate sendMessage:@"fb" message:[[NSString alloc] initWithString: 
    [NSString stringWithFormat: @"<fb id=\"%@\" state=\"%@\"/>", Id, [state isEqual:@"true"]?@"false":@"true"]]];
}



@end
