//
//  iRocTouchView.m
//  iRoc
//
//  Created by Jean-Michel Fischer on 19.11.09.
//  Copyright 2009 rocrail.net . All rights reserved.
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

- (void)drawRect:(CGRect)rect {
	
	 // Drawing code
	CGContextRef context = UIGraphicsGetCurrentContext(); 	
	[super drawRect:rect];
	
	float maxval = 278.00; 
	
	if(x < 41)
		x=41;
	
	if( x>maxval)
		x=maxval;

	int off = 0;
	
	// Bar
	CGContextSetRGBFillColor(context, .1, .1, .1, 1); 
	rectVel = CGRectMake(29, 54, 262, 12);
	CGContextFillRect(context, rectVel);
	CGContextSetRGBFillColor(context, .2, .2, .2, 1); 
	rectVel = CGRectMake(30, 55, 260, 10);
	CGContextFillRect(context, rectVel);
	
	//Knob
	CGContextSetRGBFillColor(context, .3, .3, .3, 1);  
	CGContextAddRoundedRect(context, CGRectMake(x-20+off,10,40,100), 5);  
	CGContextFillPath(context);  
	
	//Knob border
	CGContextSetLineWidth(context, 0.5);  
	CGContextSetRGBStrokeColor(context, .5, .5, .5, 1);  
	CGContextAddRoundedRect(context, CGRectMake(x-20+off,10,40,100), 5);  
	CGContextStrokePath(context);  
	
	//Knob lines
	CGContextSetRGBFillColor(context, .2, .2, .2, 1); 
	CGContextFillRect(context, CGRectMake(x-11+off,15,1,90));
	CGContextFillRect(context, CGRectMake(x-1+off,15,1,90));
	CGContextFillRect(context, CGRectMake(x+9+off,15,1,90));
	CGContextSetRGBFillColor(context, .4, .4, .4, 1); 
	CGContextFillRect(context, CGRectMake(x-10+off,15,1,90));
	CGContextFillRect(context, CGRectMake(x+off,15,1,90));
	CGContextFillRect(context, CGRectMake(x+10+off,15,1,90));

	
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	
	// We only support single touches, so anyObject retrieves just that touch from touches
	UITouch *touch = [touches anyObject];
	x = [touch locationInView:self].x;
	y = [touch locationInView:self].y;
	
	//NSLog(@"iRocTouchView(%d).touchesBegan: (%d, %d)", self, x, y);
	
	[self setNeedsDisplay];
	//[self sendActionsForControlEvents:UIControlEventValueChanged];
	 
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	
	
	UITouch *touch = [touches anyObject];
	x = [touch locationInView:self].x;
	y = [touch locationInView:self].y;
	//NSLog(@"iRocTouchView(%d).touchesMoved: (%d, %d)", self, x, y);

	[self setNeedsDisplay];
  
  // read preferences
	defaults = [[NSUserDefaults standardUserDefaults] retain];

  // Optional move event.
  if( [defaults boolForKey:@"moveevents_preference"])
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
	
	int shiftval = 30;
	float maxval = 260.00 - shiftval;
	int xout = x - shiftval;
		
	if(xout < 0)
		xout=0;
	
	if( xout>maxval)
		xout=maxval;

	//NSLog(@"iRocTouchView().value: (%d  ...  %f)", xout, (xout)/maxval);
	
	return (xout/maxval);
}

- (void)setValue:(int) val{
	x = val;
	[self setNeedsDisplay];
}

- (void)dealloc {
    [super dealloc];
}


@end
