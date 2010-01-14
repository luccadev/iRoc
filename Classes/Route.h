//
//  Route.h
//  iRoc
//
//  Created by Jean-Michel Fischer on 08.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"


@interface Route : Item {
@private 
	NSString *rtid;
	
}

@property (nonatomic, retain) NSString *rtid;

@end
