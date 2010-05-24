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


#import "Signal.h"
#import "iRocAppDelegate.h"


@implementation Signal

@synthesize ID;

- (id) initWithAttributeDict: (NSDictionary *)attributeDict {
  if( self = [super initWithAttributeDict:attributeDict] ) {
  }
  return self;
}


- (NSString*) getImgName {
  int orinr = [self getOriNr];

    // symbol naming fix (see rocrail/impl/pclient.c line 250)
  if( orinr == 1 )
    orinr = 3;
  else if( orinr == 3 )
    orinr = 1;
  
	NSString *imgname = @"";
	
  if( [self.state isEqual:@"red"])
		imgname = [NSString stringWithFormat:@"signal-r-%d.png", orinr];
  else if( [self.state isEqual:@"green"])
		imgname = [NSString stringWithFormat:@"signal-g-%d.png", orinr];
  else if( [self.state isEqual:@"yellow"])
		imgname = [NSString stringWithFormat:@"signal-y-%d.png", orinr];
	else 
		imgname = [NSString stringWithFormat:@"signal-w-%d.png", orinr];
  
	return imgname;
}

- (void)flip {
	NSLog(@"flip sg %@", Id);
	[delegate sendMessage:@"sg" message:[[NSString alloc] initWithString: 
      [NSString stringWithFormat: @"<sg id=\"%@\" cmd=\"flip\"/>", Id]]];
}

- (void)updateEvent {
	NSLog(@"update event sg %@", Id);
  if( myview != nil )
    [myview updateEvent];
}




- (void)dealloc {
  [super dealloc];
}

@end
