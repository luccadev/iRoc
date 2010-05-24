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
