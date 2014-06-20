/*
 Rocrail - Model Railroad Software
 
 Copyright (C) 2009-2010 - Rob Versluis <r.j.versluis@rocrail.net>, Jean-Michel Fischer <jmf@polygonpunkt.de>
 
 This program is free software; you can redistribute it and/or
 modify it under the terms of the GNU General Public License
 as published by the Free Software Foundation; either version 2
 of the License, or (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 */


#import "Container.h"


@implementation Container

- (id) init {
	[super init];	
	//objectList = [[NSMutableArray array] retain];
	//objectIndexList = [[NSMutableArray array] retain];
	theData = [[NSMutableDictionary dictionaryWithCapacity:250] retain];
	//NSLog(@"Container Init ...");
	
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
	NSLog(@"Container added %@ count=%d", oid, [theData count]);
  isSorted = NO;
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
	return (int)[theData count];
}

@end
