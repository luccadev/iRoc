//
//  Loc.m
//  iRoc
//
//  Created by Jean-Michel Fischer on 07.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Loc.h"


@implementation Loc

@synthesize locid, locpicdata, imgname, lcimage;

- (void)dealloc {
    [locid release];
	[locpicdata release];
	[imgname release];
	[lcimage release];
    [super dealloc];
}

- (UIImage*) getImage {
	
	if( locpicdata != NULL ){
		
		//NSData *data0 = [NSData ];
		//unsigned char* b0;
		//b0 = (unsigned char*)[data0 bytes];
		
		int i = 0;
		int len = [locpicdata length]; // StrOp.len(s);
		unsigned char* b[len/2 + 1];
		for( i = 0; i < len; i+=2 ) {
			char val[3] = {0};
			val[0] = [locpicdata characterAtIndex:i];  //s[i];
			val[1] = [locpicdata characterAtIndex:i+1];
			val[2] = '\0';
			b[i/2] = (unsigned char*)(strtol( val, NULL, 16)&0xFF);
			
			//b0[i/2] = (unsigned char*)(strtol( val, NULL, 16)&0xFF);
		}
		
		
		unsigned char* b1;
		unsigned char* b2;
			
	
		
		//NSLog(@" len: %d  ", len);
		//NSLog(@" len/2 + 1: %d  ", len/2 + 1);
		
		NSData *data1 = [NSData dataWithBytesNoCopy:(unsigned char*)b length:(len/2 + 1)];
		NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.polygonpunkt.de/19.png"]];
		
		b1 = (unsigned char*)[data1 bytes];
		b2 = (unsigned char*)[data bytes];
		
		for (i = 0; i <  20; i++) {
			NSLog(@"b: %x b1 : %x  b2: %x", b[i], b1[i], b2[i]);
		}
		
		
		NSLog(@" data: %d  ", data);
		
		/*
		UIImage* pic = [UIImage imageNamed:@"sample.png"];
		NSData* pictureData = UIImagePNGRepresentation(pic);
		NSString* pictureDataString = [pictureData base64Encoding];
		*/
		
		lcimage = [[UIImage alloc] initWithData:data];

		
		
		/*
		//NSLog(@"IMG NOT NULL LOC %d #############", [data length]);
		lcimage = [UIImage imageNamed:@"signal-g-1.png"]; 
		NSLog(@" lcimage1a: %d  ", lcimage);
		lcimage = [[UIImage imageWithData:data] retain];
		NSLog(@" lcimage1b: %d  ", lcimage);
		
		NSLog(@"(Loc) width: %d height: %d ", [lcimage size].width, [lcimage size].height);
		*/
		
		
		NSLog(@" lcimage1: %d  ", lcimage);
		
		
		return lcimage; //
		
	} else {
		NSLog(@"IMG NULL LOC");
		return NULL;
	}
}

/*
static unsigned char* _strToByte( const char* s ) {
	int i = 0;
	int len = StrOp.len(s);
	unsigned char* b = allocMem( len/2 + 1);
	for( i = 0; i < len; i+=2 ) {
		char val[3] = {0};
		val[0] = s[i];
		val[1] = s[i+1];
		val[2] = '\0';
		b[i/2] = (unsigned char)(strtol( val, NULL, 16)&0xFF);
	}
	return b;
}
 */

@end
