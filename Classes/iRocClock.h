//
//  iRocClock.h
//  iRoc
//
//  Created by Jean-Michel Fischer on 16.09.10.
//  Copyright 2010 rocrail.net. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface iRocClock : UIView {
	CGRect m_rect;
	CGContextRef context;

	
	UIImage *image;
	UIImageView *imageview;
	
	bool first;
	
	double x,y,z;
}

- (void)clockTick:(NSDate*) date;


@end
