//
//  Item.h
//  iRoc
//
//  Created by Rocrail on 14.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

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
