//
//  iRocViewController.h
//  iRoc
//
//  Created by Jean-Michel Fischer on 17.11.09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IRocConnector.h"
#import "iRocTouchView.h"

@interface iRocViewController : UIViewController <UITextFieldDelegate> {
	IBOutlet UIButton *buttonDir;
	IBOutlet UISlider *slider;
	IBOutlet UITextField *textfieldLoc;
	IBOutlet iRocTouchView *slideView;
	
	BOOL dir;
	int prevVVal;
}
@property (nonatomic, retain) UIButton *buttonDir; 
@property (nonatomic, retain) UISlider *slider;
@property (nonatomic, retain) UITextField *textfieldLoc;
@property (nonatomic, retain) iRocTouchView *slideView;

- (IBAction) buttonDirClicked:(id) sender; 
- (IBAction) sliderMoved:(id) sender;
- (IBAction) textFieldDone:(id) sender;

@end

