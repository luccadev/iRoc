//
//  iRocTouchView.m
//  iRoc
//
//  Created by Jean-Michel Fischer on 19.11.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "iRocTouchView.h"
#import "round.h"

@implementation iRocTouchView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
       
		x = 0;
		y = 0;
		
	}
    return self;
}
/*
void CGContextAddRoundedRect (CGContextRef c, CGRect rect, int corner_radius) {
	int x_left = rect.origin.x;
	int x_left_center = rect.origin.x + corner_radius;
	int x_right_center = rect.origin.x + rect.size.width - corner_radius;
	int x_right = rect.origin.x + rect.size.width;
	int y_top = rect.origin.y;
	int y_top_center = rect.origin.y + corner_radius;
	int y_bottom_center = rect.origin.y + rect.size.height - corner_radius;
	int y_bottom = rect.origin.y + rect.size.height;
	
	// Begin
	CGContextBeginPath(c);
	CGContextMoveToPoint(c, x_left, y_top_center);
	
	// First corner
	CGContextAddArcToPoint(c, x_left, y_top, x_left_center, y_top, corner_radius);
	CGContextAddLineToPoint(c, x_right_center, y_top);
	
	// Second corner 
	CGContextAddArcToPoint(c, x_right, y_top, x_right, y_top_center, corner_radius);
	CGContextAddLineToPoint(c, x_right, y_bottom_center);
	
	// Third corner 
	CGContextAddArcToPoint(c, x_right, y_bottom, x_right_center, y_bottom, corner_radius);
	CGContextAddLineToPoint(c, x_left_center, y_bottom);
	
	// Fourth corner 
	CGContextAddArcToPoint(c, x_left, y_bottom, x_left, y_bottom_center, corner_radius);
	CGContextAddLineToPoint(c, x_left, y_top_center);
	
	// Done 
	CGContextClosePath(c);
} */
- (void)drawRect:(CGRect)rect {
	
	 // Drawing code
	CGContextRef context = UIGraphicsGetCurrentContext(); 	
	[super drawRect:rect];
	
	
	if(x < 21)
		x = 21;
	
	if(x >258)
		x = 258;
	
	// Bar
	CGContextSetRGBFillColor(context, .1, .1, .1, 1); 
	rectVel = CGRectMake(9, 54, 262, 12);
	CGContextFillRect(context, rectVel);
	CGContextSetRGBFillColor(context, .2, .2, .2, 1); 
	rectVel = CGRectMake(10, 55, 260, 10);
	CGContextFillRect(context, rectVel);
	
	//Knob
	CGContextSetRGBFillColor(context, .3, .3, .3, 1);  
	CGContextAddRoundedRect(context, CGRectMake(x-20,10,40,100), 5);  
	CGContextFillPath(context);  
	
	//Knob border
	CGContextSetLineWidth(context, 0.5);  
	CGContextSetRGBStrokeColor(context, .5, .5, .5, 1);  
	CGContextAddRoundedRect(context, CGRectMake(x-20,10,40,100), 5);  
	CGContextStrokePath(context);  
	
	//Knob lines
	CGContextSetRGBFillColor(context, .2, .2, .2, 1); 
	CGContextFillRect(context, CGRectMake(x-11,15,1,90));
	CGContextFillRect(context, CGRectMake(x-1,15,1,90));
	CGContextFillRect(context, CGRectMake(x+9,15,1,90));
	CGContextSetRGBFillColor(context, .4, .4, .4, 1); 
	CGContextFillRect(context, CGRectMake(x-10,15,1,90));
	CGContextFillRect(context, CGRectMake(x,15,1,90));
	CGContextFillRect(context, CGRectMake(x+10,15,1,90));

	
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
