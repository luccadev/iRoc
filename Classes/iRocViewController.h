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
#import "iRocButton.h"

@interface iRocViewController : UIViewController <UITextFieldDelegate> {
	IBOutlet iRocButton *buttonDir;
	IBOutlet iRocButton *buttonF0;
	IBOutlet iRocButton *buttonF1;
	IBOutlet iRocButton *buttonF2;
	IBOutlet iRocButton *buttonF3;
	IBOutlet iRocButton *buttonF4;
	IBOutlet iRocButton *buttonF5;
	IBOutlet iRocButton *buttonF6;
	IBOutlet iRocButton *buttonF7;
	IBOutlet iRocButton *buttonF8;
	IBOutlet iRocButton *buttonFn;
	IBOutlet UISlider *slider;
	IBOutlet UITextField *textfieldLoc;
	IBOutlet iRocTouchView *slideView;
	
	CFURLRef		soundFileURLRef;
	SystemSoundID	soundFileObject;
	
	IRocConnector *rrconnection;
	NSString * stringDir; 
	NSString * stringLcPrev; 
		
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
@property (nonatomic, retain) iRocButton *buttonDir; 
@property (nonatomic, retain) iRocButton *buttonF0;
@property (nonatomic, retain) iRocButton *buttonF1; 
@property (nonatomic, retain) iRocButton *buttonF2; 
@property (nonatomic, retain) iRocButton *buttonF3; 
@property (nonatomic, retain) iRocButton *buttonF4; 
@property (nonatomic, retain) iRocButton *buttonF5; 
@property (nonatomic, retain) iRocButton *buttonF6; 
@property (nonatomic, retain) iRocButton *buttonF7; 
@property (nonatomic, retain) iRocButton *buttonF8; 
@property (nonatomic, retain) iRocButton *buttonFn; 

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

//- (IBAction) textFieldDone:(id) sender;

- (void) prepareFNCommand:(int) fnIndex; 



@end

