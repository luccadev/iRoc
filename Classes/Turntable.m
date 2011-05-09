//
//  Turntable.m
//  iRoc
//
//  Created by Jean-Michel Fischer on 09.05.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Turntable.h"


@implementation Turntable
@synthesize ID;

- (id) initWithAttributeDict: (NSDictionary *)attributeDict {
    if( (self = [super initWithAttributeDict:attributeDict]) ) {
        
        
    }
    
    
    NSLog(@" TT ------>  %@", self.ID);
    
    return self;
}

- (void) updateWithAttributeDict: (NSDictionary *)attributeDict {
    [super updateWithAttributeDict:attributeDict]; 
}


- (NSString*) getImgName {
	NSString *imgname = @"";
    
        cx = 2;
        cy = 2;
        imgname = @"button-active.png"; // TODO: correct symbol!
   	
	return imgname;
}

- (void)flip {
	NSLog(@"Turntable Flip");
	[delegate presentTurntableView:self];
}


@end
