//
//  iRocTouchView.m
//  iRoc
//
//  Created by Jean-Michel Fischer on 19.11.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "iRocTouchView.h"


@implementation iRocTouchView

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
