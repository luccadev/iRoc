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


#import "Output.h"
#import "iRocAppDelegate.h"


@implementation Output
@synthesize coid;

- (id) initWithAttributeDict: (NSDictionary *)attributeDict {
  if( self = [super initWithAttributeDict:attributeDict] ) {
  }
  return self;
}

- (void)dealloc {
    [coid release];
    [super dealloc];
}

- (NSString*) getImgName {
	NSString *imgname = @"button-on.png";
	
	if( [self.state isEqual:@"on"])
		imgname = @"button-on.png";
	else if( [self.state isEqual:@"active"])
		imgname = @"button-active.png";
	else 
		imgname = @"button-off.png";
		
	return imgname;
}

- (void)flip {
	NSLog(@"flip co %@", Id);
	[delegate sendMessage:@"co" message:[[NSString alloc] initWithString: 
                                       [NSString stringWithFormat: @"<co id=\"%@\" cmd=\"flip\"/>", Id]]];
}

- (void)updateEvent {
	NSLog(@"update event co %@", Id);
  if( myview != nil )
    [myview updateEvent];
}


@end
