//
//  Model.h
//  iRoc
//
//  Created by Rocrail on 14.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Container.h"
#import "Track.h"
#import "Sensor.h"


@interface Model : NSObject {
	Container *levelContainer;
	Container *swContainer;
	Container *sgContainer;
	Container *tkContainer;
	Container *fbContainer;

}
@property(nonatomic, retain) Container *levelContainer, *swContainer, *sgContainer, *tkContainer, *fbContainer;

@end
