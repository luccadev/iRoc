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


#import "Switch.h"
#import "iRocAppDelegate.h"


@implementation Switch
@synthesize swid;

- (id) initWithAttributeDict: (NSDictionary *)attributeDict {
  if( self = [super initWithAttributeDict:attributeDict] ) {
    dir = [Globals getAttribute:@"dir" fromDict:attributeDict withDefault:@"false"]; 
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
	
	if( [self.type isEqual:@"right"]) {
		if( [self.state isEqual:@"straight"])
			imgname = [NSString stringWithFormat:@"turnout-rs-%d.png", orinr];
		else 
			imgname = [NSString stringWithFormat:@"turnout-rt-%d.png", orinr];
		
	} else if( [self.type isEqual:@"left"]) {
			if( [self.state isEqual:@"straight"])
				imgname = [NSString stringWithFormat:@"turnout-ls-%d.png", orinr];
			else 
				imgname = [NSString stringWithFormat:@"turnout-lt-%d.png", orinr];
	
	} else if( [self.type isEqual:@"threeway"]) {
    if( [self.state isEqual:@"straight"])
      imgname = [NSString stringWithFormat:@"threeway-s-%d.png", orinr];
    else if( [self.state isEqual:@"left"])
      imgname = [NSString stringWithFormat:@"threeway-l-%d.png", orinr];
    else 
      imgname = [NSString stringWithFormat:@"threeway-r-%d.png", orinr];
    
	} else if( [self.type isEqual:@"dcrossing"] ){
    //BOOL st = [state isEqual:@"straight"];
    BOOL dr = [dir isEqual:@"true"];
		char st = 's';
		
		if( [state isEqual:@"straight"])
			st = 's';
		else if( [state isEqual:@"turnout"])
			st = 't';
		else if( [state isEqual:@"left"])
			st = 'l';
		else if( [state isEqual:@"right"])
			st = 'r';
		
		imgname = [NSString stringWithFormat:@"dcrossing%@-%c-%d.png", dr?@"left":@"right", st, orinr];
		
    cx = orinr % 2 == 0 ? 1:2; 
    cy = orinr % 2 == 0 ? 2:1; 
	} else if( [self.type isEqual:@"crossing"] ) {
		imgname = @"cross.png";
	} else if( [self.type isEqual:@"ccrossing"] ) {
		imgname = [NSString stringWithFormat: @"ccrossing-%d.png", orinr % 2 == 0 ? 2:1];
		cx = orinr % 2 == 0 ? 1:2; 
    cy = orinr % 2 == 0 ? 2:1; 
	} else if( [self.type isEqual:@"decoupler"] ) {
		imgname = [NSString stringWithFormat: @"decoupler-%d.png", orinr % 2 == 0 ? 2:1];
	}
	
	return imgname;
}

- (void)flip {
	NSLog(@"flip sw %@", Id);
	[delegate sendMessage:@"sw" message:[[NSString alloc] initWithString: [NSString stringWithFormat: @"<sw id=\"%@\" cmd=\"flip\"/>", swid]]];
}

- (void)updateEvent {
	NSLog(@"update event sw %@", Id);
  if( myview != nil )
    [myview updateEvent];
}

- (void)dealloc {
    [swid release];
	[type release];
    [super dealloc];
}
@end
