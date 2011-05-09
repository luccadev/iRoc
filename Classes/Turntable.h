//
//  Turntable.h
//  iRoc
//
//  Created by Jean-Michel Fischer on 09.05.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"

@interface Turntable : Item {
    NSString *ID;
}

@property (nonatomic, retain) NSString *ID;

- (id) initWithAttributeDict: (NSDictionary *)attributeDict;
- (NSString*) getImgName;

@end

@interface NSObject (Turntable)

- (void)presentTurntableView:(Turntable*)tt;

@end