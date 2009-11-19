//
//  iRocTouchView.h
//  iRoc
//
//  Created by Jean-Michel Fischer on 19.11.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface iRocTouchView : UIControl {
	int x, y;
	CGRect rectVel;
}

void CGContextAddRoundedRect (CGContextRef c, CGRect rect, int corner_radius);
- (float)value;

@end


