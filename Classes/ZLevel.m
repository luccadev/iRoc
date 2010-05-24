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


#import "ZLevel.h"
#import "Globals.h"


@implementation ZLevel
@synthesize level, title, zlevel, menuname;


- (id) initWithAttributeDict: (NSDictionary *)attributeDict {
  if( self = [super init] ) {
    
    zlevel = [Globals getAttribute:@"z"     fromDict:attributeDict withDefault:@""]; 
    title  = [Globals getAttribute:@"title" fromDict:attributeDict withDefault:@""]; 

    level = [zlevel intValue];
    menuname = [[NSString alloc] initWithFormat:@"%02d - %@", level, title];
    
    NSLog(@"zlevel z=%d title=%@", level, title);
  }
  return self;
}

@end
