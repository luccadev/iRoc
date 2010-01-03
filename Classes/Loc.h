//
//  Loc.h
//  iRoc
//
//  Created by Jean-Michel Fischer on 07.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Loc : NSObject {
@private 
	NSString *locpicdata;
	NSString *imgname;
	NSString *desc;
	NSString *roadname;
	NSString *dir;
	NSString *vstr;
	int vint;
	
	NSString *vmaxstr;
	int vmax;
	BOOL fnStates[32];

	UIImage *lcimage;
	UITableViewCell *cell;
  
	BOOL hasImage;
	BOOL imageLoaded;
  BOOL imageAlreadyRequested;

@public
  id _delegate;
	NSString *locid;

}

@property (nonatomic, retain) NSString *locid;
//@property (nonatomic, retain) NSString *locpicdata;
@property (nonatomic, retain) NSString *imgname;
@property (nonatomic, retain) NSString *desc;
@property (nonatomic, retain) NSString *roadname;
@property (nonatomic, retain) NSString *dir;
@property (nonatomic, retain) NSString *vstr;
@property (nonatomic, retain) NSString *vmaxstr;
@property (nonatomic, retain) UIImage *lcimage;
@property (nonatomic, retain) UITableViewCell *cell;
@property BOOL hasImage;
@property BOOL imageLoaded;
@property BOOL imageAlreadyRequested;

- (void)setDelegate:(id)new_delegate;
- (void) prepareImage;
- (UIImage*) getImage;
- (int) getVint;
- (void) setLocpicdata:(NSString *) picdata;
- (int) getVmax;
- (BOOL)isFn:(int)fn;
- (void)setFn:(int)fn withState:(BOOL)state;

@end
