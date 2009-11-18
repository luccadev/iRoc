//
//  LenientUISlider.h
//  iRoc
//
//  Created by Jean-Michel Fischer on 18.11.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LenientUISlider : UISlider {
    
@private
    CGRect lastBounds;
}

@end