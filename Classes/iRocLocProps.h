//
//  iRocLocProps.h
//  iRoc
//
//  Created by Jean-Michel Fischer on 13.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Loc.h"

@class iRocLocProps;

@interface iRocLocProps : UIButton {
	CGContextRef context;
	Loc *loc;
	UILabel *idLabel;
	UILabel *descLabel;
	UILabel *roadLabel;
	UIImageView *imageview;
	id delegate;
}

@property(nonatomic,retain) UILabel *idLabel;
@property (nonatomic, retain) id delegate; 
@property (nonatomic, retain) UIImageView *imageview; 

- (void)setLoc:(Loc*)loci;
- (void)imageLoaded;

@end
