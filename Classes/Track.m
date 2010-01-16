//
//  Track.m
//  iRoc
//
//  Created by Rocrail on 15.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Track.h"
#import "iRocAppDelegate.h"


@implementation Track

- (id) initWithAttributeDict: (NSDictionary *)attributeDict {
  if( self = [super initWithAttributeDict:attributeDict] ) {
  }
  return self;
}

- (NSString*) getImgName {
  int orinr = [self getOriNr];
	NSString *imgname = @"";
	
	if( [self.type isEqual:@"curve"]) {
		imgname = [NSString stringWithFormat: @"curve-%d.png", orinr];
	} else {
		imgname = [NSString stringWithFormat: @"track-%d.png", orinr];
	}
	
	return imgname;
}


@end
