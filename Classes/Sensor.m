//
//  Sensor.m
//  iRoc
//
//  Created by Rocrail on 15.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Sensor.h"


@implementation Sensor

- (id) initWithAttributeDict: (NSDictionary *)attributeDict {
  if( self = [super initWithAttributeDict:attributeDict] ) {
  }
  return self;
}

- (NSString*) getImgName {
	NSString *imgname = @"sensor-off-1.png";
	
	if( [self.state isEqual:@"true"]) {
		imgname = @"sensor-on-1.png";
	}
	
	return imgname;
}

@end
