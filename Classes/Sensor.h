//
//  Sensor.h
//  iRoc
//
//  Created by Rocrail on 15.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"


@interface Sensor : Item {

}
- (id) initWithAttributeDict: (NSDictionary *)attributeDict;
- (NSString*) getImgName;

@end
