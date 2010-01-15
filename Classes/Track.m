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
	NSString *imgname = @"track-1.png";
	
	if( [self.type isEqual:@"curve"]) {
		imgname = @"curve-1.png";
	} else {
		imgname = @"track-1.png";
	}
	
	return imgname;
}


@end
