//
//  iRocTouchView.m
//  iRoc
//
//  Created by Jean-Michel Fischer on 19.11.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "iRocTouchView.h"


@implementation iRocTouchView

- (void)setPathToRoundedRect:(CGRect)rect forInset:(NSUInteger)inset inContext:(CGContextRef)context
{
	// Experimentally determined
	static NSUInteger cornerRadius = 10;
	
	// Unpack size for compactness, find minimum dimension
	CGFloat w = rect.size.width;
	CGFloat h = rect.size.height;
	CGFloat m = w<h?w:h;
	
	// Bounds
	CGFloat b = rect.origin.y;
	CGFloat t = b + h;
	CGFloat l = rect.origin.x;
	CGFloat r = l + w;
	CGFloat d = (inset<cornerRadius)?(cornerRadius-inset):0;
	
	// Special case: Degenerate rectangles abort this method
	if (m <= 0) return;
	
	// Limit radius to 1/2 of the rectangle's shortest axis
	d = (d>0.5*m)?(0.5*m):d;
	
	// Define a CW path in the CG co-ordinate system (origin at LL)
	CGContextBeginPath(context);
	CGContextMoveToPoint(context, (l+r)/2, t);		// Begin at TDC
	CGContextAddArcToPoint(context, r, t, r, b, d);	// UR corner
	CGContextAddArcToPoint(context, r, b, l, b, d);	// LR corner
	CGContextAddArcToPoint(context, l, b, l, t, d);	// LL corner
	CGContextAddArcToPoint(context, l, t, r, t, d);	// UL corner
	CGContextClosePath(context);					// End at TDC
}


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
       
		x = 0;
		y = 0;
		
	}
    return self;
}


- (void)drawRect:(CGRect)rect {
	
	 // Drawing code
	CGContextRef context = UIGraphicsGetCurrentContext(); 	
	[super drawRect:rect];
	
	
	if(x < 20)
		x = 20;
	
	if(x >260)
		x = 260;
	
	
	// Bar
	CGContextSetRGBFillColor(context, 0.8, 0.8, 0.8, 1); 
	rectVel = CGRectMake(0, 20, x, 80);
	CGContextFillRect(context, rectVel);
	
	//Knob
	CGContextSetRGBFillColor(context, 0.4, 0.4, 0.4, 1); 
	rectVel = CGRectMake(x-20, 10, 40, 100);
	CGContextFillRect(context, rectVel);
	
	}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	// We only support single touches, so anyObject retrieves just that touch from touches
	UITouch *touch = [touches anyObject];

	x = [touch locationInView:self].x;
	y = [touch locationInView:self].y;
	
	//NSLog(@"iRocTouchView(%d).touchesBegan: (%d, %d)", self, x, y);
	
	[self setNeedsDisplay];
	[self sendActionsForControlEvents:UIControlEventValueChanged];
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	
	UITouch *touch = [touches anyObject];
	
	x = [touch locationInView:self].x;
	y = [touch locationInView:self].y;
	
	NSLog(@"iRocTouchView(%d).touchesMoved: (%d, %d)", self, x, y);

	
	[self setNeedsDisplay];
	[self sendActionsForControlEvents:UIControlEventValueChanged];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	
	UITouch *touch = [touches anyObject];

	x = [touch locationInView:self].x;
	y = [touch locationInView:self].y;
	
	//NSLog(@"iRocTouchView(%d).touchesEnded: (%d, %d)", self, x, y);
	
	[self setNeedsDisplay];
	[self sendActionsForControlEvents:UIControlEventValueChanged];
}


- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {

}

- (float)value {
	
	if(x < 0)
		x=0;
	
	if( x>260 )
		x=260;
	
	
	return (x/260.00);
}

- (void)dealloc {
    [super dealloc];
}


@end
