//
//  Signal.h
//  iRoc
//
//  Created by Rocrail on 09.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Signal : NSObject {
	NSString *ID;
	NSString *type;
	NSString *state;
}

@property (nonatomic, retain) NSString *ID;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *state;

- (NSString*) getImgName;

@end
