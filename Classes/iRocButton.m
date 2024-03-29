/*
 Rocrail - Model Railroad Software
 
 Copyright (C) 2009-2010 - Rob Versluis <r.j.versluis@rocrail.net>, Jean-Michel Fischer <jmf@polygonpunkt.de>
 
 This program is free software; you can redistribute it and/or
 modify it under the terms of the GNU General Public License
 as published by the Free Software Foundation; either version 2
 of the License, or (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 */

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
	hasLED = FALSE;
	
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
		[self setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
	
		began = 0;
		moved = 1;
		ended = 2;
      
      color = 0;
      touchState = ended;
    }
	
    return self;
}

- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
	BOOL enabled = [super isEnabled];
	context = UIGraphicsGetCurrentContext();
  
  
	if( false ) { // new Design
		//float clrdepth = touchState == began ?.9:.6;
		float graydepth = touchState == began ?.3:.3; // TODO: Seems always to be "began" for the loco controller buttons...
		
		
		//border
		CGContextSetRGBFillColor(context,  .3, .3, .3, 1);
		CGContextAddRoundedRectA(context, CGRectMake(0, 0, CGRectGetWidth(rect), CGRectGetHeight( rect)), 5);  
		CGContextFillPath(context);
		
		CGContextSetRGBFillColor(context,  .1, .1, .1, 1);
		CGContextAddRoundedRectA(context, CGRectMake(2, 2, CGRectGetWidth(rect)-4, CGRectGetHeight( rect)-4), 5);  
		CGContextFillPath(context);
		
		/*
		if( bState) {
			CGContextSetRGBFillColor(context, 1, 0.7, 0.1, 1);
			CGContextAddRoundedRectA(context, CGRectMake(2, 2, CGRectGetWidth(rect)-4, CGRectGetHeight( rect)-4), 5);  
			CGContextFillPath(context);
		} else {
			if (hasLED) {
				CGContextSetRGBFillColor(context, 1, 0.7, 0.1, 0.1);
				CGContextAddRoundedRectA(context, CGRectMake(2, 2, CGRectGetWidth(rect)-4, CGRectGetHeight( rect)-4), 5);  
				CGContextFillPath(context);
			}
		}*/
		
		if (hasLED) {
			float alpha = bState == TRUE ?.7:0;
			// red
			if( color == 1 )
				CGContextSetRGBFillColor(context, .9, .1, .1, alpha);
			// green
			else if( color == 2 )
				CGContextSetRGBFillColor(context, .3, .9, .3, alpha);
			// blue
			else if( color == 3 )
				CGContextSetRGBFillColor(context, .4, .4, .8, alpha);
			else
				CGContextSetRGBFillColor(context, 1, 0.7, 0.1, alpha);
			
			//CGContextAddEllipseInRect(context, CGRectMake(5,5,9,9));
			//CGContextFillPath(context);
		
			
			CGContextAddRoundedRectA(context, CGRectMake(4, 4, CGRectGetWidth(rect)-8, CGRectGetHeight( rect)-8), 5);  
			CGContextFillPath(context);
		}
		
		

		if( !enabled ) {
			graydepth = touchState == began ?.2:.6; // TODO: Seems always to be "began" for the loco controller buttons...
			CGContextSetRGBFillColor(context, graydepth, graydepth, graydepth, 1);
		}
    // red
		/*else if( color == 1 )
			CGContextSetRGBFillColor(context, clrdepth, .3, .3, 1);
    // green
		else if( color == 2 )
			CGContextSetRGBFillColor(context, .3, clrdepth, .3, 1);
    // default
		else if( color == 3 )
			CGContextSetRGBFillColor(context, .3, .3, clrdepth, 1);
    // default
		else */
		
		/*
		CGContextSetRGBFillColor(context, graydepth, graydepth, graydepth, 1);
		CGContextAddRoundedRectA(context, CGRectMake(4, 4, CGRectGetWidth(rect)-8, CGRectGetHeight( rect)-8), 5);  
		CGContextFillPath(context);
		*/
				
			
	} else {  // old Design
		//float clrdepth = touchState == began ?.9:.6;
		float graydepth = touchState == began ?.6:.3; // TODO: Seems always to be "began" for the loco controller buttons...
		if( !enabled ) {
			graydepth = touchState == began ?.2:.2; // TODO: Seems always to be "began" for the loco controller buttons...
			CGContextSetRGBFillColor(context, graydepth, graydepth, graydepth, 1);
		} /*
    // red
  else if( color == 1 )
	  CGContextSetRGBFillColor(context, clrdepth, .3, .3, 1);
    // green
  else if( color == 2 )
	  CGContextSetRGBFillColor(context, .3, clrdepth, .3, 1);
    // default
  else if( color == 3 )
	  CGContextSetRGBFillColor(context, .3, .3, clrdepth, 1);
    // default
  else */
    CGContextSetRGBFillColor(context, graydepth, graydepth, graydepth, 1);
  
  
	CGContextAddRoundedRectA(context, CGRectMake(0,0, CGRectGetWidth(rect), CGRectGetHeight( rect)), 5);  
	CGContextFillPath(context);

	//border
	CGContextSetLineWidth(context, .5);
	CGContextSetRGBStrokeColor(context, .5, .5, .5, 1);
	CGContextAddRoundedRectA(context, CGRectMake(0,0, CGRectGetWidth(rect), CGRectGetHeight( rect)), 5);  
	CGContextStrokePath(context);  
	
	if (hasLED) {
		//if( bState) {
			float alpha = bState == TRUE ?1:.1;
		
		CGContextSetRGBFillColor(context, .1, .1, .1, 1);
		CGContextAddEllipseInRect(context, CGRectMake(4,4,9,9));
		CGContextFillPath(context);
		
		
			// red
			if( color == 1 )
				CGContextSetRGBFillColor(context, .8, .1, .1, alpha);
			// green
			else if( color == 2 )
				CGContextSetRGBFillColor(context, .3, .6, .3, alpha);
			// blue
			else if( color == 3 )
				CGContextSetRGBFillColor(context, .1, .1, .6, alpha);
			else
				CGContextSetRGBFillColor(context, 1, 0.7, 0.1, alpha-.05);
			
			CGContextAddEllipseInRect(context, CGRectMake(5,5,8,8));
			CGContextFillPath(context);
			
			// red
			if( color == 1 )
				CGContextSetRGBFillColor(context, 1, .1, .1, alpha);
			// green
			else if( color == 2 )
				CGContextSetRGBFillColor(context, .3, .9, .3, alpha);
			// blue
			else if( color == 3 )
				CGContextSetRGBFillColor(context, .1, .1, .9, alpha);
			else
				CGContextSetRGBFillColor(context, 1, .7, .1, alpha-.05);
			
			CGContextAddEllipseInRect(context, CGRectMake(7,7,5,5));
			CGContextFillPath(context);
			
			CGContextSetRGBFillColor(context, 1, 1, 1, alpha);
			CGContextAddEllipseInRect(context, CGRectMake(7,7,2,1));
			CGContextFillPath(context);
			
		/*} else {
			
			// red
			if( color == 1 )
				CGContextSetRGBFillColor(context, .6, .3, .3, 1);
			// green
			else if( color == 2 )
				CGContextSetRGBFillColor(context, .3, .6, .3, 1);
			// blue
			else if( color == 3 )
				CGContextSetRGBFillColor(context, .3, .3, .6, 1);
			else
				CGContextSetRGBFillColor(context, 1, 0.7, 0.1, 0.5);
			
			CGContextAddEllipseInRect(context, CGRectMake(5,5,7,7));
			CGContextFillPath(context);
			
			// red
			if( color == 1 )
				CGContextSetRGBFillColor(context, .9, .3, .3, 1);
			// green
			else if( color == 2 )
				CGContextSetRGBFillColor(context, .3, .9, .3, 1);
			// blue
			else if( color == 3 )
				CGContextSetRGBFillColor(context, .3, .3, .9, 1);
			else
				CGContextSetRGBFillColor(context, 1, 0.7, 0.1, 1);
			
			CGContextAddEllipseInRect(context, CGRectMake(6,6,5,5));
			CGContextFillPath(context);
			
			CGContextSetRGBFillColor(context, 1, 1, 1, 1);
			CGContextAddEllipseInRect(context, CGRectMake(7,7,1,1));
			CGContextFillPath(context);
		}*/
	}

	}  // new/old Design
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
	touchState = ended;
	[self setNeedsDisplay];
}

- (void) setBState:(BOOL)staten {
	bState = staten;
	[self setNeedsDisplay];
}

- (void) setLED {
	hasLED = TRUE;
}

- (void) setColor:(int)clr {
	color = clr;
	[self setNeedsDisplay];
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
