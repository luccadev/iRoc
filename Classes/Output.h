//
//  Output.h
//  iRoc
//
//  Created by Jean-Michel Fischer on 09.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"


@interface Output : Item {
	NSString *coid;
}

@property (nonatomic, retain) NSString *coid;

- (NSString*) getImgName;

@end
