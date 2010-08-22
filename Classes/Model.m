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


#import "Model.h"


@implementation Model
@synthesize levelContainer, swContainer, sgContainer, tkContainer, fbContainer, bkContainer, coContainer, txContainer, rtContainer, scContainer, lcContainer;
@synthesize title, name, rocrailversion, rocguiversion, donkey;

- (id) init {
  if( self = [super init] ) {
    levelContainer = [[[Container alloc] init] retain];
    swContainer    = [[[Container alloc] init] retain];
    sgContainer    = [[[Container alloc] init] retain];
    tkContainer    = [[[Container alloc] init] retain];
    fbContainer    = [[[Container alloc] init] retain];
    bkContainer    = [[[Container alloc] init] retain];
    coContainer    = [[[Container alloc] init] retain];
    txContainer    = [[[Container alloc] init] retain];
    rtContainer    = [[[Container alloc] init] retain];
    lcContainer    = [[[Container alloc] init] retain];
    scContainer    = [[[Container alloc] init] retain];
  }
  return self;
}

- (void) setupWithAttributeDict: (NSDictionary *)attributeDict {
  title          = [Globals getAttribute:@"title"          fromDict:attributeDict withDefault:@""]; 
  name           = [Globals getAttribute:@"name"           fromDict:attributeDict withDefault:@""]; 
  rocrailversion = [Globals getAttribute:@"rocrailversion" fromDict:attributeDict withDefault:@""]; 
  rocguiversion  = [Globals getAttribute:@"rocguiversion"  fromDict:attributeDict withDefault:@""]; 
	donkey  = [Globals getAttribute:@"donkey"         fromDict:attributeDict withDefault:@""]; 
  NSLog(@"plan title is %@", title);
	NSLog(@"donkey is %@", donkey);
}



@end
