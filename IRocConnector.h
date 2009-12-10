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


#import "iRocLocTableViewController.h"
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
	BOOL readRocdata;
	
	BOOL readHeader;
	
	unsigned int readsize;
	int bytesread;
	
	Loc *currentLocObject;
	
	IBOutlet iRocLocTableViewController *locTableViewController;

	@public
	NSMutableArray *locList;
	NSMutableArray *rtList;
	NSMutableArray *swList;
	NSMutableArray *coList;
	
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
- (BOOL)stop;
- (void)requestPlan;

- (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)eventCode;

@property(readwrite) BOOL isConnected;

@property(copy) NSString *domain;
@property(nonatomic, retain) NSMutableString *header;
@property(nonatomic, retain) NSMutableString *rocdata;
@property(nonatomic, retain) NSMutableArray *locList;
@property(nonatomic, retain) NSMutableArray *rtList;
@property(nonatomic, retain) NSMutableArray *swList;
@property(nonatomic, retain) NSMutableArray *coList;

@property (nonatomic, retain) Loc *currentLocObject;

@property (nonatomic, retain) IBOutlet iRocLocTableViewController *locTableViewController;

@end


@interface NSObject (IRocConnector)
 
 - (void)lcListLoaded;
 - (void)rtListLoaded;
 - (void)swListLoaded;
 - (void)coListLoaded;

@end


