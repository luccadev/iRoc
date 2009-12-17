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
	NSString *locid;
	NSString *locpicdata;
	NSString *imgname;
	NSString *desc;
	
	
	UIImage *lcimage;
	
	BOOL hasImage;
	BOOL imageLoaded;
  BOOL imageAlreadyRequested;
}

@property (nonatomic, retain) NSString *locid;
//@property (nonatomic, retain) NSString *locpicdata;
@property (nonatomic, retain) NSString *imgname;
@property (nonatomic, retain) NSString *desc;
@property (nonatomic, retain) UIImage *lcimage;
@property BOOL hasImage;
@property BOOL imageLoaded;
@property BOOL imageAlreadyRequested;

- (void) prepareImage;
- (UIImage*) getImage;
- (void) setLocpicdata:(NSString *) picdata;

@end
