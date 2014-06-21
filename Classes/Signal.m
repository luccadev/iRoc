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
    NSString *tmp = [Globals getAttribute:@"aspects" fromDict:attributeDict withDefault:@"3"];
    Aspects = [tmp intValue];
    SignalType = [Globals getAttribute:@"signal" fromDict:attributeDict withDefault:@"main"];
    Distant = [SignalType isEqual:@"distant"];
    Shunting = [SignalType isEqual:@"shunting"];
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

  NSString *statetype = @"";
	NSString *imgname = @"";
  
  if( Distant) {
    if( [self.state isEqual:@"red"])
	  	imgname = [NSString stringWithFormat:@"signaldistant_r_%@%d.png", statetype, orinr];
    else if( [self.state isEqual:@"green"])
		  imgname = [NSString stringWithFormat:@"signaldistant_g_%@%d.png", statetype, orinr];
    else if( [self.state isEqual:@"yellow"])
		  imgname = [NSString stringWithFormat:@"signaldistant_y_%@%d.png", statetype, orinr];
	  else
		  imgname = [NSString stringWithFormat:@"signaldistant_w_%@%d.png", statetype, orinr];
  }
  else if( Shunting) {
    if( [self.state isEqual:@"red"])
	  	imgname = [NSString stringWithFormat:@"signalshunting_r_%@%d.png", statetype, orinr];
	  else
		  imgname = [NSString stringWithFormat:@"signalshunting_w_%@%d.png", statetype, orinr];
  }
  else {
    if( [self.state isEqual:@"red"])
	  	imgname = [NSString stringWithFormat:@"signal%d_r_%@%d.png", Aspects, statetype, orinr];
    else if( [self.state isEqual:@"green"])
		  imgname = [NSString stringWithFormat:@"signal%d_g_%@%d.png", Aspects, statetype, orinr];
    else if( [self.state isEqual:@"yellow"])
		  imgname = [NSString stringWithFormat:@"signal%d_y_%@%d.png", Aspects, statetype, orinr];
	  else
		  imgname = [NSString stringWithFormat:@"signal%d_w_%@%d.png", Aspects, statetype, orinr];
  }
  
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
