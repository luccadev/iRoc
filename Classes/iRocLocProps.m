//
//  iRocLocProps.m
//  iRoc
//
//  Created by Jean-Michel Fischer on 13.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "iRocLocProps.h"
#import "iRocAppDelegate.h"

@implementation iRocLocProps
@synthesize idLabel, delegate;


void CGContextAddRoundedRectB(CGContextRef c, CGRect rect, int corner_radius) {
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


- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super initWithCoder:decoder])
    {

		idLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,10, 190, 20)];
		idLabel.font = [UIFont boldSystemFontOfSize:20];
		idLabel.textColor = [UIColor lightGrayColor];
		idLabel.backgroundColor = [UIColor darkGrayColor];
		
		descLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, 30, 100, 20)] autorelease];
		descLabel.font = [UIFont boldSystemFontOfSize:12];
		descLabel.textColor = [UIColor lightGrayColor];
		descLabel.backgroundColor = [UIColor darkGrayColor];
		
		[self addSubview:idLabel];
		[self addSubview:descLabel];		
	}
    return self;
}
 


- (id)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        // Initialization code
		NSLog(@"iRocLocProps:initWithFrame");
    }
	
    return self;
}


- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
    context = UIGraphicsGetCurrentContext();
	

	CGContextSetFillColorWithColor(context, [[UIColor darkGrayColor] CGColor]);
	CGContextAddRoundedRectB(context, CGRectMake(0,0, CGRectGetWidth(rect), CGRectGetHeight( rect)), 5);  
	CGContextFillPath(context);
	
	//border
	CGContextSetLineWidth(context, .5);
	CGContextSetRGBStrokeColor(context, .5, .5, .5, 1);
	CGContextAddRoundedRectB(context, CGRectMake(0,0, CGRectGetWidth(rect), CGRectGetHeight( rect)), 5);  
	CGContextStrokePath(context);  
}


- (void)setLoc:(Loc*)loci {
	loc = loci;
	
	NSLog(@"setLoc: %@", [loc locid]);
	idLabel.text = [loc locid];
	descLabel.text = [loc desc];
	
	
	
	if( imageview != NULL ) {
    NSLog(@"remove previous image");
		[imageview removeFromSuperview];
  }
	
	[self imageLoaded];
  
}


- (void)imageLoaded {
  Loc* lc = loc;
  if( lc == nil ) {
    NSLog(@"imageLoaded: loco=%@...", idLabel.text);
    lc = [delegate getLoc:idLabel.text];
  }
  
	NSLog(@"imageLoaded: loco=%@(%@) hasImage=%d imageLoaded=%d...", [lc locid], idLabel.text, [lc hasImage], [lc imageLoaded]);
  if( [lc hasImage] && [lc imageLoaded] ) {
    NSLog(@"loaded image...");
    UIImage *img = [lc getImage];
    
    int breite = 51*(img.size.width/img.size.height);
    int diff = 150 - breite;
    CGRect imageframe = CGRectMake(120 + diff,10 ,breite,51);	
    
    imageview = [[UIImageView alloc] initWithFrame:imageframe];
    imageview.image = img;
    
    [self addSubview:imageview];
    
    //[imageview release];
  }
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[super touchesBegan:touches withEvent:event];
	//NSLog(@"Touches B");
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	[super touchesMoved:touches withEvent:event];
	//NSLog(@"Touches M");
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	[super touchesEnded:touches withEvent:event];
	//NSLog(@"Touches E");
}


@end
