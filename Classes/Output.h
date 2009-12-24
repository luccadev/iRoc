//
//  Output.h
//  iRoc
//
//  Created by Jean-Michel Fischer on 09.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Output : NSObject {
	NSString *coid;
	NSString *state;
}

@property (nonatomic, retain) NSString *coid;
@property (nonatomic, retain) NSString *state;

- (NSString*) getImgName;

@end
