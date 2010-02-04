//
//  iRocBlockView.h
//  iRoc
//
//  Created by Jean-Michel Fischer on 30.01.10.
//  Copyright 2010 rocrail.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iRocButton.h"
#import "Block.h"


@interface iRocBlockView : UIViewController {
  IBOutlet iRocButton *selectLoc;
	IBOutlet iRocButton *intoOP;
	id _delegate;
	
	UILabel* l;
	Block *_block;
}
@property (nonatomic, retain) iRocButton *selectLoc;
@property (nonatomic, retain) iRocButton *intoOP;
@property (nonatomic, retain) id _delegate;
//@property (nonatomic, retain) Block *block;

- (IBAction) selectLocClicked:(id) sender;
- (IBAction) intoOPClicked:(id) sender; 

- (void) setBlock:(Block*)block;

@end

@interface NSObject (iRocBlockView)
- (void)dismissModalViewController;
- (void)lcTextFieldAction;
@end