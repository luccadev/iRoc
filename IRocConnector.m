//
//  Sender.m
//  iRoc
//
//  Created by Jean-Michel Fischer on 18.11.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "IRocConnector.h"

NSOutputStream *  oStream;
NSInputStream *   iStream;

NSHost* host;

NSMutableData* _data;
NSNumber* bytesRead;

BOOL isConnected = FALSE;

@implementation IRocConnector


- (BOOL)start {
	
		host = [NSHost hostWithAddress:@"192.168.0.101"];
		if( host ) {
			[NSStream getStreamsToHost:host port:62842 inputStream:&iStream outputStream:&oStream];
			if( nil != iStream && nil != oStream ) {
				[iStream retain];
				[oStream retain];
			
				[iStream setDelegate:self] ;
				[oStream setDelegate:self] ;
			
				[iStream scheduleInRunLoop:[NSRunLoop currentRunLoop]
							   forMode:NSDefaultRunLoopMode];
				[oStream scheduleInRunLoop:[NSRunLoop currentRunLoop]
							   forMode:NSDefaultRunLoopMode];
				[iStream open];
				[oStream open];	
			
				isConnected = TRUE;
			
				// send something to keep the connection up!
				[self sendMessage:@"model" message:@"<model cmd=\"plan\"/>"];
			}

	}
	return TRUE;

}

- (BOOL)stop {
	return TRUE;
}

- (BOOL)sendMessage:(NSString *)name message:(NSString *)msg {

	if( !isConnected)
		[self start];
	
	NSString * stringToSend; 			
	stringToSend = [NSString stringWithFormat: @"<xmlh><xml size=\"%d\" name=\"%@\"/></xmlh>%@", [msg length], name, msg];
	NSData * dataToSend = [stringToSend dataUsingEncoding:NSUTF8StringEncoding];
	
	if (oStream) {
		int remainingToWrite = [dataToSend length];
		void * marker = (void *)[dataToSend bytes];
		while (0 < remainingToWrite) {
			int actuallyWritten = 0;
			actuallyWritten = [oStream write:marker maxLength:remainingToWrite];
			remainingToWrite -= actuallyWritten;
			marker += actuallyWritten;
		}
	}
	NSLog([NSString stringWithFormat: @"##%@##"], stringToSend);		
	return TRUE;
}



- (NSString *)domain {
    return domain;
}

- (void)setDomain:(NSString *)value {
    if (domain != value) {
        [domain release];
        domain = [value copy];
    }
}

- (uint16_t)port {
    return port;
}

- (void)setPort:(uint16_t)value {
    port = value;
}



- (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)eventCode {
    switch(eventCode) {
        case NSStreamEventHasBytesAvailable:
        {
            if(!_data) {
                _data = [[NSMutableData data] retain];
            }
            uint8_t buf[1024];
            unsigned int len = 0;
            len = [(NSInputStream *)stream read:buf maxLength:1024];
            if(len) {
                [_data appendBytes:(const void *)buf length:len];
				
                // bytesRead is an instance variable of type NSNumber.
                [bytesRead setIntValue:[bytesRead intValue]+len];
            } else {
                NSLog(@"no buffer!");
            }
            break;
        }
	}
}

@end
