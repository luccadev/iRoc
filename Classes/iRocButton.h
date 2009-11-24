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
}

- (void) setBState:(BOOL) staten;

//@property (nonatomic) BOOL state; 

@end
