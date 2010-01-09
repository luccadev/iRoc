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

@synthesize locid, imgname, lcimage, hasImage, imageLoaded, desc, imageAlreadyRequested, roadname, 
            cell, dir, vstr, vmaxstr, Vmax, Vmid, Vmin, Placing, SpCnt, Vmode, Fn, Mode;

- (id) init {
	[super init];	
	imageLoaded = NO;
	hasImage = NO;	
  imageAlreadyRequested = FALSE;
	vstr = @"0";
  // Fuction states
  for(int i = 0; i < 32; i++)
    fnStates[i] = FALSE; 
  
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
  
  NSLog(@"update image in list for loc %@ loaded ...", self.locid);
  [_delegate performSelectorOnMainThread : @ selector(lcListUpdateCell: ) withObject:self waitUntilDone:YES];
  
  
	NSLog(@"image for loc %@ loaded ...", self.locid);
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

- (int) getVint {
	return [vstr intValue];
}

- (int) getVmax {
	return [vmaxstr intValue];
}

- (int) getVmid {
	return [Vmid intValue];
}

- (int) getVmin {
	return [Vmin intValue];
}

- (void)setFn:(int)fn withState:(BOOL)state {
  fnStates[fn] = state;
}

- (BOOL)isFn:(int)fn {
  return fnStates[fn];
}

- (BOOL)isPlacing {
  return [Placing compare:@"true"] == NSOrderedSame ? TRUE:FALSE;
}

- (BOOL)isAutoMode {
  BOOL autoMode = [Mode compare:@"auto"] == NSOrderedSame ? TRUE:FALSE;
  BOOL idleMode = [Mode compare:@"idle"] == NSOrderedSame ? TRUE:FALSE;
  return (autoMode | idleMode);
}

- (BOOL)isHalfAutoMode {
  return [Mode compare:@"halfauto"] == NSOrderedSame ? TRUE:FALSE;
}



/*
- (NSString*) locpicdata {
	return locpicdata;
}
 */


@end
