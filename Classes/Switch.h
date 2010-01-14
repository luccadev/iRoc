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
	NSString *type;
	NSString *state;
 }

@property (nonatomic, retain) NSString *swid;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *state;

- (NSString*) getImgName;

@end
