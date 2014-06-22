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


#import "Text.h"
#import "iRocAppDelegate.h"


@implementation Text

- (id) initWithAttributeDict: (NSDictionary *)attributeDict {
  if( self = [super initWithAttributeDict:attributeDict] ) {
    text = [Globals getAttribute:@"text" fromDict:attributeDict withDefault:@""]; 
    origCx = cx;
    origCy = cy;
  }
  return self;
}

- (NSString*) getImgName {
  int orinr = [self getOriNr];
  if (orinr % 2 == 0) {
    textVertical = true;
    cx = origCy;
    cy = origCx;
  }
  else {
    textVertical = false;
    cx = origCx;
    cy = origCy;
  }
  if( !imageAlreadyRequested && [text hasSuffix:@".png"] ) {
    imgname = [[NSString alloc] initWithString:text];
    NSString * stringToSend = [NSString stringWithFormat: @"<datareq id=\"%@\" filename=\"%@\"/>",Id, imgname];
    [delegate sendMessage:@"datareq" message:stringToSend];
    hasImage = true;
    imageAlreadyRequested = true;
    text = @"";
  }
  else if( [text length] == 0 ) {
    // Remove previous image.
  }
	return nil;
}


- (Boolean) hasImage {
  NSLog(@"text=%@ hasImage=%@ imagename=%@", Id, hasImage?@"YES":@"NO", imgname);
  return true; // could get later an image name
}


- (void)updateTextColor {
  if( [text length] > 0 ) {
    NSLog(@"text=%@ state=%@ red=%d green=%d blue=%d", Id, text, red, green, blue);
    float fred   = (float)red / 255.0;
    float fgreen = (float)green / 255.0;
    float fblue  = (float)blue / 255.0;
    textForgroundColor = [[UIColor colorWithRed:fred green:fgreen blue:fblue alpha:1] retain];
    
    if( backred != -1 && backgreen != -1 && backblue != -1 ) {
      fred   = (float)backred / 255.0;
      fgreen = (float)backgreen / 255.0;
      fblue  = (float)backblue / 255.0;
      textBackgroundColor = [[UIColor colorWithRed:fred green:fgreen blue:fblue alpha:1] retain];
    }
    else {
      textBackgroundColor = [UIColor clearColor];
    }
  }
}

- (void) updateWithAttributeDict: (NSDictionary *)attributeDict {
  [super updateWithAttributeDict:attributeDict];
  NSString* l_text = [Globals getAttribute:@"text" fromDict:attributeDict withDefault:text];
  NSLog(@"update text: %@ new=[%@] old=[%@]", Id, l_text, text);
  hasImage = false;
  imageLoaded = false;
  imageAlreadyRequested = false;
  text = l_text;
  NSLog(@"new text: %@ [%@]", Id, text);
  [self updateTextColor];
}

- (void) setPicdata:(NSString *) picdata {
	txpicdata = picdata;
	[self prepareImage];
}

- (void) prepareImage {
	int i = 0;
	int len = [txpicdata length]; // StrOp.len(s);
  NSLog(@"prepare image data text: %@ %@ %d", Id, imgname, len);
	unsigned char b[len/2 + 1];
	for( i = 0; i < len; i+=2 ) {
		char val[3] = {0};
		val[0] = [txpicdata characterAtIndex:i];  //s[i];
		val[1] = [txpicdata characterAtIndex:i+1];
		val[2] = '\0';
		b[i/2] = (unsigned char)(strtol( val, NULL, 16)&0xFF);
	}
	
	NSData *data = [NSData dataWithBytes:(unsigned char*)b length:(len/2 + 1)];
	
	textimage = [[[UIImage alloc] initWithData:data] retain];
	
	imageLoaded = YES;
  
}


- (UIImage*) getImage: (BOOL)_modPlan {
	if( hasImage && imageLoaded ){
		NSLog(@"get image for text: %@ %@", Id, imgname);
    int orinr = [self getOriNr];
    
    if (orinr % 2 == 0) {
      textVertical = true;
      cx = origCy;
      cy = origCx;
    }
    else {
      textVertical = false;
      cx = origCx;
      cy = origCy;
    }
    
    if( orinr == 2 )
      return [[UIImage alloc] initWithCGImage: textimage.CGImage scale: 1.0 orientation: UIImageOrientationRight];
    if( orinr == 4 )
      return [[UIImage alloc] initWithCGImage: textimage.CGImage scale: 1.0 orientation: UIImageOrientationLeft];
		return textimage;
	}
  else {
		return nil;
	}
}



@end
