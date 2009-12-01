//
//  Sender.m
//  iRoc
//
//  Created by Jean-Michel Fischer on 18.11.09.
//  Copyright 2009 rocrail.net . All rights reserved.
//

#import "IRocConnector.h"

@implementation IRocConnector

@synthesize header;

- (BOOL)connect {
	
	header = [NSMutableString string];
	
	NSLog([NSString stringWithFormat: @"Connect to: %@:%d ", domain, port]);	
	
	BOOL connectOK = false;
	
	//CFReadStreamRef readStream = NULL;
	//CFWriteStreamRef writeStream = NULL;
	iStream = NULL;
	oStream = NULL;
	isConnected = FALSE;
	
	CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)domain, port, (CFReadStreamRef*)&iStream, (CFWriteStreamRef*)&oStream);
	NSLog([NSString stringWithFormat: @"Connected?"]);	
	if (iStream && oStream) {
		
		//iStream = (NSInputStream *)readStream;
		[iStream retain];
		[iStream setDelegate:self];
		[iStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
		[iStream open];
		
		//oStream = (NSOutputStream *)writeStream;
		[oStream retain];
		[oStream setDelegate:self];
		[oStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
		[oStream open];

		NSDate *start = [NSDate date];

		// Wait for the oStream to get ready
		while([oStream streamStatus] == NSStreamStatusOpening && [start timeIntervalSinceNow]*-1 < 5) { //![oStream streamStatus] == NSStreamStatusOpen && 
			NSLog([NSString stringWithFormat: @"Opening I:%d, O:%d T:%f",[iStream streamStatus],[oStream streamStatus],[start timeIntervalSinceNow]]);
		}
	
		if( [oStream streamStatus] == NSStreamStatusOpen && [iStream streamStatus] == NSStreamStatusOpen ) {
			connectOK = TRUE;
		    [self sendMessage:@"model" message:@"<model cmd=\"lclist\"/>"];
		} else {
			connectOK = FALSE;
	    }
		 
		[[NSRunLoop currentRunLoop] run];
		isConnected = TRUE;
	} 	
	
	return connectOK;
}

- (BOOL)stop {
	
	isConnected = FALSE;
	
	[iStream close];
    [oStream close];
    [iStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [oStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [iStream setDelegate:nil];
    [oStream setDelegate:nil];
    [iStream release];
    [oStream release];
    iStream = nil;
    oStream = nil;
	
	return TRUE;
}


- (BOOL)sendMessage:(NSString *)name message:(NSString *)msg {

	//if( !isConnected)
	//	[self connect];
	
	NSString * stringToSend; 			
	stringToSend = [NSString stringWithFormat: @"<xmlh><xml size=\"%d\" name=\"%@\"/></xmlh>%@", [msg length], name, msg];
	stringToSend = [stringToSend stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	
	
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

bool readit;

- (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)eventCode {
	
	//NSLog(@"stream:handleEvent: is invoked...");
	
	
	
	readit = FALSE;
	
    switch(eventCode) {
        case NSStreamEventHasBytesAvailable:
        {
            if(!_data) {
                _data = [[NSMutableData data] retain];
            }
            uint8_t buf[1024];
            unsigned int len = 1;
			
			
			/*
			while ( ![header hasSuffix:@"</xmlh>"] && read ){
            len = [(NSInputStream *)stream read:buf maxLength:1];
			
			//NSLog(@"Output: %s", (const void *)buf);
			
			//NSLog(@"len: %d", len);
			//header = [[NSString alloc] initWithBytes:(const void *)buf length:len encoding:NSUTF8StringEncoding];
				
			

				
			NSString *stringFragment = [[NSString string] initWithBytes:(uint8_t*)buf length:(NSUInteger)len encoding:NSUTF8StringEncoding];
			[self.header appendString:stringFragment];
	
				
				
			//if (len)	
			//	header = [[NSString alloc] stringWithFormat:@"%@%@", header, [NSString initWithBytes:(const void *)buf length:len encoding:NSUTF8StringEncoding]];
				
				
				//[header appendString:[[NSString alloc] initWithBytes:(const void *)buf length:len encoding:NSUTF8StringEncoding]];
				
				
			
			//NSLog(@"val: %@", [[NSString alloc] initWithBytes:(const void *)buf length:len encoding:NSUTF8StringEncoding]);
				
			//NSLog(@"val: %@", header);
				
				
			}
			
			if( [header hasSuffix:@"</xmlh>"] ) {
				NSLog(@"value: %@", header);
				
				readit = FALSE;
				
				header = @"";
				NSLog(@"####################################");
			}
			
			
			
			
			*/
			
			
			
			
			
            if(len) {
                [_data appendBytes:(const void *)buf length:len];
				
				// TODO: here we go on in later ...
				
				//NSLog(@"Output: %s", (const void *)buf);
				
				
				//s = [[NSString alloc] initWithBytes:(const void *)buf length:len encoding:NSUTF8StringEncoding];
				//NSLog(@"%@", s);
				//[s release];
				
				
				//if( 
				
				
				
				
                // bytesRead is an instance variable of type NSNumber.
                //[bytesRead setIntValue:[bytesRead intValue]+len];
            } else {
                NSLog(@"no buffer!");
            }
			
			
			
			/*
			NSString *s = [[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding];
			NSLog(@"%@", s);
			[s release];
			 */
			
            break;
        }
	}
}

@end
