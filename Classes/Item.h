//
//  Item.h
//  iRoc
//
//  Created by Rocrail on 14.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Item : NSObject {
  int z;
  int x;
  int y;
}
@property int x, y, z;

- (NSString*) getImgName;

@end
