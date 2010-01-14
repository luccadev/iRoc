//
//  ZLevel.h
//  iRoc
//
//  Created by Rocrail on 14.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZLevel : NSObject {
  int level;
  NSString *zlevel;
  NSString *title;
  NSString *menuname;
}
@property (nonatomic, retain) NSString *title, *zlevel, *menuname;
@property int level;

- (id) initWithAttributeDict: (NSDictionary *)attributeDict;

@end
