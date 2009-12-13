//
//  iRocConnector.m
//  iRoc
//
//  Created by Jean-Michel Fischer on 18.11.09.
//  Copyright 2009 rocrail.net . All rights reserved.
//

#import "IRocConnector.h"


@implementation IRocConnector

@synthesize header, rocdata, isConnected, currentLocObject, locList, locIndexList, rtList, swList, coList;
//@synthesize locTableViewController;

- (id) init {
	[super init];
	//self.locList = [[NSMutableArray array] retain];
	NSLog(@"Connector init ...");

	return self;
}

- (BOOL)connect {

	bytesread = 0;
	readsize = 0;
	readRocdata = FALSE;
	readHeader = TRUE;
    _data = NULL;
    header = NULL;
    rocdata = NULL;
	
	NSLog([NSString stringWithFormat: @"Connect to: %@:%d ", domain, port]);	
	
	BOOL connectOK = FALSE;

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

- (void)requestLocpic:(NSString*)lcid withFilename:(NSString*)filename{
	
	NSLog(@"requesteLocpic: %@ - %@", lcid, filename);

	[self sendMessage:@"datareq" 
			  message:[[NSString alloc] 
	   initWithString:[NSString stringWithFormat: @"<datareq id=\"%@\" filename=\"%@\"/>",lcid,filename]]];
	 
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
        //NSLog(@"actuallyWritten=%d remainingToWrite=%d", actuallyWritten, remainingToWrite);		
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
            if(_data == nil) {
              //NSLog(@"init data...");
                //_data = [[NSMutableData data] retain];
				_data = [[NSMutableData data] retain];
            }
			
			if(header == nil) {
				//NSLog(@"init header...");
				header = [[NSMutableString string] retain];
			}
			
			//NSLog(@"readHeader: %d ... readRocdata: %d", readHeader, readRocdata);
			
            uint8_t buf[2048];
            unsigned int len = 1;
			
			if( readHeader ) {
				
				while ( ![header hasSuffix:@"</xmlh>"]){
					len = [(NSInputStream *)stream read:buf maxLength:1];
					
					if (_data == nil)
					    NSLog(@"##################### OHHHH");
					
				// TODO: Here is a BIG Problem!!!
					
					//if( _data != nil) {
						[_data appendBytes:(uint8_t*)buf length:len];
						header = [[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding];
					//}
					
					//NSLog(@"connector: len: %d", len);
				}
        //NSLog(@"%@", header);
				
				if ( [header hasSuffix:@"</xmlh>"]){
					NSXMLParser *parser = [[NSXMLParser alloc] initWithData:_data];
					[parser setDelegate:self];
					[parser parse];
					
					//NSLog(@"Header read ... size: %d", readsize);

					[parser release]; 
					[_data release];
					_data = nil;
					[header release];
					header = nil;
					
					readHeader = FALSE;
					readRocdata = TRUE;
					
					bytesread = 0;
				}
				
			} else if ( readRocdata) {
				int imax = 1024;
				if( readsize < imax )
					imax = readsize;
				
				len = [(NSInputStream *)stream read:buf maxLength:imax];
				[_data appendBytes:(const void *)buf length:len];

				bytesread += imax;
				//NSLog(@"readsize: %d len: %d btr: %d", readsize, len, bytesread);

				if( len < 1024 || readsize == bytesread) {
					
					/*
					NSLog(@"###################################################################");
					NSLog([[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding]);
					NSLog(@"###################################################################");
					*/
					
					NSXMLParser *parser = [[[NSXMLParser alloc] initWithData:_data] retain];
					[parser setDelegate:self];
					[parser parse];
					
					//NSLog(@"Data sent to parser ... ");
					
					[parser release];  
					[_data release];
					_data = nil;
					
					// start from the beginning ....
					readHeader = TRUE;
					readRocdata = FALSE;

				}
				
			} else {
				
				NSLog(@"Something went wrong ... ");
				
			}
			
				
			break;
        }
	}
}

//#pragma mark Parser constants

// Reduce potential parsing errors by using string constants declared in a single place.
static NSString * const kLocElementName = @"lc";
static NSString * const kIdElementName = @"id";

//#pragma mark NSXMLParser delegate methods

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {

	//NSLog(@"Parser didStartElement ... %@", elementName);
	
	
	if ([elementName isEqualToString:@"xmlh"]) {
		//NSLog(@"parser: xmlh");
	} else if ([elementName isEqualToString:@"xml"]) {
		//NSLog(@"parser: xml");		
		NSString *relAttribute = [attributeDict valueForKey:@"size"];		
		readsize = [relAttribute intValue];
	} else if ([elementName isEqualToString:kLocElementName]) {
		if( ![[attributeDict valueForKey:@"show"] isEqualToString:@"false"] ) {
			NSString *relAttribute = [attributeDict valueForKey:kIdElementName];
			Loc *loc = [[[Loc alloc] init] retain];
			loc.locid = relAttribute;

			NSString *imgname = [attributeDict valueForKey:@"image"];
			if( ![imgname isEqualToString:@""] ) {
				NSLog(@"connector %@ : %@", relAttribute, imgname);
				loc.hasImage = YES;
				loc.imgname = imgname;
			}
			[loc setDesc:[attributeDict valueForKey:@"desc"]];
			
			
			[self.locIndexList addObject:relAttribute];
			[self.locList addObject:loc];
		}
	} else if ([elementName isEqualToString:@"sw"]) {
		NSString *relAttribute = [attributeDict valueForKey:kIdElementName];
		NSString *type = [attributeDict valueForKey:@"type"];
		//NSLog(@"parser: sw: %@", [attributeDict valueForKey:kIdElementName]);
		
		Switch *sw = [[[Switch alloc] init] retain];
		sw.swid = relAttribute;
		sw.type = type;
		[self.swList addObject:sw];
        
	} else if ([elementName isEqualToString:@"st"]) {
		NSString *relAttribute = [attributeDict valueForKey:kIdElementName];		
        
		Route *rt = [[[Route alloc] init] retain];
		rt.rtid = relAttribute;
		[self.rtList addObject:rt];
		
	} else if ([elementName isEqualToString:@"co"]) {
		NSString *relAttribute = [attributeDict valueForKey:kIdElementName];		
        //NSLog(@"parser: co: %@", [attributeDict valueForKey:kIdElementName]);
		Output *co = [[[Output alloc] init] retain];
		co.coid = relAttribute;
		[self.coList addObject:co];
	} else if ([elementName isEqualToString:@"datareq"]) {
		NSString *relAttribute = [attributeDict valueForKey:kIdElementName];
		
		//NSLog(@"connector LOCPIC: %@ ",relAttribute );

		NSString *data = [attributeDict valueForKey:@"data"];
		//Loc *loc = (Loc*) [self.locList objectAtIndex:[locIndexList indexOfObject:relAttribute]];
		[((Loc*) [self.locList objectAtIndex:[locIndexList indexOfObject:relAttribute]]) setLocpicdata:data]; 
		
	} 
	
	else if ([elementName isEqualToString:@"lclist"]) {
		//NSLog(@"parser: lclist");	
	} /*else if ([elementName isEqualToString:@"exception"]) {
		NSString *relAttribute = [attributeDict valueForKey:@"text"];		
		NSLog(@"parser: exception = %@", relAttribute);
	}*/ 
	else if ([elementName isEqualToString:@"sys"]) {
		NSString *relAttribute = [attributeDict valueForKey:@"cmd"];
		if( [relAttribute isEqualToString:@"shutdown"] ) {
			NSLog(@"We should go down now [%@]", relAttribute);
			[self stop]; 
			exit(0);
		}
	}
	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {     
	if ([elementName isEqualToString:@"lclist"]) {
		// inform the delegate
		if ( [_delegate respondsToSelector:@selector(lcListLoaded)] ) {
			[_delegate lcListLoaded];
		} 
		NSLog(@"%d locs added ... ", [locList count]);
	} else if ([elementName isEqualToString:@"stlist"]) {
		// inform the delegate
		if ( [_delegate respondsToSelector:@selector(rtListLoaded)] ) {
			[_delegate rtListLoaded];
		} 
		NSLog(@"%d rts added ... ", [rtList count]);
	} else if ([elementName isEqualToString:@"swlist"]) {
		// inform the delegate
		if ( [_delegate respondsToSelector:@selector(swListLoaded)] ) {
			[_delegate swListLoaded];
		} 
		NSLog(@"%d sws added ... ", [swList count]);
	} else if ([elementName isEqualToString:@"colist"]) {
		// inform the delegate
		if ( [_delegate respondsToSelector:@selector(coListLoaded)] ) {
			[_delegate coListLoaded];
		} 
		NSLog(@"%d cos added ... ", [coList count]);
	} else if ([elementName isEqualToString:@"plan"]) {
		// inform the delegate
		NSLog(@"The Plan arrived.");
		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	}
	
	
}

// This method is called by the parser when it find parsed character data ("PCDATA") in an element. The parser is not
// guaranteed to deliver all of the parsed character data for an element in a single invocation, so it is necessary to
// accumulate character data until the end of the element is reached.
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {

}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	NSLog(@"### Parse Error: %@ ", [parseError localizedDescription]);
	// TODO: somthing is wrong with the parser
	// start from the beginning ....	
	
	/*
	[_data release];
	_data = nil;
	[header release];
	header =nil;	
	 */

	readHeader = TRUE;
	readRocdata = FALSE;
	bytesread = 0;
}


- (id)delegate
{
    return _delegate;
}

- (void)setDelegate:(id)new_delegate
{
    _delegate = new_delegate;
}


@end

