//
//  iRocTouchView.h
//  iRoc
//
//  Created by Jean-Michel Fischer on 19.11.09.
//  Copyright 2009 rocrail.net . All rights reserved.
//

#import <UIKit/UIKit.h>


@interface iRocTouchView : UIControl {
	int x, y;
	CGRect rectVel;
	NSUserDefaults *defaults;
}

- (float)value;
- (void)setValue:(int) val;

@end


