//
//  iRocTouchView.h
//  iRoc
//
//  Created by Jean-Michel Fischer on 19.11.09.
//  Copyright 2009 rocrail.net . All rights reserved.
//

#import <UIKit/UIKit.h>


@interface iRocSlider : UIControl {
	float x, y;
	float ox, oy;
	float cx, cy;
	float qx, qy;
	float maxrange;
	CGRect rectVel;
	NSUserDefaults *defaults;
  
  float maximumValue;
  float minimumValue;
  float value;
}
@property float maximumValue;
@property float minimumValue;

+ (void)CGContextAddRoundedRect:(CGContextRef)c withRect:(CGRect)rect withRadius:(int) corner_radius;


- (void)setValue:(int) Value;
- (int)getValue;

@end


