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


#import "Sensor.h"
#import "iRocAppDelegate.h"


@implementation Sensor

- (id) initWithAttributeDict: (NSDictionary *)attributeDict {
  if( self = [super initWithAttributeDict:attributeDict] ) {
    NSString *tmp = [Globals getAttribute:@"curve" fromDict:attributeDict withDefault:@"false"];
    curve = [tmp isEqual:@"true"];
    tmp = [Globals getAttribute:@"accnr" fromDict:attributeDict withDefault:@"0"];
    accnr = [tmp intValue];
	}
  return self;
}

- (NSString*) getImgName {
  int orinr = [self getOriNr];
	NSString *imgname = @"";
	NSString *prefix = @"";
  
  if( curve )
    prefix = @"c";
  else
    orinr = (orinr % 2 == 0) ? 2:1;
	
	if( [self.state isEqual:@"true"]) {
    if( accnr > 0 )
      imgname = [NSString stringWithFormat: @"accessory_%d_on_%d.png", accnr, 1];
    else
      imgname = [NSString stringWithFormat: @"%@sensor-on-%d.png", prefix, orinr];
	}
  else {
    if( accnr > 0 )
      imgname = [NSString stringWithFormat: @"accessory_%d_off_%d.png", accnr, 1];
    else
		  imgname = [NSString stringWithFormat: @"%@sensor-off-%d.png", prefix, orinr];
  }
	
	return imgname;
}

- (void)flip {
	NSLog(@"flip fb %@", Id);
	[delegate sendMessage:@"fb" message:[[NSString alloc] initWithString: 
    [NSString stringWithFormat: @"<fb id=\"%@\" state=\"%@\"/>", Id, [state isEqual:@"true"]?@"false":@"true"]]];
}



@end
