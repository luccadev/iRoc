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
  BOOL show;
  NSString *ori;
  NSString *Id;
  id delegate;
  id myview;
}
@property int x, y, z;
@property BOOL show;
@property (nonatomic, retain) NSString *ori, *Id;

- (id) initWithAttributeDict: (NSDictionary *)attributeDict;
- (void)setDelegate:(id)_delegate;
- (void)setView:(id)_myview;
- (NSString*) getImgName;
- (void)flip;
- (void)updateEvent;

@end
