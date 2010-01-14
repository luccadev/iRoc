//
//  Model.h
//  iRoc
//
//  Created by Rocrail on 14.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Container.h"


@interface Model : NSObject {
	Container *levelContainer;

}
@property(nonatomic, retain) Container *levelContainer;

@end
