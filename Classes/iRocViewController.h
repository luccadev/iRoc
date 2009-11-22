//
//  iRocViewController.h
//  iRoc
//
//  Created by Jean-Michel Fischer on 17.11.09.
//  Copyright rocrail.net 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <AudioToolbox/AudioToolbox.h>

#import "IRocConnector.h"
#import "iRocTouchView.h"

@interface iRocViewController : UIViewController <UITextFieldDelegate> {
	IBOutlet UIButton *buttonDir;
	IBOutlet UIButton *buttonF0;
	IBOutlet UIButton *buttonF1;
	IBOutlet UIButton *buttonF2;
	IBOutlet UIButton *buttonF3;
	IBOutlet UIButton *buttonF4;
	IBOutlet UIButton *buttonF5;
	IBOutlet UIButton *buttonF6;
	IBOutlet UIButton *buttonF7;
	IBOutlet UIButton *buttonF8;
	IBOutlet UIButton *buttonFn;
	IBOutlet UISlider *slider;
	IBOutlet UITextField *textfieldLoc;
	IBOutlet iRocTouchView *slideView;
	
	CFURLRef		soundFileURLRef;
	SystemSoundID	soundFileObject;
	
	IRocConnector *rrconnection;
	NSString * stringDir; 
		
	BOOL fnStates[9];
	BOOL connectOK;

	UIColor * fnButtonOnColor;
	UIColor * fnButtonOffColor;
	BOOL dir;
	int prevVVal;
	NSArray * functionButtons;
	//NSString * strTrue;
	//NSString * strFalse;
	NSUserDefaults *defaults;
}
@property (nonatomic, retain) UIButton *buttonDir; 
@property (nonatomic, retain) UIButton *buttonF0;
@property (nonatomic, retain) UIButton *buttonF1; 
@property (nonatomic, retain) UIButton *buttonF2; 
@property (nonatomic, retain) UIButton *buttonF3; 
@property (nonatomic, retain) UIButton *buttonF4; 
@property (nonatomic, retain) UIButton *buttonF5; 
@property (nonatomic, retain) UIButton *buttonF6; 
@property (nonatomic, retain) UIButton *buttonF7; 
@property (nonatomic, retain) UIButton *buttonF8; 
@property (nonatomic, retain) UIButton *buttonFn; 

@property (nonatomic, retain) NSArray * functionButtons;

@property (nonatomic, retain) IRocConnector *rrconnection;

@property (nonatomic, retain) UISlider *slider;
@property (nonatomic, retain) UITextField *textfieldLoc;
@property (nonatomic, retain) iRocTouchView *slideView;

@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

- (IBAction) buttonDirClicked:(id) sender; 
- (IBAction) buttonF0Clicked:(id) sender;
- (IBAction) buttonF1Clicked:(id) sender;
- (IBAction) buttonF2Clicked:(id) sender;
- (IBAction) buttonF3Clicked:(id) sender;
- (IBAction) buttonF4Clicked:(id) sender;
- (IBAction) buttonF5Clicked:(id) sender;
- (IBAction) buttonF6Clicked:(id) sender;
- (IBAction) buttonF7Clicked:(id) sender;
- (IBAction) buttonF8Clicked:(id) sender;
- (IBAction) buttonFnClicked:(id) sender;
- (IBAction) sliderMoved:(id) sender;

- (IBAction) textFieldDone:(id) sender;

- (void) prepareFNCommand:(int) fnIndex; 



@end

