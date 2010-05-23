//
//  Loc.m
//  iRoc
//
//  Created by Jean-Michel Fischer on 07.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Loc.h"
#import "iRocAppDelegate.h"
#import "Globals.h"


@implementation Loc

@synthesize locid, imgname, lcimage, hasImage, imageLoaded, desc, imageAlreadyRequested, roadname, 
            cell, dir, vstr, vmaxstr, Vmax, Vmid, Vmin, Placing, SpCnt, Vmode, Fn, Fx, Mode;

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

- (id) initWithAttributeDict: (NSDictionary *)attributeDict {
  if( self = [super init] ) {
    imageLoaded = NO;
    imageAlreadyRequested = FALSE;
    
    locid    = [Globals getAttribute:@"id" fromDict:attributeDict withDefault:@""]; 
    Vmax     = [Globals getAttribute:@"V_max" fromDict:attributeDict withDefault:@""];
    vmaxstr  = [Globals getAttribute:@"V_max" fromDict:attributeDict withDefault:@""];
    Vmid     = [Globals getAttribute:@"V_mid" fromDict:attributeDict withDefault:@""];
    Vmin     = [Globals getAttribute:@"V_min" fromDict:attributeDict withDefault:@""];
    Vmode    = [Globals getAttribute:@"V_mode" fromDict:attributeDict withDefault:@""];
    Fn       = [Globals getAttribute:@"fn" fromDict:attributeDict withDefault:@""];
    Fx       = [Globals getAttribute:@"fx" fromDict:attributeDict withDefault:@""];
    SpCnt    = [Globals getAttribute:@"spcnt" fromDict:attributeDict withDefault:@""];
    Placing  = [Globals getAttribute:@"placing" fromDict:attributeDict withDefault:@""];
    Mode     = [Globals getAttribute:@"mode" fromDict:attributeDict withDefault:@""];
    imgname  = [Globals getAttribute:@"image" fromDict:attributeDict withDefault:@""];
    desc     = [Globals getAttribute:@"desc" fromDict:attributeDict withDefault:@""];
    roadname = [Globals getAttribute:@"roadname" fromDict:attributeDict withDefault:@""];
    dir      = [Globals getAttribute:@"dir" fromDict:attributeDict withDefault:@""];
    vstr     = [Globals getAttribute:@"V" fromDict:attributeDict withDefault:@"0"];

    hasImage = ![imgname isEqualToString:@""];
    
    fnStates[0] = [Fn isEqualToString:@"true"];
    int iFx = [Fx intValue];
      //NSLog(@"id=%@ fx=%d", locid, iFx);
    for(int i = 1; i < 32; i++) {
      int mask = 1 << (i-1);
        //NSLog(@"mask=%d fx=%d function %d is %@", mask, iFx, i, ( (iFx & mask) == mask ) ?@"ON":@"OFF");
      fnStates[i] = ( (iFx & mask) == mask ) ? TRUE:FALSE; 
    }
    
  }
  return self;
}

- (void) updateWithAttributeDict: (NSDictionary *)attributeDict {
  Vmax     = [Globals getAttribute:@"V_max"    fromDict:attributeDict withDefault:Vmax];
  Vmid     = [Globals getAttribute:@"V_mid"    fromDict:attributeDict withDefault:Vmid];
  Vmin     = [Globals getAttribute:@"V_min"    fromDict:attributeDict withDefault:Vmin];
  Vmode    = [Globals getAttribute:@"V_mode"   fromDict:attributeDict withDefault:Vmode];
  Fn       = [Globals getAttribute:@"fn"       fromDict:attributeDict withDefault:Fn];
  Fx       = [Globals getAttribute:@"fx"       fromDict:attributeDict withDefault:Fx];
  Placing  = [Globals getAttribute:@"placing"  fromDict:attributeDict withDefault:Placing];
  Mode     = [Globals getAttribute:@"mode"     fromDict:attributeDict withDefault:Mode];
  desc     = [Globals getAttribute:@"desc"     fromDict:attributeDict withDefault:desc];
  roadname = [Globals getAttribute:@"roadname" fromDict:attributeDict withDefault:roadname];
  dir      = [Globals getAttribute:@"dir"      fromDict:attributeDict withDefault:dir];
  vstr     = [Globals getAttribute:@"V"        fromDict:attributeDict withDefault:vstr];
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
  
  //NSLog(@"update image in list for loc %@ loaded ...", self.locid);
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
	
	//NSLog(@"SETLOCPICDATA FOR: %@", self.locid);
	
}

- (double) getVpercent {
		return [vstr doubleValue]/[vmaxstr doubleValue];
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
  //BOOL idleMode = [Mode compare:@"idle"] == NSOrderedSame ? TRUE:FALSE;
  return (autoMode);// | idleMode);
}

- (BOOL)isHalfAutoMode {
  return [Mode compare:@"halfauto"] == NSOrderedSame ? TRUE:FALSE;
}

- (void)sendVmax:(int)V {
  Vmax = [[NSString alloc] initWithFormat:@"%d", V];
  NSString * stringToSend = [[NSString alloc] initWithString: 
                             [NSString stringWithFormat: @"<model cmd=\"modify\"><lc id=\"%@\" V_max=\"%d\"/></model>",
                              locid, V]];
  [_delegate sendMessage:@"model" message:stringToSend];
}

- (void)sendVmid:(int)V {
  Vmid = [[NSString alloc] initWithFormat:@"%d", V];
  NSString * stringToSend = [[NSString alloc] initWithString: 
                             [NSString stringWithFormat: @"<model cmd=\"modify\"><lc id=\"%@\" V_mid=\"%d\"/></model>",
                              locid, V]];
  [_delegate sendMessage:@"model" message:stringToSend];
}

- (void)sendVmin:(int)V {
  Vmin = [[NSString alloc] initWithFormat:@"%d", V];
  NSString * stringToSend = [[NSString alloc] initWithString: 
                             [NSString stringWithFormat: @"<model cmd=\"modify\"><lc id=\"%@\" V_min=\"%d\"/></model>",
                              locid, V]];
  [_delegate sendMessage:@"model" message:stringToSend];
}


/*
- (NSString*) locpicdata {
	return locpicdata;
}
 */


@end
