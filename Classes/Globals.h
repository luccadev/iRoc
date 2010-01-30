/*
 *  globals.h
 *  iRoc
 *
 *  Created by Rocrail on 02.01.10.
 *  Copyright 2010 __MyCompanyName__. All rights reserved.
 *
 */
#define BUTTONGAP 8
#define BUTTONHEIGHT 64
#define CONTENTBORDER 8
#define ITEMSIZE 32

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface Globals : NSObject {
}

+ (NSString*)getAttribute:(NSString*)attrName fromDict:(NSDictionary *)attributeDict withDefault:(NSString *)defValue;
+ (SystemSoundID)getClick;
+ (SystemSoundID)getChrr;
+ (NSUserDefaults*)getDefaults;
@end
