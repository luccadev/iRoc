/*
 Rocrail - Model Railroad Software
 
 Copyright (C) 2009-2010 - Rob Versluis <r.j.versluis@rocrail.net>, Jean-Michel Fischer <jmf@polygonpunkt.de>
 
 This program is free software; you can redistribute it and/or
 modify it under the terms of the GNU General Public License
 as published by the Free Software Foundation; either version 2
 of the License, or (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 */


#import "Loc.h"
#import "iRocAppDelegate.h"
#import "Globals.h"


@implementation Loc

@synthesize locid, imgname, lcimage, hasImage, imageLoaded, desc, imageAlreadyRequested, roadname, 
            cell, dir, vstr, vmaxstr, Vmax, Vmid, Vmin, Placing, SpCnt, Vmode, Fn, Fx, Mode, addr, 
						f0, f1, f2, f3, f4 ,f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, vint, consist;

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
		Commuter = [Globals getAttribute:@"commuter" fromDict:attributeDict withDefault:@""];
    Mode     = [Globals getAttribute:@"mode" fromDict:attributeDict withDefault:@""];
    imgname  = [Globals getAttribute:@"image" fromDict:attributeDict withDefault:@""];
    desc     = [Globals getAttribute:@"desc" fromDict:attributeDict withDefault:@""];
    roadname = [Globals getAttribute:@"roadname" fromDict:attributeDict withDefault:@""];
    dir      = [Globals getAttribute:@"dir" fromDict:attributeDict withDefault:@""];
    vstr     = [Globals getAttribute:@"V" fromDict:attributeDict withDefault:@"0"];
		addr     = [Globals getAttribute:@"addr" fromDict:attributeDict withDefault:@"0"];
		consist  = [Globals getAttribute:@"consist" fromDict:attributeDict withDefault:@""];
		
		vint = [vstr intValue];

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
	
	cellbackcolor = [UIColor darkGrayColor];
	celltextcolor = [UIColor lightGrayColor]; //[[UIColor colorWithRed:.16 green:.20 blue:.27 alpha:1] retain];
	cellfontsize = 18;
	celltextRect = CGRectMake(10, 10, 190, 25);
	
	cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] retain];
	[self createCell];
	
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
	Commuter = [Globals getAttribute:@"commuter" fromDict:attributeDict withDefault:Commuter];
  Mode     = [Globals getAttribute:@"mode"     fromDict:attributeDict withDefault:Mode];
  desc     = [Globals getAttribute:@"desc"     fromDict:attributeDict withDefault:desc];
  roadname = [Globals getAttribute:@"roadname" fromDict:attributeDict withDefault:roadname];
  dir      = [Globals getAttribute:@"dir"      fromDict:attributeDict withDefault:dir];
  vstr     = [Globals getAttribute:@"V"        fromDict:attributeDict withDefault:vstr];
	addr     = [Globals getAttribute:@"addr"     fromDict:attributeDict withDefault:addr];
	consist  = [Globals getAttribute:@"consist"  fromDict:attributeDict withDefault:consist];
	
	vint = [vstr intValue];
	
	f0 = [Globals getAttribute:@"f0" fromDict:attributeDict withDefault:f0];
	if( [@"true" isEqualToString:f0] || [@"false" isEqualToString:f0])
		fnStates[0] = [@"true" isEqualToString:f0] ? TRUE:FALSE;
	
	f1 = [Globals getAttribute:@"f1" fromDict:attributeDict withDefault:f1];
	if( [@"true" isEqualToString:f1] || [@"false" isEqualToString:f1])
		fnStates[1] = [@"true" isEqualToString:f1] ? TRUE:FALSE;
	
	f2 = [Globals getAttribute:@"f2" fromDict:attributeDict withDefault:f2];
	if( [@"true" isEqualToString:f2] || [@"false" isEqualToString:f2])
		fnStates[2] = [@"true" isEqualToString:f2] ? TRUE:FALSE;
	
	f3 = [Globals getAttribute:@"f3" fromDict:attributeDict withDefault:f3];
	if( [@"true" isEqualToString:f3] || [@"false" isEqualToString:f3])
		fnStates[3] = [@"true" isEqualToString:f3] ? TRUE:FALSE;
	
	f4 = [Globals getAttribute:@"f4" fromDict:attributeDict withDefault:f4];
	if( [@"true" isEqualToString:f4] || [@"false" isEqualToString:f4])
		fnStates[4] = [@"true" isEqualToString:f4] ? TRUE:FALSE;
	
	f5 = [Globals getAttribute:@"f5" fromDict:attributeDict withDefault:f5];
	if( [@"true" isEqualToString:f5] || [@"false" isEqualToString:f5])
		fnStates[5] = [@"true" isEqualToString:f5] ? TRUE:FALSE;
	
	f6 = [Globals getAttribute:@"f6" fromDict:attributeDict withDefault:f6];
	if( [@"true" isEqualToString:f6] || [@"false" isEqualToString:f6])
		fnStates[6] = [@"true" isEqualToString:f6] ? TRUE:FALSE;
	
	f7 = [Globals getAttribute:@"f7" fromDict:attributeDict withDefault:f7];
	if( [@"true" isEqualToString:f7] || [@"false" isEqualToString:f7])
		fnStates[7] = [@"true" isEqualToString:f7] ? TRUE:FALSE;
	
	f8 = [Globals getAttribute:@"f8" fromDict:attributeDict withDefault:f8];
	if( [@"true" isEqualToString:f8] || [@"false" isEqualToString:f8])
		fnStates[8] = [@"true" isEqualToString:f8] ? TRUE:FALSE;
	
	f9 = [Globals getAttribute:@"f9" fromDict:attributeDict withDefault:f9];
	if( [@"true" isEqualToString:f9] || [@"false" isEqualToString:f9])
		fnStates[9] = [@"true" isEqualToString:f9] ? TRUE:FALSE;
	
	f10 = [Globals getAttribute:@"f10" fromDict:attributeDict withDefault:f10];
	if( [@"true" isEqualToString:f10] || [@"false" isEqualToString:f10])
		fnStates[10] = [@"true" isEqualToString:f10] ? TRUE:FALSE;
	
	f11 = [Globals getAttribute:@"f11" fromDict:attributeDict withDefault:f11];
	if( [@"true" isEqualToString:f11] || [@"false" isEqualToString:f11])
		fnStates[11] = [@"true" isEqualToString:f11] ? TRUE:FALSE;
	
	f12 = [Globals getAttribute:@"f12" fromDict:attributeDict withDefault:f12];
	if( [@"true" isEqualToString:f12] || [@"false" isEqualToString:f12])
		fnStates[12] = [@"true" isEqualToString:f12] ? TRUE:FALSE;
	
	f13 = [Globals getAttribute:@"f13" fromDict:attributeDict withDefault:f13];
	if( [@"true" isEqualToString:f13] || [@"false" isEqualToString:f13])
		fnStates[13] = [@"true" isEqualToString:f13] ? TRUE:FALSE;
	
	f14 = [Globals getAttribute:@"f14" fromDict:attributeDict withDefault:f14];
	if( [@"true" isEqualToString:f14] || [@"false" isEqualToString:f14])
		fnStates[14] = [@"true" isEqualToString:f14] ? TRUE:FALSE;
	
	f15 = [Globals getAttribute:@"f15" fromDict:attributeDict withDefault:f15];
	if( [@"true" isEqualToString:f15] || [@"false" isEqualToString:f15])
		fnStates[15] = [@"true" isEqualToString:f15] ? TRUE:FALSE;
	
	f16 = [Globals getAttribute:@"f16" fromDict:attributeDict withDefault:f16];
	if( [@"true" isEqualToString:f16] || [@"false" isEqualToString:f16])
		fnStates[16] = [@"true" isEqualToString:f16] ? TRUE:FALSE;
		
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
	int len = (int)[locpicdata length]; // StrOp.len(s);
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
  
  
	NSLog(@"image for loc %@ prepared ...", self.locid);
	[self addCellLocoImage];
		
	
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

- (UITableViewCell*) getCell {
	return self.cell;	
} 

- (void) createCell {
	
	NSLog(@"creating cell for loco %@...", self.locid);
	
	
	cell.selectionStyle = UITableViewCellSelectionStyleGray;
	
	UILabel *locidLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, 8, 100, 20)] autorelease];
	locidLabel.font = [UIFont boldSystemFontOfSize:cellfontsize];
	locidLabel.textColor = celltextcolor;
	locidLabel.backgroundColor = [UIColor clearColor];
	
	UILabel *descLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, 29, 100, 20)] autorelease];
	descLabel.font = [UIFont boldSystemFontOfSize:12];
	descLabel.textColor = celltextcolor;
	descLabel.backgroundColor = [UIColor clearColor];
	
	UILabel *routeLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, 44, 100, 20)] autorelease];
	routeLabel.font = [UIFont boldSystemFontOfSize:12];
	routeLabel.textColor = celltextcolor;
	routeLabel.backgroundColor = [UIColor clearColor];
	
	[cell.contentView addSubview:descLabel];
	[cell.contentView addSubview:routeLabel];
	[cell.contentView addSubview:locidLabel];
	
	//if ( [[loc consist] isEqualToString:@""] ) {
	locidLabel.text = [self locid];
	//} else {
	//	locidLabel.text = [NSString stringWithFormat:@"%@ + [%@]", loc.locid, loc.consist];
	//}
	
	
	routeLabel.text = self.roadname;
	descLabel.text = self.desc;
	//loc.cell = cell;
	
	//NSLog(@"calling addCellLocoImage for loco %@...", self.locid);
	//[self addCellLocoImage];
	 
}

- (void)addCellLocoImage {
  if( [self imageLoaded] && [self hasImage] && self.cell != nil) {
    NSLog(@"addCellLocoImage for loco %@...", self.locid);
    UIImage *img = [self getImage];
    //UITableViewCell *cell = loc.cell;
    
    int breite = 50*(img.size.width/img.size.height);
    
    int diff = 150 - breite;
    
    CGRect imageframe = CGRectMake(160 + diff,10,breite,50);	
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:imageframe];
    imageview.image = [self getImage];
				
    [self.cell.contentView addSubview:imageview];
    [self.cell.contentView bringSubviewToFront:imageview];
    [imageview release];
  } else if( [self hasImage] && ![self imageAlreadyRequested]){
    self.imageAlreadyRequested=TRUE;
    //[_delegate askForLocpic:loc.locid withFilename:loc.imgname];
  }	
}
 
- (void) setLocpicdata:(NSString *) picdata {	
	locpicdata = picdata;
	[self prepareImage];
}

- (double) getVpercent {
		return vint/[vmaxstr doubleValue];
}

- (void) setVpercent:(double) vpercent {
	
	vint = (int)(vpercent*[vmaxstr doubleValue]);
	
	NSLog(@" setVpercent: %d ", vint );
	
	//[vstr release];
	//vstr = [[NSString stringWithFormat:@"%d", vtmp] retain];

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

- (BOOL)isCommuter {
  return [Commuter compare:@"true"] == NSOrderedSame ? TRUE:FALSE;
}

- (BOOL)isAutoMode {
  BOOL autoMode = [Mode compare:@"auto"] == NSOrderedSame ? TRUE:FALSE;
  //BOOL idleMode = [Mode compare:@"idle"] == NSOrderedSame ? TRUE:FALSE;
  return (autoMode);// | idleMode);
}

- (BOOL)isHalfAutoMode {
  return [Mode compare:@"halfauto"] == NSOrderedSame ? TRUE:FALSE;
}

- (void) sendVcommand {
	NSString * stringToSend = [NSString stringWithFormat: @"<lc throttleid=\"%@\" id=\"%@\" V=\"%d\" dir=\"%@\" fn=\"%@\"/>", 
									(NSString*)[[UIDevice currentDevice] name],
									self.locid, self.vint, self.dir, fnStates[0]?@"true":@"false"];
																					 
	[_delegate sendMessage:@"lc" message:stringToSend];
}

- (void)sendFunctionCommand:(int)fnIndex {
	int tmp = (fnIndex-1)/4 +1;
	NSString * stringToSend = [NSString stringWithFormat: @"<fn fnchanged=\"%d\" group=\"%d\" id=\"%@\" f%d=\"%@\" fnchangedstate=\"%@\"/>",
														 fnIndex, tmp, self.locid, fnIndex, fnStates[fnIndex]?@"true":@"false", fnStates[fnIndex]?@"true":@"false"];
	
	[_delegate sendMessage:@"fn" message:stringToSend];
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
