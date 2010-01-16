//
//  Block.h
//  iRoc
//
//  Created by Rocrail on 07.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"


@interface Block : Item {
	NSString *ID;
  NSString *locid;
  NSString *reserved;
  NSString *entering;
}

@property (nonatomic, retain) NSString *ID;

- (id) initWithAttributeDict: (NSDictionary *)attributeDict;
- (NSString*) getImgName;
- (void)updateTextColor;

@end
