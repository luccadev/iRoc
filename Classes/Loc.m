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
    [super dealloc];
}

- (UIImage*) getImage {
	
	if( locpicdata != NULL ){
		
		int i = 0;
		int len = [locpicdata length]; // StrOp.len(s);
		unsigned char* b[len/2 + 1];
		for( i = 0; i < len; i+=2 ) {
			char val[3] = {0};
			val[0] = [locpicdata characterAtIndex:i];  //s[i];
			val[1] = [locpicdata characterAtIndex:i+1];
			val[2] = '\0';
			b[i/2] = (unsigned char*)(strtol( val, NULL, 16)&0xFF);
			
			
		}
		
		for (i = 0; i < 10; i++)
			NSLog(@"%X",([data bytes]) );

		
		NSLog(@" len: %d  ", len);
		
		NSData *data = [NSData dataWithBytes:b length:(len/2 + 1)];
		
		
		//NSLog(@"IMG NOT NULL LOC %d #############", [data length]);
		lcimage = [[UIImage imageWithData:data] retain];
		
		NSLog(@" width: %d height: %d ", [lcimage size].width, [lcimage size].height);
		
		return lcimage; //[UIImage imageNamed:@"signal-g-1.png"];
		
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
