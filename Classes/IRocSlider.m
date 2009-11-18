//
//  iRocSlider.m
//  iRoc
//
//  Created by Jean-Michel Fischer on 18.11.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "IRocSlider.h"

#define THUMB_SIZE 10
#define EFFECTIVE_THUMB_SIZE 20

@implementation IRocSlider

/*
- (void)drawRect:(CGRect)rect {

CGContextRef myContext = [[NSGraphicsContext currentContext]graphicsPort];
CGContextSetRGBFillColor (myContext, 1, 0, 0, 1);

}*/

- (BOOL) pointInside:(CGPoint)point withEvent:(UIEvent*)event {
	CGRect bounds = self.bounds;
	bounds = CGRectInset(bounds, -10, -8);
	return CGRectContainsPoint(bounds, point);
}

/*
- (CGRect)trackRectForBounds:(CGRect)bounds
{
    return CGRectMake(bounds.origin.x, bounds.origin.y, self.bounds.size.width, 30);
}
 */

/*
- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value {
	

	
}
 */


- (BOOL) beginTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event {
	CGRect bounds = self.bounds;
	float thumbPercent = (self.value - self.minimumValue) / (self.maximumValue - self.minimumValue);
	float thumbPos = THUMB_SIZE + (thumbPercent * (bounds.size.width - (2 * THUMB_SIZE)));
	CGPoint touchPoint = [touch locationInView:self];
	return (touchPoint.x >= (thumbPos - EFFECTIVE_THUMB_SIZE) && touchPoint.x <= (thumbPos + EFFECTIVE_THUMB_SIZE));
}

@end