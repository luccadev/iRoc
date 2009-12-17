//
//  Loc.m
//  iRoc
//
//  Created by Jean-Michel Fischer on 07.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Loc.h"


@implementation Loc

@synthesize locid, imgname, lcimage, hasImage, imageLoaded, desc, imageAlreadyRequested;

- (id) init {
	[super init];	
	imageLoaded = NO;
	hasImage = NO;	
  imageAlreadyRequested = FALSE;
	return self;
}

- (void)dealloc {
    [locid release];
	[locpicdata release];
	[imgname release];
	[lcimage release];
    [super dealloc];
}

- (void) prepareImage {
	int i = 0;
	int len = [locpicdata length]; // StrOp.len(s);
	unsigned char b[len/2 + 1];
	for( i = 0; i < len; i+=2 ) {
		char val[3] = {0};
		val[0] = [locpicdata characterAtIndex:i];  //s[i];
		val[1] = [locpicdata characterAtIndex:i+1];
		val[2] = '\0';
		b[i/2] = (unsigned char)(strtol( val, NULL, 16)&0xFF);
	}
	
	NSData *data = [NSData dataWithBytes:(unsigned char*)b length:(len/2 + 1)];
	
	self.lcimage = [[[UIImage alloc] initWithData:data] retain];
	
	imageLoaded = YES;
	
	NSLog(@"image for loc: %@ loaded ...", self.locid);
}

- (UIImage*) getImage {
	
	if( !imageLoaded ) {
		[self prepareImage];
		NSLog(@"image for loc: %@ prepare called ...", self.locid);
	}
	

	if( self.hasImage && self.imageLoaded ){
		return self.lcimage;
	} else {
		return NULL;
	}
}


- (void) setLocpicdata:(NSString *) picdata {	
	locpicdata = picdata;
	
	[self prepareImage];
	
	NSLog(@"SETLOCPICDATA FOR: %@", self.locid);
	
}
/*
- (NSString*) locpicdata {
	return locpicdata;
}
 */


@end
