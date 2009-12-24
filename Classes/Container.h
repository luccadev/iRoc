//
//  Container.h
//  iRoc
//
//  Created by Jean-Michel Fischer on 24.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Container : NSObject {
	NSMutableArray *objectList;
	NSMutableArray *objectIndexList;
}

- (void) addObject:(NSObject*)object withId:(NSString*)oid;

- (NSObject*) objectWithId:(NSString*) oid;
- (NSObject*) objectAtIndex:(int) index;
- (int) count;

@end
