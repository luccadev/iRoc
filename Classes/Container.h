//
//  Container.h
//  iRoc
//
//  Created by Jean-Michel Fischer on 24.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Container : NSObject {
	//NSMutableArray *objectList;
	//NSMutableArray *objectIndexList;
	NSMutableDictionary *theData;
	
	NSArray *keys;
	NSArray *sortedKeys;
	
	BOOL isSorted;
}

- (void) addObject:(id)object withId:(NSString*)oid;

- (id) objectWithId:(NSString*) oid;
- (id) objectAtIndex:(int) index;
- (int) count;
- (NSEnumerator *)getEnumerator;

@end
