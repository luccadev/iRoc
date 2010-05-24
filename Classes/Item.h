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


#import <Foundation/Foundation.h>
#import "Globals.h"

@interface Item : NSObject {
  int z;
  int x;
  int y;
  int cx;
  int cy;
  BOOL show;
  NSString *ori;
  NSString *Id;
  NSString *type;
  NSString *state;
  NSString *text;
  BOOL textVertical;
  id delegate;
  id myview;
  UIColor *textBackgroundColor;
}
@property int x, y, z, cx, cy;
@property BOOL show, textVertical;
@property (nonatomic, retain) NSString *ori, *Id, *type, *state, *text;
@property (nonatomic, retain) UIColor *textBackgroundColor;

- (id) initWithAttributeDict: (NSDictionary *)attributeDict;
- (void) updateWithAttributeDict: (NSDictionary *)attributeDict;
- (void)setDelegate:(id)_delegate;
- (void)setView:(id)_myview;
- (NSString*) getImgName;
- (void)flip;
- (void)updateEvent;
- (int)getOriNr;

@end
