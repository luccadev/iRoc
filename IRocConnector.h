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


#import <Foundation/Foundation.h>
#import "Model.h"
#import "Loc.h"
#import "Route.h"
#import "Switch.h"
#import "Output.h"
#import "Block.h"
#import "Schedule.h"
#import "Signal.h"

#import "Container.h"


#import "iRocLcTableView.h"
#import "iRocRtTableView.h"
#import "iRocSwTableView.h"

@class Loc;

@interface IRocConnector : NSObject <NSStreamDelegate, NSXMLParserDelegate>{
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
	

	id _delegate;
  Model *model;
}

- (id)delegate;
- (void)setDelegate:(id)new_delegate withModel:(Model*)_model;


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

@property (nonatomic, retain) Loc *currentLocObject;

@end


@interface NSObject (IRocConnector)
 
 - (void)lcListLoaded;
 - (void)rtListLoaded;
 - (void)swListLoaded;
 - (void)coListLoaded;
 - (void)bkListLoaded;
 - (void)scListLoaded;
 - (void)sgListLoaded;
 - (void)askForAllLocPics;

@end


