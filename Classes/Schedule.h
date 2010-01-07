//
//  Schedule.h
//  iRoc
//
//  Created by Rocrail on 07.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Schedule : NSObject {
	NSString *ID;
	NSString *state;
}

@property (nonatomic, retain) NSString *ID;
@property (nonatomic, retain) NSString *state;

@end
