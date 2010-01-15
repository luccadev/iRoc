//
//  Switch.h
//  iRoc
//
//  Created by Jean-Michel Fischer on 09.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"


@interface Switch : Item {
	NSString *swid;
 }

@property (nonatomic, retain) NSString *swid;

- (id) initWithAttributeDict: (NSDictionary *)attributeDict;
- (NSString*) getImgName;

@end
