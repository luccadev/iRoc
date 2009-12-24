//
//  Switch.h
//  iRoc
//
//  Created by Jean-Michel Fischer on 09.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Switch : NSObject {
	NSString *swid;
	NSString *type;
 }

@property (nonatomic, retain) NSString *swid;
@property (nonatomic, retain) NSString *type;

- (NSString*) getImgName;

@end
