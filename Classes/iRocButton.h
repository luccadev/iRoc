//
//  iRocButton.h
//  iRoc
//
//  Created by Jean-Michel Fischer on 21.11.09.
//  Copyright 2009 rocrail.net . All rights reserved.
//

#import <UIKit/UIKit.h>

@class iRocButton;

@interface iRocButton : UIButton {
	CGContextRef context;
	int began, moved, ended;
	int touchState;
	
	BOOL bState;
  int color; // 0 = default, 1 = red, 2 = green, 3 = blue
}

- (void) setColor:(int) clr;
- (void) setBState:(BOOL) staten;
- (BOOL) getBState;
- (void) flipBState;

//@property (nonatomic) BOOL state; 

@end
