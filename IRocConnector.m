/*
 Rocrail - Model Railroad Software
 
 Copyright (C) 2009-2010 - Rob Versluis <r.j.versluis@rocrail.net>, Jean-Michel Fischer <jmf@polygonpunkt.de>
 
 This program is free software; you can redistribute it and/or
 modify it under the terms of the GNU General Public License
 as published by the Free Software Foundation; either version 2
 of the License, or (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 */

#import "IRocConnector.h"
#import "iRocAppDelegate.h"
#import "Model.h"
#import "ZLevel.h"


@implementation IRocConnector

@synthesize header, rocdata, isConnected, readyConnecting, currentLocObject;

- (id) init {
	[super init];
	//self.locList = [[NSMutableArray array] retain];
	NSLog(@"Connector init ...");
  
	return self;
}

- (BOOL)connect {
  
	messageQueue = [[NSMutableArray array] retain];
  
	bytesread = 0;
	readsize = 0;
	readRocdata = FALSE;
	readHeader = TRUE;
  _data = nil;
  header = nil;
  rocdata = NULL;
  debug = FALSE;
  pendingLocoPic = FALSE;
  parsingPlan = FALSE;
  connectionError = FALSE;
	
  BOOL connectOK = [self doConnect];
	
  if(isConnected) {
    NSLog(@"starting currentLoop...");
    [[NSRunLoop currentRunLoop] run];
  }
  else {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
  }

	return connectOK;
}


- (BOOL)doConnect {
  
  if( domain == nil || [domain length] == 0 ) {
    NSLog(@"Using hard coded defaults for connection...");	
    domain = @"rocrail.dyndns.org";
    port = 8080;
  }
  
	NSLog(@"Connect to: %@:%d ", domain, port);	
	
	BOOL connectOK = FALSE;
  
	iStream = NULL;
	oStream = NULL;
	isConnected = FALSE;
	readyConnecting = FALSE;
	
	CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)domain, port, (CFReadStreamRef*)&iStream, (CFWriteStreamRef*)&oStream);
	//NSLog([NSString stringWithFormat: @"Connected?"]);	
  NSLog(@"iStream=0x%08X oStream=0x%08X", iStream, oStream);
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
    
		// Wait for the oStream to get ready
    int retry = 5;
		while([oStream streamStatus] != NSStreamStatusOpen &&
          [iStream streamStatus] != NSStreamStatusOpen &&
          retry > 0) 
    {
			NSLog(@"Opening I:%d, O:%d retry=%d", [iStream streamStatus],[oStream streamStatus], retry);
      retry--;
      [NSThread sleepForTimeInterval:1];
		}
    
		if( [oStream streamStatus] == NSStreamStatusOpen && [iStream streamStatus] == NSStreamStatusOpen ) {
			connectOK = TRUE;
      connectionError = FALSE;
		}
    
  	readyConnecting = TRUE;
		isConnected = connectOK;
    
	} 	
	
	return connectOK;
}


- (void)requestPlan {
  NSLog(@"requestPlan...");
  [self sendMessage:@"model" message:@"<model cmd=\"plan\" disablemonitor=\"true\"/>"];
}

- (void)requestLocpic:(NSString*)lcid withFilename:(NSString*)filename{
  
  NSLog(@"requesteLocpic: %@ - %@", lcid, filename);
  // type 1 is for small images
  [messageQueue addObject:[[NSString alloc] 
                           initWithString:[[NSString stringWithFormat: @"<datareq id=\"%@\" type=\"1\" filename=\"%@\"/>",lcid,filename]retain]]];

  [self nextLocpic:FALSE];
}

- (void)nextLocpic:(BOOL)fromSax{
  
  //NSLog(@"nextLocpic: pending=%d fromSax=%d queue=%d", pendingLocoPic, fromSax, [messageQueue count]);
  
  if( (!pendingLocoPic||fromSax) && [messageQueue count] > 0 ) {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    pendingLocoPic = TRUE;
    NSString* msg = [messageQueue objectAtIndex:0];
    if( msg != nil ) {
      

  	//NSLog(@"requesting Locpic: %@", msg);
    
  	[self sendMessage:@"datareq" message:msg];
      [messageQueue removeObjectAtIndex:0];
    [msg release];
    }


  }
  else {
  	NSLog(@"sorry, pending...");
  }
  
  if( [messageQueue count] == 0 ) {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
  }
  
}


- (BOOL)stop {
	
  NSLog(@"shutting down connection...");
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

  NSLog(@"connection down.");
	
	return TRUE;
}


- (BOOL)sendMessage:(NSString *)name message:(NSString *)msg {
	
	NSData * tmp = [msg dataUsingEncoding:NSUTF8StringEncoding];
	NSString * stringToSend; 			
	stringToSend = [NSString stringWithFormat: @"<xmlh><xml size=\"%d\" name=\"%@\"/></xmlh>%@", [tmp length], name, msg];
	stringToSend = [stringToSend stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	
  if( debug )
	  NSLog(@"sending:\n%@", stringToSend);		
	
	NSData * dataToSend = [stringToSend dataUsingEncoding:NSUTF8StringEncoding];
	
	if (isConnected && oStream) {
		int remainingToWrite = [dataToSend length];
		void * marker = (void *)[dataToSend bytes];
		while (remainingToWrite > 0) {
			int actuallyWritten = 0;
			actuallyWritten = [oStream write:marker maxLength:remainingToWrite];
      if( actuallyWritten > 0 ) {
  			remainingToWrite -= actuallyWritten;
        NSLog(@"actuallyWritten=%d remainingToWrite=%d", actuallyWritten, remainingToWrite);		
	  		marker += actuallyWritten;
      }
		}
	}
  else {
    NSLog( @"offline: message not send.");
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
	
  if( debug)
	  NSLog(@"stream:handleEvent: is invoked with event=%d...", eventCode);
	
  switch(eventCode) {
  
  
    case NSStreamEventHasSpaceAvailable:
    {
      NSLog(@"stream has space open");
      // TODO:
      // COMPOSE DATA TO SEND
      // SEND DATA         
      break ;
    }
            
    case NSStreamEventEndEncountered:
    {
      NSLog(@"stream ended; will be closed") ;
      // MAKE SURE TO CLOSE STREAMS
      [self stop];
      break;
    }

    case NSStreamEventErrorOccurred:
    {
      // THIS IS WHERE YOU CATCH THE ERRORS
      NSError *err = [stream streamError];
      NSLog(@"Stream error: rc=%d %@", [err code], [err localizedDescription]) ;
            
      // MAKE SURE TO CLOSE STREAMS
      // ALSO HERE, I SEND THE ERROR MESSAGE
      // THIS WILL TRIGGER WHEN BAD IP/PORT IS ENTERED

      [self stop];
      [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
      if( !connectionError ) {
        connectionError = TRUE;
        UIAlertView *alert = [[UIAlertView alloc] 
                            initWithTitle:@"Warning" 
                            message:[NSString stringWithFormat: @"Connection with %@:%d lost!",self.domain, self.port] 
                            delegate:self 
                            cancelButtonTitle:nil 
                            otherButtonTitles:@"OK",nil];
        [alert show];
      }
      [self doConnect];
      [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
      break ;
    } 
                       
    case NSStreamEventNone:
      NSLog(@"stream null event") ;
      break ;
            
    case NSStreamEventOpenCompleted:
      NSLog(@"stream is now open") ;
      break ;

    case NSStreamEventHasBytesAvailable:
    {
       
      if( debug)
        NSLog(@"stream: handle NSStreamEventHasBytesAvailable, readHeader=%d readRocdata=%d...", readHeader, readRocdata);
      
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
      int len = 1;
			
			if( readHeader ) {
        
        @synchronized(self) {
        NSLog(@"streamStatus=%d", [(NSInputStream *)stream streamStatus]);
				while ( len >= 0 && ![header hasSuffix:@"</xmlh>"] ){
					len = [(NSInputStream *)stream read:buf maxLength:1];
          //NSLog(@"len=%d", len);
          
          if( len > 0 ) {
  					[_data appendBytes:(uint8_t*)buf length:len];
	  				header = [[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding];
            //NSLog(@"header: %@", header);
          }
          if( [_data length] > 1024) {
            NSLog(@"data length=%d; break.", [_data length]);
            break;
          } 
				}
        NSLog(@"streamStatus=%d", [(NSInputStream *)stream streamStatus]);
				}
        
				BOOL validHeader = FALSE;
				
				if ( [header hasSuffix:@"</xmlh>"]){
				  // search for the start of the header
          
				  
          NSUInteger start = [header rangeOfString:@"<?xml"].location;
				  if (start != NSNotFound) {
            if( start != 0 ) {
              NSLog(@"Start of header found at %d\n%@", start, header);
              NSRange range;
              range.location = start;
              range.length = [_data length]-start;
              //NSString* tmp = [[NSString alloc] initWithData:[_data subdataWithRange:range] encoding:NSUTF8StringEncoding];
              //NSLog([tmp substringFromIndex:start]);
              [header release];
              header = [[NSString alloc] initWithData:[_data subdataWithRange:range] encoding:NSUTF8StringEncoding];

              //header = [[NSString alloc] initWithString:[tmp substringFromIndex:start]];
            }
				    validHeader = TRUE;
				  }
				  else {
				    // invalid header.
  					NSLog(@"Start of header not found; flush buffer.");
					  [_data release];
					  _data = nil;
  					[header release];
	  				header = nil;
					  readHeader = TRUE;
					  readRocdata = FALSE;
				  }
				}
        else {
          // invalid header.
          NSLog(@"End of header not found; flush buffer: %@", header);
          [_data release];
          _data = nil;
          [header release];
          header = nil;
          readHeader = TRUE;
          readRocdata = FALSE;
        }
        
				
				
				
				if ( validHeader ){
					NSXMLParser *parser = [[NSXMLParser alloc] initWithData:_data];
					[parser setDelegate:self];
          
          [parser setShouldProcessNamespaces:NO];
          [parser setShouldReportNamespacePrefixes:NO];
          
					BOOL ok = [parser parse];
					
					//NSLog(@"Header read ... size: %d", readsize);
          
					[parser release]; 
					
          [_data release];
          _data = nil;
					
					if( !ok ) {
            NSLog(@"parser error in header detected...");
					  readHeader = TRUE;
					  readRocdata = FALSE;
            [header release];
            header = nil;
          }
          else {		
					  readHeader = FALSE;
					  readRocdata = TRUE;
          }
          
					bytesread = 0;
				}
				
			} 
      else if ( readRocdata) {
				int imax = 1024;
				if( readsize < imax )
					imax = readsize;
        
        if( readsize - bytesread < imax )
          imax = readsize - bytesread;
				
				len = [(NSInputStream *)stream read:buf maxLength:imax];
				[_data appendBytes:(const void *)buf length:len];
        
				bytesread += len;
        if(debug)
				  NSLog(@"readsize: %d len: %d bytesread: %d", readsize, len, bytesread);
        
				if( bytesread >= readsize ) {
          if(bytesread > readsize) {
            NSLog(@"**Read too much! readsize=%d bytesread=%d", readsize, bytesread);
          }
					
					/*
           NSLog(@"###################################################################");
           NSLog([[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding]);
           NSLog(@"###################################################################");
					 */
           
					
					NSXMLParser *parser = [[[NSXMLParser alloc] initWithData:_data] retain];
					[parser setDelegate:self];
          [parser setShouldProcessNamespaces:NO];
          [parser setShouldReportNamespacePrefixes:NO];

					BOOL ok = [parser parse];
					
          if( !ok && debug ) {
            NSLog(@"parser error in data detected...");
            NSString* xml = [[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding];
            NSLog(@"\n%@", xml);
            [xml release];
          }
					
					//NSLog(@"Data sent to parser ... ");
          [header release];
          header = nil;

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
	
		//NSLog(@"parsing : %d : element: %@ ", parsingPlan, elementName);
	
	if ([elementName isEqualToString:@"xmlh"]) {
		//NSLog(@"parser: xmlh");
	} else if ([elementName isEqualToString:@"xml"]) {
		//NSLog(@"parser: xml");		
		NSString *relAttribute = [attributeDict valueForKey:@"size"];		
		readsize = [relAttribute intValue];
	} else if ([elementName isEqualToString:@"plan"]) {
		NSLog(@"start parsing plan...");
    parsingPlan = TRUE;
    [model setupWithAttributeDict:attributeDict];
	} else if ([elementName isEqualToString:@"zlevel"]) {
    if( parsingPlan ) {
      NSLog(@"create zlevel...");
      ZLevel *zlevel = [[[ZLevel alloc] initWithAttributeDict:attributeDict] retain];
      NSLog(@"add zlevel to container...");
      [model.levelContainer addObject:zlevel withId:zlevel.zlevel];
    }  
	} else if ([elementName isEqualToString:kLocElementName]) {
    if( parsingPlan ) {
      if( ![[attributeDict valueForKey:@"show"] isEqualToString:@"false"] ) {
        Loc *loc = [[[Loc alloc] initWithAttributeDict:attributeDict] retain];
        [loc setDelegate:_delegate];
        [model.lcContainer addObject:loc withId:loc.locid];
      }
      //else {
        //NSLog(@"parser: skipping invisible loco");		
      //}
    }
    else {
	    NSLog(@"loco event parser: lc: %@ - v: %@ - dir: %@", [attributeDict valueForKey:@"id"], [attributeDict valueForKey:@"V"], [attributeDict valueForKey:@"dir"]);
			
			Loc *lc = (Loc*)[model.lcContainer objectWithId:[attributeDict valueForKey:@"id"]];
      [lc updateWithAttributeDict:attributeDict];
			
			
			if ( [_delegate respondsToSelector:@selector(locSetSlider)] ) {
				[_delegate performSelectorOnMainThread : @ selector(locSetSlider) withObject:nil waitUntilDone:NO];
			} 
			 
			
    }
	} else if ([elementName isEqualToString:@"sw"]) {
    NSString *idAttribute = [attributeDict valueForKey:kIdElementName];
    if( parsingPlan ) {
      NSString *type = [attributeDict valueForKey:@"type"];
	  NSString *state = [attributeDict valueForKey:@"state"];
      //NSLog(@"parser: sw: %@", [attributeDict valueForKey:kIdElementName]);
      
      Switch *sw = [[[Switch alloc] initWithAttributeDict:attributeDict] retain];
      [sw setDelegate:_delegate];
      sw.swid = idAttribute;
      sw.type = type;
	  sw.state = state;
	  [model.swContainer addObject:sw withId:idAttribute];
    }
    else {
	  NSString *state = [attributeDict valueForKey:@"state"];
	  Switch *sw = (Switch*) [model.swContainer objectWithId:idAttribute];		
	  [sw setState:state];
    [sw updateEvent];
		
	  if ( [_delegate respondsToSelector:@selector(swListLoaded)] ) {
			[_delegate performSelectorOnMainThread : @ selector(swListLoaded ) withObject:nil waitUntilDone:NO];
	  } 
		
      NSLog(@"switch event state=%@", state);		
    }
    
	} else if ([elementName isEqualToString:@"tk"]) {
    if( parsingPlan ) {
      Track *tk = [[[Track alloc] initWithAttributeDict:attributeDict] retain];
      [tk setDelegate:_delegate];
      [model.tkContainer addObject:tk withId:tk.Id];
    }
    else {
      NSString *state = [attributeDict valueForKey:@"state"];
      NSLog(@"track event state=%@", state);		
    }
    
	} else if ([elementName isEqualToString:@"fb"]) {
    if( parsingPlan ) {
      Sensor *fb = [[[Sensor alloc] initWithAttributeDict:attributeDict] retain];
      [fb setDelegate:_delegate];
      [model.fbContainer addObject:fb withId:fb.Id];
			
			//NSLog(@" FB: %@ ----- %@ ", fb.Id, elementName);
    }
    else {
      NSString *Id = [attributeDict valueForKey:kIdElementName];
      NSString *state = [attributeDict valueForKey:@"state"];
      NSLog(@"track event state=%@", state);		
      Sensor *fb = (Sensor*) [model.fbContainer objectWithId:Id];		
      [fb setState:state];
      [fb updateEvent];
    }
    
	} else if ([elementName isEqualToString:@"sg"]) {
    NSString *idAttribute = [attributeDict valueForKey:kIdElementName];
    if( parsingPlan ) {
      NSString *type = [attributeDict valueForKey:@"type"];
      NSString *state = [attributeDict valueForKey:@"state"];
        //NSLog(@"parser: sg: %@", [attributeDict valueForKey:kIdElementName]);
      
      Signal *sg = [[[Signal alloc] initWithAttributeDict:attributeDict] retain];
      [sg setDelegate:_delegate];
      sg.ID = idAttribute;
      sg.type = type;
      sg.state = state;
      [model.sgContainer addObject:sg withId:idAttribute];
    }
    else {
      NSString *state = [attributeDict valueForKey:@"state"];
      Signal *sg = (Signal*) [model.sgContainer objectWithId:idAttribute];		
      [sg setState:state];
      [sg updateEvent];

      if ( [_delegate respondsToSelector:@selector(sgListLoaded)] ) {
        [_delegate performSelectorOnMainThread : @ selector(sgListLoaded ) withObject:nil waitUntilDone:NO];
      } 
      
      NSLog(@"swignal event state=%@", state);		
    }
    
	} else if ([elementName isEqualToString:@"st"]) {
		NSString *relAttribute = [attributeDict valueForKey:kIdElementName];		
    if( parsingPlan ) {
      Route *rt = [[[Route alloc] init] retain];
      rt.rtid = relAttribute;
      //[self.rtList addObject:rt];
			[model.rtContainer addObject:rt withId:rt.rtid];
    }
    else {
      NSLog(@"route event");		
    }
		
	} else if ([elementName isEqualToString:@"co"]) {
		NSString *idAttribute = [attributeDict valueForKey:kIdElementName];		
    if( parsingPlan ) {
        //NSLog(@"parser: co: %@", [attributeDict valueForKey:kIdElementName]);
      Output *co = [[[Output alloc] initWithAttributeDict:attributeDict] retain];
      [co setDelegate:_delegate];
      co.coid = idAttribute;
	    co.state = [attributeDict valueForKey:@"state"];
        //NSLog(@"Output State: %@", co.state);
      [model.coContainer addObject:co withId:idAttribute];
    } else {
			NSString *state = [attributeDict valueForKey:@"state"];
			Output *co = (Output*) [model.coContainer objectWithId:idAttribute];
      [co updateWithAttributeDict:attributeDict];
			[co setState:state];
      [co updateEvent];
			if ( [_delegate respondsToSelector:@selector(coListLoaded)] ) {
				[_delegate performSelectorOnMainThread : @ selector(coListLoaded ) withObject:nil waitUntilDone:NO];
			} 
      
      NSLog(@"Output [%@] event state=%@", co.coid, state);	
    }
		
	} else if ([elementName isEqualToString:@"bk"]) {
		NSString *idAttribute = [attributeDict valueForKey:kIdElementName];		
    if( parsingPlan ) {
      //NSLog(@"parser: bk: %@", [attributeDict valueForKey:kIdElementName]);
      Block *bk = [[[Block alloc] initWithAttributeDict:attributeDict] retain];
      [bk setDelegate:_delegate];
      bk.ID = idAttribute;
			bk.smallsymbol = [attributeDict valueForKey:@"smallsymbol"];
	    //NSLog(@"Block small symbol: %@", bk.smallsymbol);
	  [model.bkContainer addObject:bk withId:idAttribute];
    } else {
			NSString *state = [attributeDict valueForKey:@"state"];
			Block *bk = (Block*) [model.bkContainer objectWithId:idAttribute];
      [bk updateWithAttributeDict:attributeDict];
        //[bk setState:state];
      [bk updateEvent];
			if ( [_delegate respondsToSelector:@selector(bkListLoaded)] ) {
				[_delegate performSelectorOnMainThread : @ selector(bkListLoaded ) withObject:nil waitUntilDone:NO];
			} 
		
		NSLog(@"Block [%@] event state=%@", bk.ID, state);	
    }
    
	} else if ([elementName isEqualToString:@"tx"]) {
		NSString *idAttribute = [attributeDict valueForKey:kIdElementName];		
    if( parsingPlan ) {
        //NSLog(@"parser: bk: %@", [attributeDict valueForKey:kIdElementName]);
      Text *tx = [[[Text alloc] initWithAttributeDict:attributeDict] retain];
      [tx setDelegate:_delegate];
      [model.txContainer addObject:tx withId:idAttribute];
    } else {
			Text *tx = (Text*) [model.txContainer objectWithId:idAttribute];
      [tx updateWithAttributeDict:attributeDict];
      [tx updateEvent];
    }
    
	} else if ([elementName isEqualToString:@"sc"]) {
		NSString *idAttribute = [attributeDict valueForKey:kIdElementName];		
    if( parsingPlan ) {
        //NSLog(@"parser: sc: %@", [attributeDict valueForKey:kIdElementName]);
      Schedule *sc = [[[Schedule alloc] init] retain];
      sc.ID = idAttribute;
      [model.scContainer addObject:sc withId:idAttribute];
    } else {
      NSLog(@"Schedule [%@] event");	
    }
    
	} else if ([elementName isEqualToString:@"datareq"]) {
		NSString *relAttribute = [attributeDict valueForKey:kIdElementName];
		
		//NSLog(@"connector LOCPIC: %@ ",relAttribute );
    
		NSString *data = [attributeDict valueForKey:@"data"];
    if( [data length] > 0 ) {
      [((Loc*) [model.lcContainer objectWithId:relAttribute]) setLocpicdata:data]; 
    }
		[self nextLocpic:TRUE];
		pendingLocoPic = FALSE;

	}	else if ([elementName isEqualToString:@"sys"]) {
		NSString *relAttribute = [attributeDict valueForKey:@"cmd"];
		if( [relAttribute isEqualToString:@"shutdown"] ) {
			NSLog(@"We should go down now [%@]", relAttribute);
			[self stop]; 
      UIAlertView *alert = [[UIAlertView alloc] 
                            initWithTitle:@"Alert" 
                            message:[NSString stringWithFormat: @"%@:%d is shutingdown; iRoc will exit.",self.domain, self.port] 
                            delegate:self 
                            cancelButtonTitle:nil 
                            otherButtonTitles:@"OK",nil];
      [alert show];
      
			exit(0);
		}
    else {
			
    }
    
	}	else if ([elementName isEqualToString:@"state"]) {
		NSString *relAttribute = [attributeDict valueForKey:@"power"];
    [_delegate performSelectorOnMainThread: @selector(setPower:) withObject:relAttribute waitUntilDone:NO];
  
	}	else if ([elementName isEqualToString:@"auto"]) {
		NSString *relAttribute = [attributeDict valueForKey:@"cmd"];
    [_delegate performSelectorOnMainThread: @selector(setAuto:) withObject:relAttribute waitUntilDone:NO];
    
  } else if ([elementName isEqualToString:@"clock"]) {
    NSString *relAttribute = [attributeDict valueForKey:@"time"];		
    NSLog(@"clock [%@]", relAttribute);
  }
  else {
    if( debug )
      NSLog(@"unhandled: [%@]", elementName);
  }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {     

	
	if (parsingPlan && [elementName isEqualToString:@"lclist"]) {
		// inform the delegate
		if ( [_delegate respondsToSelector:@selector(lcListLoaded)] ) {
			//[_delegate lcListLoaded];
      [_delegate performSelectorOnMainThread : @ selector(lcListLoaded ) withObject:nil waitUntilDone:NO];
		} 
		NSLog(@"%d locs added ... ", [model.lcContainer count]);
	} else if (parsingPlan && [elementName isEqualToString:@"stlist"]) {
		// inform the delegate
		if ( [_delegate respondsToSelector:@selector(rtListLoaded)] ) {
      [_delegate performSelectorOnMainThread : @ selector(rtListLoaded ) withObject:nil waitUntilDone:NO];
		} 
		NSLog(@"%d rts added ... ", [model.rtContainer count]);
	} else if (parsingPlan && [elementName isEqualToString:@"swlist"]) {
		// inform the delegate
		if ( [_delegate respondsToSelector:@selector(swListLoaded)] ) {
      [_delegate performSelectorOnMainThread : @ selector(swListLoaded ) withObject:nil waitUntilDone:NO];
		} 
		NSLog(@"%d sws added ... ", [model.swContainer count]);
	} else if (parsingPlan && [elementName isEqualToString:@"sglist"]) {
      // inform the delegate
		if ( [_delegate respondsToSelector:@selector(sgListLoaded)] ) {
      [_delegate performSelectorOnMainThread : @ selector(sgListLoaded ) withObject:nil waitUntilDone:NO];
		} 
		NSLog(@"%d sgs added ... ", [model.sgContainer count]);
	} else if ( parsingPlan && [elementName isEqualToString:@"colist"]) {
		// inform the delegate
		if ( [_delegate respondsToSelector:@selector(coListLoaded)] ) {
      [_delegate performSelectorOnMainThread : @ selector(coListLoaded ) withObject:nil waitUntilDone:NO];
		} 
		NSLog(@"%d cos added ... ", [model.coContainer count]);
	} else if ( parsingPlan && [elementName isEqualToString:@"bklist"]) {
      // inform the delegate
		if ( [_delegate respondsToSelector:@selector(bkListLoaded)] ) {
      [_delegate performSelectorOnMainThread : @ selector(bkListLoaded ) withObject:nil waitUntilDone:NO];
		} 
		NSLog(@"%d bks added ... ", [model.bkContainer count]);
	} else if ( parsingPlan && [elementName isEqualToString:@"sclist"]) {
      // inform the delegate
		if ( [_delegate respondsToSelector:@selector(scListLoaded)] ) {
      [_delegate performSelectorOnMainThread : @ selector(scListLoaded ) withObject:nil waitUntilDone:NO];
		} 
		NSLog(@"%d scs added ... ", [model.scContainer count]);
	} else if ([elementName isEqualToString:@"plan"]) {
		// inform the delegate
    NSLog(@"Plan is processed.");
    parsingPlan = FALSE;

		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
		
		// TEST
    
		if ( [_delegate respondsToSelector:@selector(askForAllLocPics)] ) {
			//[_delegate askForAllLocPics];
      [_delegate performSelectorOnMainThread : @ selector(askForAllLocPics) withObject:nil waitUntilDone:NO];
		} 
    

	} else if ([elementName isEqualToString:@"datareq"]) {
		// inform the delegate
		//NSLog(@"end datareq");
	} else if ([elementName isEqualToString:@"clock"]) {
		// inform the delegate
		NSLog(@"Clock tick.");
	}
	
	
	
}

// This method is called by the parser when it find parsed character data ("PCDATA") in an element. The parser is not
// guaranteed to deliver all of the parsed character data for an element in a single invocation, so it is necessary to
// accumulate character data until the end of the element is reached.
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
  //NSLog(@"PCDATA:\n%@", string);
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	// TODO: somthing is wrong with the parser
	// start from the beginning ....	
  if( debug ) {
    NSLog(@"### Parse Error: %@ ", [parseError localizedDescription]);
	  if( header != nil )
	    NSLog(@"Header:\n%@", header);
    /*
	  if( _data != nil ) {
      NSString* xml = [[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding];
	    NSLog(@"Data:\n%@", xml);
      [xml release];
    }
    */
  }	
}


- (id)delegate
{
  return _delegate;
}

- (void)setDelegate:(id)new_delegate withModel:(Model *)_model
{
  _delegate = new_delegate;
  model = _model;
}


@end

