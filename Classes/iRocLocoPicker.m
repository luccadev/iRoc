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

#import "iRocLocoPicker.h"
#import "iRocAppDelegate.h"

@implementation iRocLocoPicker
@synthesize idLabel, delegate, imageview;


void CGContextAddRoundedRectC(CGContextRef c, CGRect rect, int corner_radius) {
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
  NSLog(@"iRocLocProps:initWithFrame");

	//rect = frame;
	
    if (self = [super initWithFrame:frame]) {
        // Initialization code
      idLabel = [[UILabel alloc] initWithFrame:CGRectMake(7,6, 190, 20)];
      idLabel.font = [UIFont boldSystemFontOfSize:20];
      idLabel.textColor = [UIColor lightGrayColor];
      idLabel.backgroundColor = [UIColor darkGrayColor];
      
      descLabel = [[[UILabel alloc] initWithFrame:CGRectMake(9, 24, 100, 20)] autorelease];
      descLabel.font = [UIFont systemFontOfSize:12];
      descLabel.textColor = [UIColor lightGrayColor];
      descLabel.backgroundColor = [UIColor darkGrayColor];
      
      roadLabel = [[[UILabel alloc] initWithFrame:CGRectMake(9, 40, 100, 20)] autorelease];
      roadLabel.font = [UIFont systemFontOfSize:12];
      roadLabel.textColor = [UIColor lightGrayColor];
      roadLabel.backgroundColor = [UIColor darkGrayColor];
      
      
      [self addSubview:idLabel];
      [self addSubview:roadLabel];
      [self addSubview:descLabel];
			
			lcTableView = [[iRocLcTableView alloc] init];
			
			NSLog(@"locopicker");
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
    context = UIGraphicsGetCurrentContext();
	

	CGContextSetFillColorWithColor(context, [[UIColor darkGrayColor] CGColor]);
	CGContextAddRoundedRectC(context, CGRectMake(0,0, CGRectGetWidth(rect), CGRectGetHeight( rect)), 5);  
	CGContextFillPath(context);
	
	//border
	CGContextSetLineWidth(context, .5);
	CGContextSetRGBStrokeColor(context, .5, .5, .5, 1);
	CGContextAddRoundedRectC(context, CGRectMake(0,0, CGRectGetWidth(rect), CGRectGetHeight( rect)), 5);  
	CGContextStrokePath(context);  
}



- (void)updateLabels{
	
	if( loc != NULL) {	
		idLabel.text = [loc locid];
		descLabel.text = [loc desc];
		roadLabel.text = [loc roadname];
	} else {
		idLabel.text = @"";
		descLabel.text = @"";
		roadLabel.text = @"";
		if( imageview != nil ) {
			NSLog(@"remove previous image");
			[imageview removeFromSuperview];
			imageview = nil;
		}
		
	}

}

- (void)setLocContainer:(Container*)lccontainer {
	loccontainer = lccontainer;
	
		NSLog( @" setLocContainer : ");
	
	lcTableView.lcContainer = lccontainer;
	[lcTableView setDelegate:self];
	[lcTableView setMenuname:NSLocalizedString(@"Locomotives", @"")];
	
	
	}

- (void)lcAction:(NSString *)lcid {	
	NSLog(@"lcAction: locoPicker %@", lcid);
	
	[lcTableView dismissModalViewControllerAnimated:YES];
	
	
	Loc *lc = [loccontainer objectWithId:lcid];
	[self setLoc:lc];
	
}

- (void)setLoc:(Loc*)loci {
	loc = loci;
	
	[self updateLabels];
	
	if (loci != NULL) {

		NSLog(@"setLoc: %@", [loc locid]);
		[self updateLabels];
	
	
		if( imageview != nil ) {
			NSLog(@"remove previous image");
			[imageview removeFromSuperview];
			imageview = nil;
		}
	
		[self imageLoaded];
  }
}

- (Loc*)getLoc {
	return loc;	
}

- (void)setFn:(int)fn withState:(BOOL)state {
  [loc setFn:fn withState:state];
}

- (BOOL)isFn:(int)fn {
	
	//NSLog(@"Hello from isFn: %@ : %d : %d", loc.locid, fn, [loc isFn:fn]);
	
  return [loc isFn:fn];
}

- (void)imageLoaded {
  if( imageview != nil ) {
    //NSLog(@"image already loaded for %@.", idLabel.text);
    return;
  }
  
  Loc* lc = loc;
  if( lc == nil ) {
    //NSLog(@"imageLoaded: loco=%@...", idLabel.text);
    lc = [delegate getLoc:idLabel.text];
    loc = lc;
    [self updateLabels];
  }
  
  //[delegate setSelectedLoc:loc];
  
	//NSLog(@"imageLoaded: loco=%@(%@) hasImage=%d imageLoaded=%d...", [lc locid], idLabel.text, [lc hasImage], [lc imageLoaded]);
  if( [lc hasImage] && [lc imageLoaded] ) {
    NSLog(@"loaded image...");
    UIImage *img = [lc getImage];
		
		NSLog(@" %f x %f ", CGRectGetWidth( [super frame]), CGRectGetHeight( [super frame]) );
    
    int breite = 55*(img.size.width/img.size.height);
    CGRect imageframe = CGRectMake(CGRectGetWidth( [super frame])-breite-7 ,7 ,breite, 50);	
    
    imageview = [[UIImageView alloc] initWithFrame:imageframe];
    imageview.image = img;
    
    [self addSubview:imageview];
    
    //[imageview release];
  }
}

- (void)setText:(NSString *)text {
	
	idLabel.text = text;
	descLabel.text = NSLocalizedString(@"select loco ...", @"");
	
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
	NSLog(@"Touches E");
	
	
	[delegate presentModalViewController:lcTableView animated:YES];

	
}


@end
