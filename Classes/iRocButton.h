//
//  iRocButton.h
//  iRoc
//
//  Created by Jean-Michel Fischer on 21.11.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface iRocButton : UIButton {
	CGContextRef context;
	enum {began, moved, ended};
	int touchState;
}

@end
