//
//  iRocButton.m
//  iRoc
//
//  Created by Jean-Michel Fischer on 21.11.09.
//  Copyright 2009 rocrail.net . All rights reserved.
//

#import "iRocButton.h"

@implementation iRocButton

void CGContextAddRoundedRectA(CGContextRef c, CGRect rect, int corner_radius) {
	int x_left = rect.origin.x;
	int x_left_center = rect.origin.x + corner_radius;
	int x_right_center = rect.origin.x + rect.size.width - corner_radius;
	int x_right = rect.origin.x + rect.size.width;
	int y_top = rect.origin.y;
	int y_top_center = rect.origin.y + corner_radius;
	int y_bottom_center = rect.origin.y + rect.size.height - corner_radius;
	int y_bottom = rect.origin.y + rect.size.height;
	
	/* Begin! */
	CGContextBeginPath(c);
	CGContextMoveToPoint(c, x_left, y_top_center);
	
	/* First corner */
	CGContextAddArcToPoint(c, x_left, y_top, x_left_center, y_top, corner_radius);
	CGContextAddLineToPoint(c, x_right_center, y_top);
	
	/* Second corner */
	CGContextAddArcToPoint(c, x_right, y_top, x_right, y_top_center, corner_radius);
	CGContextAddLineToPoint(c, x_right, y_bottom_center);
	
	/* Third corner */
	CGContextAddArcToPoint(c, x_right, y_bottom, x_right_center, y_bottom, corner_radius);
	CGContextAddLineToPoint(c, x_left_center, y_bottom);
	
	/* Fourth corner */
	CGContextAddArcToPoint(c, x_left, y_bottom, x_left, y_bottom_center, corner_radius);
	CGContextAddLineToPoint(c, x_left, y_top_center);
	
	/* Done */
	CGContextClosePath(c);
}

- (id)initWithFrame:(CGRect)frame {
	bState = FALSE;
	
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		
		began = 0;
		moved = 1;
		ended = 2;
      
      color = 0;
      touchState = ended;
		
		NSLog(@"iRocButton:initWithFrame");
    }
	
    return self;
}

- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
    context = UIGraphicsGetCurrentContext();

  float clrdepth = touchState == began ?.9:.6;
  float graydepth = touchState == began ?.3:.3; // TODO: Seems always to be "began" for the loco controller buttons...
    // red
  if( color == 1 )
	  CGContextSetRGBFillColor(context, clrdepth, .3, .3, 1);
    // green
  else if( color == 2 )
	  CGContextSetRGBFillColor(context, .3, clrdepth, .3, 1);
    // default
  else if( color == 3 )
	  CGContextSetRGBFillColor(context, .3, .3, clrdepth, 1);
    // default
  else
    CGContextSetRGBFillColor(context, graydepth, graydepth, graydepth, 1);
  
  
	CGContextAddRoundedRectA(context, CGRectMake(0,0, CGRectGetWidth(rect), CGRectGetHeight( rect)), 5);  
	CGContextFillPath(context);

	//border
	CGContextSetLineWidth(context, .5);
	CGContextSetRGBStrokeColor(context, .5, .5, .5, 1);
	CGContextAddRoundedRectA(context, CGRectMake(0,0, CGRectGetWidth(rect), CGRectGetHeight( rect)), 5);  
	CGContextStrokePath(context);  
	
	if( bState) {
		CGContextSetRGBFillColor(context, 1, 0.7, 0.1, 1);
		CGContextAddEllipseInRect(context, CGRectMake(5,5,5,5));
		CGContextFillPath(context);
	} 
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[super touchesBegan:touches withEvent:event];
	//NSLog(@"Touches Began");
	touchState = began;
	[self setNeedsDisplay];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	[super touchesMoved:touches withEvent:event];
	//NSLog(@"Touches Moved");
	//touchState = moved;
	//[self setNeedsDisplay];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	[super touchesEnded:touches withEvent:event];
	//NSLog(@"Touches Ended");
	touchState = ended;
	
	//[self flipBState];
	
	[self setNeedsDisplay];
}

- (void) setBState:(BOOL)staten {
	bState = staten;
	[self setNeedsDisplay];
	
	//NSLog(@"bstate: %d", bState);
}

- (void) setColor:(int)clr {
	color = clr;
}

- (BOOL) getBState {
	return bState;
}

- (void) flipBState {
	bState = !bState;
	[self setNeedsDisplay];
}

- (void)dealloc {
    [super dealloc];
}

@end
