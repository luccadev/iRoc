/*
 Rocrail - Model Railroad Software
 
 Copyright (C) 2009-2010 - Rob Versluis <r.j.versluis@rocrail.net>
 
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

#import "TtTrack.h"
#import "Globals.h"


@implementation TtTrack
@synthesize nr, show, state, desc;

- (id) initWithAttributeDict: (NSDictionary *)attributeDict {
  if( (self = [super init]) ) {
    NSString *tmp = [Globals getAttribute:@"nr" fromDict:attributeDict withDefault:@"0"]; 
    nr = [tmp intValue];
    [tmp release];
    tmp = [Globals getAttribute:@"state" fromDict:attributeDict withDefault:@"false"]; 
    state = [tmp isEqual:@"true"];
    [tmp release];
    tmp = [Globals getAttribute:@"show" fromDict:attributeDict withDefault:@"true"]; 
    show = [tmp isEqual:@"true"];
    [tmp release];
    desc = [Globals getAttribute:@"desc" fromDict:attributeDict withDefault:@"0"]; 
  }
  
  return self;
}

- (id) initWithNr: (int)_nr {
  if( (self = [super init]) ) {
    nr = _nr;
  }
  
  return self;
}

- (NSString *)getKey {
  return [NSString stringWithFormat:@"%@", desc];
}


@end
