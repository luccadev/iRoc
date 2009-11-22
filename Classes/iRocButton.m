//
//  iRocButton.m
//  iRoc
//
//  Created by Jean-Michel Fischer on 21.11.09.
//  Copyright 2009 rocrail.net . All rights reserved.
//

#import "iRocButton.h"

@implementation iRocButton

//@synthesize state;

- (id)initWithFrame:(CGRect)frame {
	touchState = ended;
	bState = false;
	
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		
    }
	
    return self;
}

- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
    context = UIGraphicsGetCurrentContext();
	
	//touchState = ended;
 	/*
	if( touchState == began){
		CGContextSetRGBFillColor(context, .5, .5, .5, 1);
	} else {
		CGContextSetRGBFillColor(context, .3, .3, .3, 1);
	} */
	CGContextSetRGBFillColor(context, .3, .3, .3, 1);
	
	
	CGContextAddRoundedRect(context, CGRectMake(0,0, CGRectGetWidth(rect), CGRectGetHeight( rect)), 5);  
	CGContextFillPath(context);

	
	//border
	CGContextSetLineWidth(context, .5);
	CGContextSetRGBStrokeColor(context, .5, .5, .5, 1);
	CGContextAddRoundedRect(context, CGRectMake(0,0, CGRectGetWidth(rect), CGRectGetHeight( rect)), 5);  
	CGContextStrokePath(context);  
	
	if( bState) {
		CGContextSetRGBFillColor(context, 1, 0.7, 0.1, 1);
		CGContextAddEllipseInRect(context, CGRectMake(5,5,5,5));
		CGContextFillPath(context);
	} 
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
	//NSLog(@"Touches Ended");
	touchState = ended;
	[self setNeedsDisplay];
}

- (void) setBState:(id)staten {
	bState = staten;
	[self setNeedsDisplay];
	
	NSLog(@"bstate: %d", bState);
}

- (void)dealloc {
    [super dealloc];
}

@end
