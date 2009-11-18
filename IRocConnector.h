//
//  Sender.h
//  iRoc
//
//  Created by Jean-Michel Fischer on 18.11.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface IRocConnector : NSObject {
@private
    NSString *domain;
    uint16_t port;
}

- (BOOL)sendMessage:(NSString *)name message:(NSString *)msg;

- (NSString *)domain;
- (void)setDomain:(NSString *)value;

- (uint16_t)port;
- (void)setPort:(uint16_t)value;

- (BOOL)start;
- (BOOL)stop;

- (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)eventCode;

@end
