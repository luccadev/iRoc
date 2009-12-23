//
//  Loc.m
//  iRoc
//
//  Created by Jean-Michel Fischer on 07.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Loc.h"
#import "iRocAppDelegate.h"


@implementation Loc

@synthesize locid, imgname, lcimage, hasImage, imageLoaded, desc, imageAlreadyRequested, myrow;

- (id) init {
	[super init];	
	imageLoaded = NO;
	hasImage = NO;	
  imageAlreadyRequested = FALSE;
  myrow = -1;
	return self;
}

- (void)dealloc {
    [locid release];
	[locpicdata release];
	[imgname release];
	[lcimage release];
    [super dealloc];
}

- (void)setDelegate:(id)new_delegate
{
  _delegate = new_delegate;
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
  
  if ( myrow != -1 ) {
    NSNumber* number = [NSNumber numberWithInt:myrow];
    NSLog(@"update image in list for loc[%d]: %@ loaded ...", myrow, self.locid);
    [_delegate performSelectorOnMainThread : @ selector(lcListReloadRow: ) withObject:number waitUntilDone:NO];
  } 
  
  
	NSLog(@"image for loc[%d]: %@ loaded ...", myrow, self.locid);
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
