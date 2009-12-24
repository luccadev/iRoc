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
	theData = [[NSMutableDictionary dictionaryWithCapacity:100] retain];
	NSLog(@"Container Init ...");
	
	return self;
}

- (void)dealloc {
	//[objectList release];
	//[objectIndexList release];
	[theData release];
    [super dealloc];
}

- (void) addObject:(NSObject *)object withId:(NSString *)oid {
	//[objectList addObject:object];
	//[objectIndexList addObject:oid];
	[theData setValue:object forKey:oid];
}

- (NSObject*) objectWithId:(NSString*) oid {
	return [theData objectForKey:oid];
}


- (NSObject*) objectAtIndex:(int) index {
	NSArray *keys = [theData allKeys];
	NSArray *sortedKeys = [keys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
	//NSArray *sortedKeys = [keys sortedArrayUsingSelector:@selector(compare:)];

	id aKey = [sortedKeys objectAtIndex:index];
	return [theData objectForKey:aKey];
}


- (int) count {
	return [theData count];
}

@end
