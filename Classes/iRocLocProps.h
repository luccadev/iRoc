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
	Loc *loc;
	UILabel *idLabel;
	UILabel *descLabel;
	UIImageView *imageview;
}

- (void)setLoc:(Loc*)loci;

@end
