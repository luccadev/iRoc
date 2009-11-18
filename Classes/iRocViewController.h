//
//  iRocViewController.h
//  iRoc
//
//  Created by Jean-Michel Fischer on 17.11.09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IRocConnector.h"

@interface iRocViewController : UIViewController {
	IBOutlet UIButton *button; 
	IBOutlet UIButton *buttonAutoOff; 
	IBOutlet UIButton *buttonDir;
	IBOutlet UILabel  *messageLabel;
	IBOutlet UISlider *slider;
	IBOutlet UITextField *textfieldLoc;
	
	BOOL dir;
}

@property (nonatomic, retain) UIButton *button; 
@property (nonatomic, retain) UIButton *buttonAutoOff;
@property (nonatomic, retain) UIButton *buttonDir; 
@property (nonatomic, retain) UILabel  *messageLabel; 
@property (nonatomic, retain) UISlider *slider;
@property (nonatomic, retain) UITextField *textfieldLoc;

- (IBAction) buttonClicked:(id) sender; 
- (IBAction) buttonAutoOffClicked:(id) sender; 
- (IBAction) buttonDirClicked:(id) sender; 
- (IBAction) sliderMoved:(id) sender;
- (IBAction) textFieldDone:(id) sender;

- (void) setLabel:(id) message;


@end

