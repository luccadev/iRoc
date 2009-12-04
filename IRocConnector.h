//
//  Sender.h
//  iRoc
//
//  Created by Jean-Michel Fischer on 18.11.09.
//  Copyright 2009 rocrail.net. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface IRocConnector : NSObject {
@private
    NSString *domain;
    uint16_t port;
	int connectTimeout;
	
	NSOutputStream *  oStream;
	NSInputStream *   iStream;
	
	NSHost* host;
	
	NSMutableData* _data;
	NSNumber* bytesRead;
	
	NSMutableString *header;
	NSMutableString *rocdata;
	
	BOOL isConnected;
	BOOL readRocdata;
	
	
	BOOL readHeader;
	
	unsigned int readsize;
	int bytesread;
}




- (BOOL)sendMessage:(NSString *)name message:(NSString *)msg;

- (NSString *)domain;
- (void)setDomain:(NSString *)value;

- (uint16_t)port;
- (void)setPort:(uint16_t)value;

- (BOOL)connect;
- (BOOL)stop;
- (void)requestPlan;

- (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)eventCode;

@property(readwrite) BOOL isConnected;

@property(copy) NSString *domain;
@property(nonatomic, retain) NSMutableString *header;
@property(nonatomic, retain) NSMutableString *rocdata;

@end
