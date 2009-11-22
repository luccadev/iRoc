//
//  Sender.m
//  iRoc
//
//  Created by Jean-Michel Fischer on 18.11.09.
//  Copyright 2009 rocrail.net . All rights reserved.
//

#import "IRocConnector.h"

NSOutputStream *  oStream;
NSInputStream *   iStream;

NSHost* host;

NSMutableData* _data;
NSNumber* bytesRead;

BOOL isConnected = FALSE;

@implementation IRocConnector

- (BOOL)connect {
	
	// Connect Thread
	//[NSThread detachNewThreadSelector:@selector(timerFired) toTarget:self withObject:nil];
	//connectTimer = [[NSTimer scheduledTimerWithTimeInterval:(1.0/1.0) target:self selector:@selector(timerFired) userInfo:nil repeats:YES] retain]; 

	NSLog([NSString stringWithFormat: @"Connect to: %@:%d ", domain, port]);	
	
	BOOL connectOK = false;
	
	CFReadStreamRef readStream = NULL;
	CFWriteStreamRef writeStream = NULL;
	iStream = NULL;
	oStream = NULL;
	
	CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)domain, port, &readStream, &writeStream);
	NSLog([NSString stringWithFormat: @"Connected?"]);	
	if (readStream && writeStream) {
		// CFReadStreamSetProperty(readStream, CFStreamPropertyShouldCloseNativeSocket, kCFBooleanTrue);
		// CFWriteStreamSetProperty(writeStream, CFStreamPropertyShouldCloseNativeSocket, kCFBooleanTrue);
		iStream = (NSInputStream *)readStream;
		[iStream retain];
		[iStream setDelegate:self];
		[iStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
		[iStream open];
		
		oStream = (NSOutputStream *)writeStream;
		[oStream retain];
		[oStream setDelegate:self];
		[oStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
		[oStream open];

		NSDate *start = [NSDate date];

		// Wait for the oStream to get ready
		while([oStream streamStatus] == NSStreamStatusOpening && [start timeIntervalSinceNow]*-1 < 5) { //![oStream streamStatus] == NSStreamStatusOpen && 
			NSLog([NSString stringWithFormat: @"Opening I:%d, O:%d T:%f",[iStream streamStatus],[oStream streamStatus],[start timeIntervalSinceNow]]);
		}
		
		if( [oStream streamStatus] == NSStreamStatusOpen ) {
			connectOK = TRUE;
		    [self sendMessage:@"model" message:@"<model cmd=\"plan\"/>"];
		} else {
			connectOK = FALSE;
	    }
		 
			
			
	} 	
	
	return connectOK;
}

- (BOOL)stop {
	return TRUE;
}


-(void)timerFired { 
	
	NSLog([NSString stringWithFormat:@"timerFired: %d", connectTimeout]);
	connectTimeout += 1;
	//textfieldLoc.text = [NSString stringWithFormat:@"%d", connectInt];
	
} 


- (BOOL)sendMessage:(NSString *)name message:(NSString *)msg {

	//if( !isConnected)
		//[self start];
	
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
	//NSLog([NSString stringWithFormat: @"##%@##"], stringToSend);		
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
				
				//NSLog(bytesRead);
            } else {
                NSLog(@"no buffer!");
            }
            break;
        }
	}
}

@end
