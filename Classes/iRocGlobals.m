//
//  iRocGlobals.m
//  iRoc
//
//  Created by Rocrail on 13.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "iRocGlobals.h"

@implementation iRocGlobals

+ (NSString*)getAttribute:(NSString*)attrName fromDict:(NSDictionary *)attributeDict withDefault:(NSString *)defValue {
  NSString *attrVal = [attributeDict valueForKey:attrName]; 
  return attrVal==nil ? defValue:[[NSString alloc]initWithString: attrVal];
}


@end
