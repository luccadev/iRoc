//
//  iRocGlobals.m
//  iRoc
//
//  Created by Rocrail on 13.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Globals.h"

@implementation Globals

+ (NSString*)getAttribute:(NSString*)attrName fromDict:(NSDictionary *)attributeDict withDefault:(NSString *)defValue {
  NSString *attrVal = [attributeDict valueForKey:attrName]; 
  return attrVal==nil ? defValue:[[NSString alloc]initWithString: attrVal];
}

static SystemSoundID click = 0;

+ (SystemSoundID)getClick {
  if( click == 0 ) {
    AudioServicesCreateSystemSoundID(CFBundleCopyResourceURL(CFBundleGetMainBundle(), CFSTR("click"), CFSTR("aif"), NULL), &click);
  }
  
  return click;
}


@end
