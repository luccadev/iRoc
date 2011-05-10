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


#import "Item.h"
#import "Globals.h"


@implementation Item
@synthesize x, y, z, cx, cy, show, ori, Id, type, state, text, textVertical, textBackgroundColor;


- (id) initWithAttributeDict: (NSDictionary *)attributeDict {
  if( (self = [super init]) ) {
    NSString *tmp = [Globals getAttribute:@"x" fromDict:attributeDict withDefault:@"0"];
    x = [tmp intValue];
    [tmp release];
    tmp = [Globals getAttribute:@"y" fromDict:attributeDict withDefault:@"0"];
    y = [tmp intValue];
    [tmp release];

    tmp = [Globals getAttribute:@"cx" fromDict:attributeDict withDefault:@"1"];
    cx = [tmp intValue];
    [tmp release];
    tmp = [Globals getAttribute:@"cy" fromDict:attributeDict withDefault:@"1"];
    cy = [tmp intValue];
    [tmp release];
    
    tmp = [Globals getAttribute:@"z" fromDict:attributeDict withDefault:@"0"];
    z = [tmp intValue];
    [tmp release];
    tmp = [Globals getAttribute:@"show" fromDict:attributeDict withDefault:@"true"];
    show = [tmp isEqual:@"true"];
    
    ori   = [Globals getAttribute:@"ori"   fromDict:attributeDict withDefault:@"west"]; 
    Id    = [Globals getAttribute:@"id"    fromDict:attributeDict withDefault:@""]; 
    type  = [Globals getAttribute:@"type"  fromDict:attributeDict withDefault:@""]; 
    state = [Globals getAttribute:@"state" fromDict:attributeDict withDefault:@""]; 
    
    text = @"";
    textVertical = FALSE;
    textBackgroundColor = [UIColor clearColor];
    
    if( cx < 1 ) cx = 1;
    if( cy < 1 ) cy = 1;
    
    //NSLog(@"x=%d y=%d z=%d ori=%@", x, y, z, ori);
  }
  return self;
}

- (void) updateWithAttributeDict: (NSDictionary *)attributeDict {
  ori   = [Globals getAttribute:@"ori"   fromDict:attributeDict withDefault:ori]; 
  type  = [Globals getAttribute:@"type"  fromDict:attributeDict withDefault:type]; 
  state = [Globals getAttribute:@"state" fromDict:attributeDict withDefault:state]; 
}

- (int)getOriNr {
  if([ori isEqual:@"north"])
    return 2;
  if([ori isEqual:@"east"])
    return 3;
  if([ori isEqual:@"south"])
    return 4;
  return 1;
}

- (void)setDelegate:(id)_delegate {
  delegate = _delegate;
}

- (void)setView:(id)_myview {
  myview = _myview;
}


- (NSString*) getImgName {
  return @"?";
}

- (void)flip {
    // flip the item
  return;
}

- (void)updateEvent {
    // update the item
  if( myview != nil ) {
    [myview updateEvent];
  }
  return;
}

- (void)paint: (CGRect)rect inContext: (CGContextRef)context {
  
}

@end
