//
//  iRocLocProps.m
//  iRoc
//
//  Created by Jean-Michel Fischer on 13.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "iRocLocProps.h"

@implementation iRocLocProps


- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super initWithCoder:decoder])
    {
		
		
		label = [[UILabel alloc] initWithFrame:CGRectMake(10,10,30,50)];
		label.text = @"XXX";
		
		[self addSubview:label];
		[self setBackgroundColor:[UIColor redColor]];
		
		NSLog(@"iRocLocProps:initWithCoder");
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
	
	
	NSLog(@"setLoc: Hääääää?");
	
	loc = loci;
	
	NSLog(@"setLoc: %@", [loc locid]);
	label.text = [loc locid];

	UIImage *img = [loc getImage];
	
	int breite = 60*(img.size.width/img.size.height);
	int diff = 150 - breite;
	CGRect imageframe = CGRectMake(160 + diff,10,breite,60);	
	
	//[imageview removeFromSuperview];
	
	imageview = [[UIImageView alloc] initWithFrame:imageframe];
	imageview.image = img;
	
	[self addSubview:imageview];
	
	[imageview release];
	 
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
