//
//  iRocConnector.m
//  iRoc
//
//  Created by Jean-Michel Fischer on 18.11.09.
//  Copyright 2009 rocrail.net . All rights reserved.
//

#import "IRocConnector.h"

@implementation IRocConnector

@synthesize header, rocdata, isConnected;

- (BOOL)connect {
	
	readsize = 0;
	readRocdata = FALSE;
	readHeader = TRUE;
	
	//header = [NSMutableString string];
	//rocdata = [NSMutableString string];
	
	NSLog([NSString stringWithFormat: @"Connect to: %@:%d ", domain, port]);	
	
	BOOL connectOK = false;
	
	//CFReadStreamRef readStream = NULL;
	//CFWriteStreamRef writeStream = NULL;
	iStream = NULL;
	oStream = NULL;
	isConnected = FALSE;
	
	CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)domain, port, (CFReadStreamRef*)&iStream, (CFWriteStreamRef*)&oStream);
	//NSLog([NSString stringWithFormat: @"Connected?"]);	
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
		    //[self sendMessage:@"model" message:@"<model cmd=\"plan\"/>"];
		} else {
			connectOK = FALSE;
	    }
		 
		isConnected = TRUE;
		[[NSRunLoop currentRunLoop] run];

	} 	
	
	return connectOK;
}

- (void)requestPlan {
  [self sendMessage:@"model" message:@"<model cmd=\"plan\"/>"];
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
	
	//NSLog([NSString stringWithFormat: @">> %@"], stringToSend);		
	
	NSData * dataToSend = [stringToSend dataUsingEncoding:NSUTF8StringEncoding];
	
	if (oStream) {
		int remainingToWrite = [dataToSend length];
		void * marker = (void *)[dataToSend bytes];
		while (0 < remainingToWrite) {
			int actuallyWritten = 0;
			actuallyWritten = [oStream write:marker maxLength:remainingToWrite];
      if( actuallyWritten > 0 ) {
  			remainingToWrite -= actuallyWritten;
        NSLog(@"actuallyWritten=%d remainingToWrite=%d", actuallyWritten, remainingToWrite);		
	  		marker += actuallyWritten;
      }
		}
	}
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
	
	//NSLog(@"stream:handleEvent: is invoked...");
	

	
    switch(eventCode) {
        case NSStreamEventHasBytesAvailable:
        {
            if(!_data) {
              NSLog(@"init data...");
                _data = [[NSMutableData data] retain];
            }
			
			if(!header) {
        NSLog(@"init header...");
				header = [[NSMutableString string] retain];
			}
			
			NSLog(@"readHeader: %d ... readRocdata: %d", readHeader, readRocdata);
			
            uint8_t buf[1024];
            unsigned int len = 1;
			
			if( readHeader ) {
				
				while ( ![header hasSuffix:@"</xmlh>"]){
					len = [(NSInputStream *)stream read:buf maxLength:1];
					
					[_data appendBytes:(const void *)buf length:len];
					header = [[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding];
					
					//NSLog(@"%@", header);
				}
        NSLog(@"%@", header);
				
				if ( [header hasSuffix:@"</xmlh>"]){
					NSXMLParser *parser = [[NSXMLParser alloc] initWithData:_data];
					[parser setDelegate:self];
					[parser parse];
					
					NSLog(@"Header read ... size: %d", readsize);

					[parser release]; 
					[_data release];
					_data = nil;
					[header release];
					header = nil;
					
					readHeader = FALSE;
					readRocdata = TRUE;
				}
				
			} else if ( readRocdata) {
        int imax = 1024;
        if( len < imax )
          imax = len;
				
				len = [(NSInputStream *)stream read:buf maxLength:imax];
				[_data appendBytes:(const void *)buf length:len];
				
				
				NSLog(@"readsize: %d len: %d", readsize, len);
				
				/*
				if (readsize > len)
					readsize  = readsize - len;
				else 
					readsize = 0;
				*/
				
				NSLog(@"readsize: %d len: %d", readsize, len);
				
				// mhhhhhhhhhhhhh????
				if( len < 1024) {
					
					NSLog(@"###################################################################");
					NSLog([[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding]);
					NSLog(@"###################################################################");
					
					
					NSXMLParser *parser = [[[NSXMLParser alloc] initWithData:_data] retain];
					[parser setDelegate:self];
					[parser parse];
					
					NSLog(@"Data sent to parser ... ");
					
					
					
					[parser release];  
					[_data release];
					_data = nil;
					
					// start from the beginning ....
					readHeader = TRUE;
					readRocdata = FALSE;
				}
				
			} else {
				
				NSLog(@"Somthing went wrong ... ");
				
			}
			
				
			break;
        }
	}
}

#pragma mark Parser constants

// Reduce potential parsing errors by using string constants declared in a single place.
static NSString * const kEntryElementName = @"entry";


#pragma mark NSXMLParser delegate methods

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {

	//NSLog(@"Parser didStartElement ... %@", elementName);
	
	
	if ([elementName isEqualToString:@"xmlh"]) {
		//NSLog(@"parser: xmlh");
	} else if ([elementName isEqualToString:@"xml"]) {
		NSLog(@"parser: xml");		
		NSString *relAttribute = [attributeDict valueForKey:@"size"];		
		readsize = [relAttribute intValue];
	} else if ([elementName isEqualToString:@"lc"]) {
		NSString *relAttribute = [attributeDict valueForKey:@"id"];		
        NSLog(@"parser: lc: %@", relAttribute);	
	} else if ([elementName isEqualToString:@"sw"]) {
		NSString *relAttribute = [attributeDict valueForKey:@"id"];		
        NSLog(@"parser: sw: %@", relAttribute);	
	} else if ([elementName isEqualToString:@"lclist"]) {
		NSLog(@"parser: lclist");	
	} else if ([elementName isEqualToString:@"exception"]) {
		NSString *relAttribute = [attributeDict valueForKey:@"text"];		
		NSLog(@"parser: exception = %@", relAttribute);
	}
	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {     
	if ([elementName isEqualToString:@"xmlh"]) {
		//NSLog(@"parser: /xmlh");
	}
}

// This method is called by the parser when it find parsed character data ("PCDATA") in an element. The parser is not
// guaranteed to deliver all of the parsed character data for an element in a single invocation, so it is necessary to
// accumulate character data until the end of the element is reached.
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {

}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {

}

@end

