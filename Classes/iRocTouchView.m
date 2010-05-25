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

#import "iRocTouchView.h"
#import "iRocSlider.h"

@implementation iRocTouchView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
       
		x = 0;
		y = 0;
		
		NSLog(@"iRocTouchView ... (id)initWithFrame:(CGRect)frame");
	}
    return self;
}

- (void)drawRect:(CGRect)rect {
	
	 // Drawing code
	CGContextRef context = UIGraphicsGetCurrentContext(); 	
	CGContextSetRGBFillColor(context, .0, .0, .0, 1); 
	CGContextFillRect(context, rect);
  
  
	float maxval = 290.00; 
	int minval = 28;
	
	if(x < minval)
		x=minval;
	
	if( x>maxval)
		x=maxval;

	int off = 0;
	
	// Bar
	CGContextSetRGBFillColor(context, .1, .1, .1, 1); 
	rectVel = CGRectMake(20, 54, 280, 12);
	CGContextFillRect(context, rectVel);
	CGContextSetRGBFillColor(context, .2, .2, .2, 1); 
	rectVel = CGRectMake(21, 55, 278, 10);
	CGContextFillRect(context, rectVel);
	
	//Knob
	CGContextSetRGBFillColor(context, .3, .3, .3, 1);  
	[iRocSlider CGContextAddRoundedRect:context withRect:CGRectMake(x-20+off,10,40,100) withRadius:5];  
	CGContextFillPath(context);  
	
	//Knob border
	CGContextSetLineWidth(context, 0.5);  
	CGContextSetRGBStrokeColor(context, .5, .5, .5, 1);  
	[iRocSlider CGContextAddRoundedRect:context withRect:CGRectMake(x-20+off,10,40,100) withRadius:5 ];  
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
	float maxval = 280.00 - shiftval;
	int xout = x - shiftval;
		
	if(xout < 0)
		xout=0;
	
	if( xout>maxval)
		xout=maxval;

	//NSLog(@"iRocTouchView().value: (%d  ...  %f)", xout, (xout)/maxval);
	
	return (xout/maxval);
}

- (void)setValue:(double) val{
	x = 250*val + 30;
	
	
	[self setNeedsDisplay];
	//NSLog(@"Slider setValue: %f", val);
}

- (void)dealloc {
    [super dealloc];
}


@end
