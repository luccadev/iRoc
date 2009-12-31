//
//  Sender.h
//  iRoc
//
//  Created by Jean-Michel Fischer on 18.11.09.
//  Copyright 2009 rocrail.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Loc.h"
#import "Route.h"
#import "Switch.h"
#import "Output.h"

#import "Container.h"


#import "iRocLcTableView.h"
#import "iRocRtTableView.h"
#import "iRocSwTableView.h"

@class Loc;

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
	BOOL readyConnecting;
	BOOL readRocdata;
	
	BOOL readHeader;
	BOOL debug;
	BOOL pendingLocoPic;
	BOOL parsingPlan;
	BOOL connectionError;
	
	unsigned int readsize;
	int bytesread;
	
	Loc *currentLocObject;
  
  NSMutableArray* messageQueue; 

	@public
	//NSMutableArray *rtList;

	Container *rtContainer;
	Container *swContainer;
	Container *lcContainer;
	Container *coContainer;
	
	id _delegate;
}

- (id)delegate;
- (void)setDelegate:(id)new_delegate;


- (BOOL)sendMessage:(NSString *)name message:(NSString *)msg;

- (NSString *)domain;
- (void)setDomain:(NSString *)value;

- (uint16_t)port;
- (void)setPort:(uint16_t)value;

- (BOOL)connect;
- (BOOL)doConnect;
- (BOOL)stop;
- (void)requestPlan;
- (void)requestLocpic:(NSString*)lcid withFilename:(NSString*)filename;
- (void)nextLocpic:(BOOL)fromSax;

- (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)eventCode;

@property(readwrite) BOOL isConnected;
@property(readwrite) BOOL readyConnecting;

@property(copy) NSString *domain;
@property(nonatomic, retain) NSMutableString *header;
@property(nonatomic, retain) NSMutableString *rocdata;
//@property(nonatomic, retain) NSMutableArray *rtList;

@property(nonatomic, retain) Container *rtContainer;
@property(nonatomic, retain) Container *coContainer;
@property(nonatomic, retain) Container *swContainer;
@property(nonatomic, retain) Container *lcContainer;

@property (nonatomic, retain) Loc *currentLocObject;

@end


@interface NSObject (IRocConnector)
 
 - (void)lcListLoaded;
 - (void)rtListLoaded;
 - (void)swListLoaded;
 - (void)coListLoaded;
 - (void)askForAllLocPics;

@end


