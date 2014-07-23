/*
 Rocrail - Model Railroad Software
 
 Copyright (C) 2009-2010 - Rob Versluis <r.j.versluis@rocrail.net>, Jean-Michel Fischer <jmf@polygonpunkt.de>
 
 This program is free software; you can redistribute it and/or
 modify it under the terms of the GNU General Public License
 as published by the Free Software Foundation; either version 2
 of the License, or (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 */

#import <UIKit/UIKit.h>
#include <AudioToolbox/AudioToolbox.h>

#import "IRocConnector.h"
#import "iRocTouchView.h"
#import "iRocButton.h"
#import "iRocLocoPicker.h"
#import "Loc.h"

@interface iRocViewController : UIViewController <UITextFieldDelegate, UIGestureRecognizerDelegate>  {
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
	IBOutlet UIImageView *imageviewLoc;
	IBOutlet iRocTouchView *slideView;
	iRocLocoPicker *locProps;
	
    int VDelta;
	
	CFURLRef		soundFileURLRef;
	SystemSoundID	soundFileObject;
	

	NSString * stringDir; 
	NSString * stringLcPrev; 
		
    //BOOL fnStates[32];
	BOOL connectOK;
	BOOL processAll;
  BOOL fnLongClick;

	UIColor * fnButtonOnColor;
	UIColor * fnButtonOffColor;
	BOOL dir;
	int prevVVal;
	NSArray * functionButtons;
	//NSString * strTrue;
	NSString * ip;
	NSUserDefaults *defaults;
	
	UIView* keyboard;
	
	IRocConnector *rrconnection;
	
  Model* model;
  id delegate;
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
@property (nonatomic, retain) id delegate; 

@property (nonatomic, retain) Model* model;

@property (nonatomic, retain) UIView* keyboard;

@property (nonatomic, retain) NSArray * functionButtons;

@property (nonatomic, retain) IRocConnector *rrconnection;

@property (nonatomic, retain) UISlider *slider;
@property (nonatomic, retain) iRocTouchView *slideView;
@property (nonatomic, retain) UIImageView *imageviewLoc;
@property (nonatomic, retain) iRocLocoPicker *locProps;

@property(nonatomic, retain) NSString *ip;

@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;
@property (readwrite)	int VDelta;

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
//- (IBAction) doneButton:(id)sender;
- (IBAction) locTextTouched:(id)sender;

//- (IBAction) textFieldDone:(id) sender;

- (void) prepareFNCommand:(int) fnIndex; 
- (void) processAllEvents:(int) _VDelta; 

- (void) setSlider:(double)v withDir:(NSString*)diri;

//- (Loc*)getLoc:(NSString *)lcid;

- (id)initWithDelegate:(id)_delegate andModel:(Model*)_model;

@end

@interface NSObject (iRocViewController)

- (void) updateFnState;

- (BOOL) flipFn:(int)fn;
- (void)lcTextFieldAction;
- (Loc*)getLoc:(NSString*)lid;
- (void)lcAction;

@end

