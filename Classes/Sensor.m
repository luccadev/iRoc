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
    NSString *tmp = [Globals getAttribute:@"curve" fromDict:attributeDict withDefault:@"false"];
    curve = [tmp isEqual:@"true"];
  }
  return self;
}

- (NSString*) getImgName {
  int orinr = [self getOriNr];
	NSString *imgname = @"";
	NSString *prefix = @"";
  
  if( curve )
    prefix = @"c";
  else
    orinr % 2 == 0 ? 2:1;
	
	if( [self.state isEqual:@"true"]) {
		imgname = [NSString stringWithFormat: @"%@sensor-on-%d.png", prefix, orinr];
	}
  else {
		imgname = [NSString stringWithFormat: @"%@sensor-off-%d.png", prefix, orinr];
  }
	
	return imgname;
}

- (void)flip {
	NSLog(@"flip fb %@", Id);
	[delegate sendMessage:@"fb" message:[[NSString alloc] initWithString: 
    [NSString stringWithFormat: @"<fb id=\"%@\" state=\"%@\"/>", Id, [state isEqual:@"true"]?@"false":@"true"]]];
}



@end
