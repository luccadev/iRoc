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
	objectList = [[NSMutableArray array] retain];
	objectIndexList = [[NSMutableArray array] retain];
	NSLog(@"Container Init ...");
	return self;
}

- (void)dealloc {
	[objectList release];
	[objectIndexList release];
    [super dealloc];
}

- (void) addObject:(NSObject *)object withId:(NSString *)oid {
	[objectList addObject:object];
	[objectIndexList addObject:oid];
}

- (NSObject*) objectWithId:(NSString*) oid {
	if( [objectIndexList indexOfObject:oid] <= [objectList count] && [objectIndexList indexOfObject:oid] < -1)
		return [objectList objectAtIndex:[objectIndexList indexOfObject:oid]];
	else
		return NULL;
}

- (NSObject*) objectAtIndex:(int) index {
	return [objectList objectAtIndex:index];
}

- (int) count {
	return [objectList count];
}

@end
