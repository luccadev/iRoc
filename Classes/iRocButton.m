//
//  iRocButton.m
//  iRoc
//
//  Created by Jean-Michel Fischer on 21.11.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "iRocButton.h"

@implementation iRocButton

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		touchState = ended;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
    context = UIGraphicsGetCurrentContext();
 	
	switch ( touchState) {
		case began:
			CGContextSetRGBFillColor(context, .3, .3, .3, 1);
			break;
		default:
			CGContextSetRGBFillColor(context, .5, .5, .5, 1);
			break;
	}
	CGContextAddRoundedRect(context, CGRectMake(0,0, CGRectGetWidth(rect), CGRectGetHeight( rect)), 5);  
	CGContextFillPath(context);
	
	//border
	CGContextSetLineWidth(context, 0.5);  
	CGContextSetRGBStrokeColor(context, .5, .5, .5, 1);  	
	CGContextAddRoundedRect(context, CGRectMake(0,0, CGRectGetWidth(rect), CGRectGetHeight( rect)), 5);  
	CGContextStrokePath(context);  
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[super touchesBegan:touches withEvent:event];
	NSLog(@"Touches Began");
	touchState = began;
	[self setNeedsDisplay];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	[super touchesMoved:touches withEvent:event];
	NSLog(@"Touches Moved");
	//touchState = moved;
	//[self setNeedsDisplay];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	[super touchesEnded:touches withEvent:event];
	NSLog(@"Touches Ended");
	touchState = ended;
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
	
	
	
	/*
	-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
		BOOL inButton = [theButton pointInside:[self convertPoint:point toView:theButton] withEvent:nil];
		
		if(inButton) {
			UIView *theButtonView = [theButton hitTest:[self convertPoint:point toView:theButton] withEvent:event];
			return theButtonView;
		}
		else {
			return [super hitTest:point withEvent:event];
		}
	 */
	
	return [super hitTest:point withEvent:event];
}


- (void)dealloc {
    [super dealloc];
}

@end
