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

#import "iRocSlider.h"

@implementation iRocSlider
@synthesize maximumValue, minimumValue;

- (id)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
       
	  ox = frame.origin.x;
    oy = frame.origin.y;
    cx = frame.size.width;
    cy = frame.size.height;
      
    qx = cx / 26.0;
    qy = cy / 10.0;
    
    maxrange = qx*22.0; 
    maximumValue = 100.0;
    minimumValue = 0.0;
    
    self.backgroundColor = [UIColor clearColor];
	
		NSLog(@"ox=%f oy=%f cx=%f cy=%f", ox,oy,cx,cy);
	}
    return self;
}

- (void)drawRect:(CGRect)rect {
  NSLog(@"drawRect ox=%f oy=%f cx=%f cy=%f", rect.origin.x,rect.origin.y,rect.size.width,rect.size.height);
	
	 // Drawing code
	CGContextRef context = UIGraphicsGetCurrentContext(); 	
    //[super drawRect:rect];

	//CGContextSetRGBFillColor(context, .0, .0, .0, 1);
	//CGContextFillRect(context, rect);
	
  NSLog(@"qx=%f qy=%f x=%f value=%f maxrange=%f", qx,qy,x,value, maxrange);
	
	if( x > maxrange)
		x = maxrange;
	if( x < 0)
		x = 0;

  int kx = x;
  if( kx < qx*2.0 )
    kx = qx*2.0;
  
	// Bar
	CGContextSetRGBFillColor(context, .1, .1, .1, 1); 
	rectVel = CGRectMake(qx*1.9, qy*4.4, qx*22.2, qy*1.2);
	CGContextFillRect(context, rectVel);
	CGContextSetRGBFillColor(context, .2, .2, .2, 1); 
	rectVel = CGRectMake(qx*2.0, qy*4.5, qx*22.0, qy*1.0);
	CGContextFillRect(context, rectVel);
	
  
	//Knob
	CGContextSetRGBFillColor(context, .3, .3, .3, 1);  
	[iRocSlider CGContextAddRoundedRect:context withRect:CGRectMake(kx-qx*2.0, qy*.4, qx*4.0, qy*9.2) withRadius: qx*0.5];  
	CGContextFillPath(context);  
	
	//Knob border
	CGContextSetLineWidth(context, 0.5);  
	CGContextSetRGBStrokeColor(context, .5, .5, .5, 1);  
	[iRocSlider CGContextAddRoundedRect:context withRect:CGRectMake(kx-qx*2.0,qy*.4,qx*4.0,qy*9.2) withRadius:qx*0.5 ];  
	CGContextStrokePath(context);  
	
	//Knob lines
  
	CGContextSetRGBFillColor(context, .2, .2, .2, 1); 
	CGContextFillRect(context, CGRectMake(kx-qx*2.0+qx*0.75, qy*1.4, 1, qy*7.2));
	CGContextFillRect(context, CGRectMake(kx-qx*2.0+qx*1.75, qy*1.4, 1, qy*7.2));
	CGContextFillRect(context, CGRectMake(kx-qx*2.0+qx*2.75, qy*1.4, 1, qy*7.2));

	CGContextSetRGBFillColor(context, .4, .4, .4, 1); 
	CGContextFillRect(context, CGRectMake(kx-qx*2.0+qx*1.25, qy*1.4, 1, qy*7.2));
	CGContextFillRect(context, CGRectMake(kx-qx*2.0+qx*2.25, qy*1.4, 1, qy*7.2));
	CGContextFillRect(context, CGRectMake(kx-qx*2.0+qx*3.25, qy*1.4, 1, qy*7.2));

	
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	
	// We only support single touches, so anyObject retrieves just that touch from touches
	UITouch *touch = [touches anyObject];
	x = [touch locationInView:self].x;
	y = [touch locationInView:self].y;
	
	NSLog(@"touchesBegan: (%f, %f)", x, y);
	
	[self setNeedsDisplay];
  [self getValue];
	//[self sendActionsForControlEvents:UIControlEventValueChanged];
	 
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	
	
	UITouch *touch = [touches anyObject];
	x = [touch locationInView:self].x;
	y = [touch locationInView:self].y;
	NSLog(@"touchesMoved: (%f, %f)", x, y);

	[self setNeedsDisplay];
    //[self getValue];
  
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
	NSLog(@"touchesEnded: (%f, %f)", x, y);
	
	[self setNeedsDisplay];
  [self getValue];
	[self sendActionsForControlEvents:UIControlEventValueChanged];
}


- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {

}

- (int)getValue {
  if( x > maxrange)
		x = maxrange;
	if( x < 0)
		x = 0;
  
  value = (x*(maximumValue-minimumValue))/maxrange;
  
	NSLog(@"getValue maxrange=%f range=%f x=%f val=%f", maxrange, maximumValue-minimumValue, x, value);
	
	return (int)value;
}

- (void)setValue:(int) Value{
  value = Value;
  
	x = (maxrange/(maximumValue-minimumValue))*value;
	//NSLog(@"Slider setValue: %d(%d)", value, x);
	[self setNeedsDisplay];
}

- (void)dealloc {
    [super dealloc];
}


+ (void) CGContextAddRoundedRect:(CGContextRef)c withRect:(CGRect)rect withRadius:(int)corner_radius {
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




@end
