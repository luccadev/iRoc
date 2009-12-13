//
//  iRocLocProps.m
//  iRoc
//
//  Created by Jean-Michel Fischer on 13.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "iRocLocProps.h"

@implementation iRocLocProps
@synthesize idLabel;

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
		[self setBackgroundColor:[UIColor darkGrayColor]];
		
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

/*
- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
}
*/

- (void)setLoc:(Loc*)loci {

	
	loc = loci;
	
	NSLog(@"setLoc: %@", [loc locid]);
	idLabel.text = [loc locid];
	descLabel.text = [loc desc];
	
	
	
	if( imageview != NULL )
		[imageview removeFromSuperview];
	
	
	if( [loc hasImage] ) {
		UIImage *img = [loc getImage];
		
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
