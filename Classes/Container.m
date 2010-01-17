//
//  Container.m
//  iRoc
//
//  Created by Jean-Michel Fischer on 24.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Container.h"


@implementation Container

- (id) init {
	[super init];	
	//objectList = [[NSMutableArray array] retain];
	//objectIndexList = [[NSMutableArray array] retain];
	theData = [[NSMutableDictionary dictionaryWithCapacity:250] retain];
	NSLog(@"Container Init ...");
	
	isSorted = NO;
	
	return self;
}

- (void)dealloc {
	//[objectList release];
	//[objectIndexList release];
	[theData release];
    [super dealloc];
}

- (void) addObject:(id)object withId:(NSString *)oid {
	//[objectList addObject:object];
	//[objectIndexList addObject:oid];
	[theData setValue:object forKey:oid];
	//NSLog(@"Container add %@ ...", oid);
}

- (id) objectWithId:(NSString*) oid {
	return [theData objectForKey:oid];
}


- (id) objectAtIndex:(int) index {
	
	if( !isSorted) {
		NSLog(@"Sorting keys ... ");
		keys = [[theData allKeys] retain];
		sortedKeys = [[keys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] retain];
		isSorted = YES;
	}

	return [theData objectForKey:[sortedKeys objectAtIndex:index]];
}


- (NSEnumerator *)getEnumerator {
  return [theData objectEnumerator];
}


- (int) count {
	return [theData count];
}

@end
