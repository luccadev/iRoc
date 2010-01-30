//
//  iRocBlockView.h
//  iRoc
//
//  Created by Jean-Michel Fischer on 30.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iRocButton.h"


@interface iRocBlockView : UIViewController {
  IBOutlet iRocButton *selectLoc;
	id _delegate;
}
@property (nonatomic, retain) iRocButton *selectLoc;
@property (nonatomic, retain) id _delegate;

- (IBAction) selectLocClicked:(id) sender; 

@end

@interface NSObject (iRocBlockView)
- (void)dismissModalViewController;
@end