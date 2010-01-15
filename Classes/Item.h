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
}
@property int x, y, z;
@property BOOL show;
@property (nonatomic, retain) NSString* ori;

- (id) initWithAttributeDict: (NSDictionary *)attributeDict;
- (NSString*) getImgName;

@end
