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
  }
  else if( [self.type isEqual:@"buffer"]) {
      // symbol naming fix (see rocrail/impl/pclient.c line 250)
    if( orinr == 1 )
      orinr = 3;
    else if( orinr == 3 )
      orinr = 1;
    imgname = [NSString stringWithFormat: @"buffer-%d.png", orinr];
	}
	else if( [self.type isEqual:@"connector"]) {
		// symbol naming fix (see rocrail/impl/pclient.c line 250)
    if( orinr == 1 )
      orinr = 3;
    else if( orinr == 3 )
      orinr = 1;
    imgname = [NSString stringWithFormat: @"connector-%d.png", orinr];
	}
	else {
		imgname = [NSString stringWithFormat: @"track-%d.png", orinr % 2 == 0 ? 2:1];
	}
	
	return imgname;
}


@end
