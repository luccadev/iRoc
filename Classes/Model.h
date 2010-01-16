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
#import "Text.h"


@interface Model : NSObject {
  NSString *title;
  NSString *name;
  NSString *rocrailversion;
  NSString *rocguiversion;
  
	Container *levelContainer;
	Container *swContainer;
	Container *sgContainer;
	Container *tkContainer;
	Container *fbContainer;
	Container *bkContainer;
	Container *coContainer;
	Container *txContainer;

}
@property(nonatomic, retain) Container *levelContainer, *swContainer, *sgContainer, *tkContainer, 
    *fbContainer, *bkContainer, *coContainer, *txContainer;
@property(nonatomic, retain) NSString *title, *name, *rocguiversion, *rocrailversion;

- (void) setupWithAttributeDict: (NSDictionary *)attributeDict;


@end
