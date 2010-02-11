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
	NSString *smallsymbol;
}

@property (nonatomic, retain) NSString *ID;
@property (nonatomic, retain) NSString *smallsymbol;

- (id) initWithAttributeDict: (NSDictionary *)attributeDict;
- (NSString*) getImgName;
- (void)updateTextColor;



- (void)sendOpen;
- (void)sendClose;
- (void)setLoco: (NSString *)ID;
- (void)resetLoco;

@end

@interface NSObject (Block)

- (void)presentBlockView:(Block*)block;

@end
