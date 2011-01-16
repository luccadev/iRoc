/*
 Rocrail - Model Railroad Software
 
 Copyright (C) 2009-2011 - Rob Versluis <r.j.versluis@rocrail.net>, Jean-Michel Fischer <jmf@polygonpunkt.de>
 
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
#import "iRocClock.h"


@implementation iRocClock


void CGContextAddRoundedRectF(CGContextRef c, CGRect rect, int corner_radius) {
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

int modulal(int val)
{
	do{
		val +=360;
	}while(val<0);
	return val;
}

int kactane(int x, int y)
{
	int times=0;
	do{
		x-=y;
		times++;
	}while(x>=y);
	return times;
}

double sm_angle(double m)
{
	// Values of m must be minute or second.
	return ((modulal((90 - (m * 6))) * M_PI) / 180);
}

double h_angle(int m, int n)
{
	// Values of m must be hour, values of n must be minute.
	return ((modulal((90 - (m * 30) - (kactane(n, 6) * 3))) * M_PI) / 180);
}


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
			//[self runTimer];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
	
	context = UIGraphicsGetCurrentContext();	

	image = [UIImage imageNamed:@"plate.png"];
		
	
	double width = CGRectGetWidth(rect);
	double border = 4;

	CGContextSetRGBFillColor(context, .7, .7, .7 ,1);
	CGContextAddRoundedRectF(context, CGRectMake(0,0, width, width),  (width)/2);
	CGContextFillPath(context); 	
	
	CGContextSetRGBFillColor(context, 0, 0, 0 ,1);
	CGContextAddRoundedRectF(context, CGRectMake(border/2, border/2, width-border, width-border), (width-border)/2);
	CGContextFillPath(context); 	
	
	CGContextSetRGBFillColor(context, 1, 1, 1 ,1);
	CGContextAddRoundedRectF(context, CGRectMake(border, border, width-border*2, width-border*2), (width-border*2)/2);
	CGContextFillPath(context); 	
	
  double c = width/2;
	
	int i;
	for (i = 0; i < 60; i++) {
		double k = sm_angle( i );
		
		CGContextSetLineWidth(context, 1);
		CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);		
		CGContextBeginPath(context);
		CGContextMoveToPoint(context, (c + 0.85 * c * cos(k)), (c - 0.85 * c * sin(k)));
		CGContextAddLineToPoint(context, (c + 0.90 * c * cos(k)), (c - 0.90 * c * sin(k)) );
		CGContextClosePath(context);
		CGContextStrokePath(context);
		
		if( i%5 == 0 ) {
			CGContextSetLineWidth(context, 4);
			CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);		
			CGContextBeginPath(context);
			CGContextMoveToPoint(context, (c + 0.65 * c * cos(k)), (c - 0.65 * c * sin(k)));
			CGContextAddLineToPoint(context, (c + 0.90 * c * cos(k)), (c - 0.90 * c * sin(k)) );
			CGContextClosePath(context);
			CGContextStrokePath(context);
		}
	}
	
	// hour
	CGContextSetLineWidth(context, 4);
	CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
	CGContextBeginPath(context);
	CGContextMoveToPoint(context, c, c);
	CGContextAddLineToPoint(context, (c + 0.60 * c * cos(z)), (c - 0.60 * c * sin(z)) );
	CGContextClosePath(context);	
	CGContextStrokePath(context);
	
	// minute
	CGContextSetLineWidth(context, 4);
	CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
	CGContextBeginPath(context);
	CGContextMoveToPoint(context, c, c);
	CGContextAddLineToPoint(context, (c + 0.80 * c * cos(y)), (c - 0.80 * c * sin(y)) );
	CGContextClosePath(context);	
	CGContextStrokePath(context);
	
	// second
	CGContextSetLineWidth(context, 2);
	CGContextSetRGBStrokeColor(context, 1, 0, 0, 1);
	CGContextSetRGBFillColor(context, 1, 0, 0, 1);
	CGContextBeginPath(context);
	CGContextMoveToPoint(context, c, c);
	CGContextAddLineToPoint(context, (c + 0.58 * c * cos(x)), (c - 0.58 * c * sin(x)) );
	CGContextClosePath(context);	
	CGContextStrokePath(context);
	CGContextSetLineWidth(context, 0);
	CGContextAddEllipseInRect(context, CGRectMake((c - 4 + 0.58 * c * cos(x)), (c - 4 - 0.58 * c * sin(x)), 8, 8));
	CGContextFillPath(context);
	
	CGContextSetLineWidth(context, 0);
	CGContextSetRGBFillColor(context, .5, .5, .5, 1);
	CGContextAddEllipseInRect(context, CGRectMake(c-2, c-2, 4, 4));
	CGContextFillPath(context);
}
 
- (void)clockTick:(NSDate*) date{

	//NSDate *date = [NSDate date];
	
	//self.date = date;
	
	NSDateFormatter *date_formater=[[NSDateFormatter alloc]init];
	
	// swiss style
	//[date_formater setDateFormat:@"SSS"];
	//double sss = [[date_formater stringFromDate:date] intValue];
	
	[date_formater setDateFormat:@"ss"];
	double ss = [[date_formater stringFromDate:date] intValue];
	
	[date_formater setDateFormat:@"mm"];
	int mm = [[date_formater stringFromDate:date] intValue];
	
	[date_formater setDateFormat:@"hh"];
	int hh = [[date_formater stringFromDate:date] intValue];

	//ss = ss + sss/1000.00;
	
	x = sm_angle( ss );
	y = sm_angle( mm );
  z = h_angle(hh , mm);

	[self setNeedsDisplay];
}



- (void)dealloc {
    [super dealloc];
}


@end
