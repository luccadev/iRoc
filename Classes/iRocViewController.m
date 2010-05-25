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

#import "iRocViewController.h"
#import "iRocButton.h"
#import "Globals.h"

@implementation iRocViewController

@synthesize buttonDir, buttonF0, buttonF1, buttonF2, buttonF3, buttonF4, buttonF5, buttonF6, buttonF7, buttonF8, buttonFn; 
@synthesize slider; 
@synthesize textfieldLoc, keyboard, delegate, imageviewLoc, locProps;
@synthesize slideView;
@synthesize soundFileURLRef;
@synthesize soundFileObject;
@synthesize rrconnection;
@synthesize functionButtons;
@synthesize ip;
@synthesize VDelta;


- (id)init {
  NSLog(@"View Controller init ...");
  self = [super init];
  if( self != nil ) {
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:
                       NSLocalizedString(@"Loco", @"")
                      image:[UIImage imageNamed:@"loco.png"] tag:1];
    
  }
  return self;
}

- (void)loadView {

  NSLog(@"*** loadView");
  [super loadView];
  [super.view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0]];

  CGRect bounds = self.view.bounds;

  CGRect rect = CGRectMake(0, 250, 320, 120);
  slideView = [[iRocTouchView alloc] initWithFrame:rect];
  [slideView addTarget:self action:@selector(sliderMoved:) forControlEvents:UIControlEventValueChanged];
  [self.view addSubview: slideView];

  rect = CGRectMake(CONTENTBORDER, 0, bounds.size.width - (2 * CONTENTBORDER), 64);
  locProps = [[iRocLocProps alloc] initWithFrame:rect];
  [locProps addTarget:self action:@selector(locTextTouched:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview: locProps];
  
  float buttonWidth = (bounds.size.width - (2 * CONTENTBORDER + 3 * BUTTONGAP)) / 4;
  
  rect = CGRectMake(CONTENTBORDER, 71, buttonWidth, 55);
  buttonF1 = [[iRocButton alloc] initWithFrame:rect];
  buttonF1.frame = rect;
  [buttonF1 setTitle: NSLocalizedString(@"F1", @"") forState: UIControlStateNormal];
  [buttonF1 addTarget:self action:@selector(buttonF1Clicked:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview: buttonF1];

  rect = CGRectMake(CONTENTBORDER + 1 * buttonWidth + 1 * BUTTONGAP, 71, buttonWidth, 55);
  buttonF2 = [[iRocButton alloc] initWithFrame:rect];
  buttonF2.frame = rect;
  [buttonF2 setTitle: NSLocalizedString(@"F2", @"") forState: UIControlStateNormal];
  [buttonF2 addTarget:self action:@selector(buttonF2Clicked:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview: buttonF2];
  
  rect = CGRectMake(CONTENTBORDER + 2 * buttonWidth + 2 * BUTTONGAP, 71, buttonWidth, 55);
  buttonF3 = [[iRocButton alloc] initWithFrame:rect];
  buttonF3.frame = rect;
  [buttonF3 setTitle: NSLocalizedString(@"F3", @"") forState: UIControlStateNormal];
  [buttonF3 addTarget:self action:@selector(buttonF3Clicked:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview: buttonF3];
  
  rect = CGRectMake(CONTENTBORDER + 3 * buttonWidth + 3 * BUTTONGAP, 71, buttonWidth, 55);
  buttonF4 = [[iRocButton alloc] initWithFrame:rect];
  buttonF4.frame = rect;
  [buttonF4 setTitle: NSLocalizedString(@"F4", @"") forState: UIControlStateNormal];
  [buttonF4 addTarget:self action:@selector(buttonF4Clicked:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview: buttonF4];
  
  rect = CGRectMake(CONTENTBORDER, 133, buttonWidth, 55);
  buttonF5 = [[iRocButton alloc] initWithFrame:rect];
  buttonF5.frame = rect;
  [buttonF5 setTitle: NSLocalizedString(@"F5", @"") forState: UIControlStateNormal];
  [buttonF5 addTarget:self action:@selector(buttonF5Clicked:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview: buttonF5];
  
  rect = CGRectMake(CONTENTBORDER + 1 * buttonWidth + 1 * BUTTONGAP, 133, buttonWidth, 55);
  buttonF6 = [[iRocButton alloc] initWithFrame:rect];
  buttonF6.frame = rect;
  [buttonF6 setTitle: NSLocalizedString(@"F6", @"") forState: UIControlStateNormal];
  [buttonF6 addTarget:self action:@selector(buttonF6Clicked:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview: buttonF6];
  
  rect = CGRectMake(CONTENTBORDER + 2 * buttonWidth + 2 * BUTTONGAP, 133, buttonWidth, 55);
  buttonF7 = [[iRocButton alloc] initWithFrame:rect];
  buttonF7.frame = rect;
  [buttonF7 setTitle: NSLocalizedString(@"F7", @"") forState: UIControlStateNormal];
  [buttonF7 addTarget:self action:@selector(buttonF7Clicked:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview: buttonF7];
  
  rect = CGRectMake(CONTENTBORDER + 3 * buttonWidth + 3 * BUTTONGAP, 133, buttonWidth, 55);
  buttonF8 = [[iRocButton alloc] initWithFrame:rect];
  buttonF8.frame = rect;
  [buttonF8 setTitle: NSLocalizedString(@"F8", @"") forState: UIControlStateNormal];
  [buttonF8 addTarget:self action:@selector(buttonF8Clicked:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview: buttonF8];

  
  rect = CGRectMake(CONTENTBORDER, 195, 2 * buttonWidth + BUTTONGAP, 55);
  buttonDir = [[iRocButton alloc] initWithFrame:rect];
  buttonDir.frame = rect;
  [buttonDir setTitle: NSLocalizedString(@">", @"") forState: UIControlStateNormal];
  [buttonDir addTarget:self action:@selector(buttonDirClicked:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview: buttonDir];
  
  rect = CGRectMake(CONTENTBORDER + 2 * buttonWidth + 2 * BUTTONGAP, 195, buttonWidth, 55);
  buttonF0 = [[iRocButton alloc] initWithFrame:rect];
  buttonF0.frame = rect;
  [buttonF0 setTitle: NSLocalizedString(@"F0", @"") forState: UIControlStateNormal];
  [buttonF0 addTarget:self action:@selector(buttonF0Clicked:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview: buttonF0];
  
  rect = CGRectMake(CONTENTBORDER + 3 * buttonWidth + 3 * BUTTONGAP, 195, buttonWidth, 55);
  buttonFn = [[iRocButton alloc] initWithFrame:rect];
  buttonFn.frame = rect;
  [buttonFn setTitle: NSLocalizedString(@"Fn", @"") forState: UIControlStateNormal];
  [buttonFn addTarget:self action:@selector(buttonFnClicked:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview: buttonFn];

}



- (IBAction) buttonDirClicked:(id) sender { 
  if([buttonFn getBState]) {
    NSString * stringToSend = [[NSString alloc] initWithString: [NSString stringWithFormat: @"<lc throttleid=\"%@\" cmd=\"release\" id=\"%@\"/>", 
                                                                 (NSString*)[[UIDevice currentDevice] name], [textfieldLoc text] ] ];
    [rrconnection sendMessage:@"lc" message:stringToSend];
  }
  else {
  
	if(dir) {
		[buttonDir setTitle:@"<" forState:UIControlStateNormal];
		dir = FALSE;
		stringDir = @"false";
	} else {
		[buttonDir setTitle:@">" forState:UIControlStateNormal];
		dir = TRUE;
		stringDir = @"true";
	}
	AudioServicesPlaySystemSound([Globals getChrr]);

	[slideView setValue:0];	
	[rrconnection sendMessage:@"lc" message:[[NSString alloc] initWithString: [NSString stringWithFormat: @"<lc throttleid=\"%@\" id=\"%@\" V=\"0\" dir=\"%@\" fn=\"%@\"/>",
    (NSString*)[[UIDevice currentDevice] name],
    [textfieldLoc text], stringDir, [buttonF0 getBState]?@"true":@"false"]] ];
  }
}

- (IBAction) sliderMoved:(id) sender { 	
	Loc *lc = (Loc*)[delegate getLoc:[textfieldLoc text]];
	int vVal = [slideView value]*100*([lc getVmax]/100.00);
  
  if( processAll && (abs( prevVVal - vVal) < VDelta ) && vVal != 0 ) {
		AudioServicesPlaySystemSound([Globals getClick]);
    return;
	}
		
	if( prevVVal != vVal) {
    //NSLog(@"%@", [[UIDevice currentDevice] name]);

		NSString * stringToSend; 			
		stringToSend = [NSString stringWithFormat: @"<lc throttleid=\"%@\" id=\"%@\" V=\"%d\" dir=\"%@\" fn=\"%@\"/>", 
                    (NSString*)[[UIDevice currentDevice] name],
                    [textfieldLoc text], vVal, stringDir, [buttonF0 getBState]?@"true":@"false"];
		//NSLog(stringToSend);
		AudioServicesPlaySystemSound([Globals getClick]);
		[rrconnection sendMessage:@"lc" message:stringToSend];
	}
		prevVVal = vVal;
}

- (BOOL) flipFn:(int)fn {
  [locProps setFn:fn withState:![locProps isFn:fn]];
  return [locProps isFn:fn];
}


- (IBAction) buttonF0Clicked:(id) sender {	
  BOOL fnState = [self flipFn: 0];
	
	[rrconnection sendMessage:@"lc" message:[[NSString alloc] initWithString: 
                                           [NSString stringWithFormat: @"<lc throttleid=\"%@\" id=\"%@\" fn=\"%@\"/>",
                                           (NSString*)[[UIDevice currentDevice] name], 
                                            [textfieldLoc text], fnState?@"true":@"false"]] ];

	[((iRocButton *)[functionButtons objectAtIndex:0]) setBState:fnState];	
	AudioServicesPlaySystemSound([Globals getClick]);
}

- (IBAction) buttonF1Clicked:(id) sender {
	[self prepareFNCommand:[buttonFn getBState]?9:1];
}
- (IBAction) buttonF2Clicked:(id) sender {
	[self prepareFNCommand:[buttonFn getBState]?10:2];
}
- (IBAction) buttonF3Clicked:(id) sender {
	[self prepareFNCommand:[buttonFn getBState]?11:3];
}
- (IBAction) buttonF4Clicked:(id) sender {
	[self prepareFNCommand:[buttonFn getBState]?12:4];
}
- (IBAction) buttonF5Clicked:(id) sender {
	[self prepareFNCommand:[buttonFn getBState]?13:5];
}
- (IBAction) buttonF6Clicked:(id) sender {
	[self prepareFNCommand:[buttonFn getBState]?14:6];
}
- (IBAction) buttonF7Clicked:(id) sender {
	[self prepareFNCommand:[buttonFn getBState]?15:7];
}
- (IBAction) buttonF8Clicked:(id) sender {
	[self prepareFNCommand:[buttonFn getBState]?16:8];
}

- (IBAction) buttonFnClicked:(id) sender {
  [buttonFn flipBState];
  [self updateFnState];
	AudioServicesPlaySystemSound([Globals getClick]);
}

- (void) updateFnState {
  [buttonF0 setBState:[locProps isFn:0]];
  
  if( [buttonFn getBState] ) {
    [buttonDir setTitle:NSLocalizedString(@"Release", @"") forState:UIControlStateNormal];
    [buttonF1 setTitle:@"F9" forState:UIControlStateNormal];
    [buttonF2 setTitle:@"F10" forState:UIControlStateNormal];
    [buttonF3 setTitle:@"F11" forState:UIControlStateNormal];
    [buttonF4 setTitle:@"F12" forState:UIControlStateNormal];
    [buttonF5 setTitle:@"F13" forState:UIControlStateNormal];
    [buttonF6 setTitle:@"F14" forState:UIControlStateNormal];
    [buttonF7 setTitle:@"F15" forState:UIControlStateNormal];
    [buttonF8 setTitle:@"F16" forState:UIControlStateNormal];
    
    [buttonF1 setBState:[locProps isFn:9]];
    [buttonF2 setBState:[locProps isFn:10]];
    [buttonF3 setBState:[locProps isFn:11]];
    [buttonF4 setBState:[locProps isFn:12]];
    [buttonF5 setBState:[locProps isFn:13]];
    [buttonF6 setBState:[locProps isFn:14]];
    [buttonF7 setBState:[locProps isFn:15]];
    [buttonF8 setBState:[locProps isFn:16]];
  }
  else {
    [buttonDir setTitle:dir?@">":@"<" forState:UIControlStateNormal];
    [buttonF1 setTitle:@"F1" forState:UIControlStateNormal];
    [buttonF2 setTitle:@"F2" forState:UIControlStateNormal];
    [buttonF3 setTitle:@"F3" forState:UIControlStateNormal];
    [buttonF4 setTitle:@"F4" forState:UIControlStateNormal];
    [buttonF5 setTitle:@"F5" forState:UIControlStateNormal];
    [buttonF6 setTitle:@"F6" forState:UIControlStateNormal];
    [buttonF7 setTitle:@"F7" forState:UIControlStateNormal];
    [buttonF8 setTitle:@"F8" forState:UIControlStateNormal];
    [buttonF1 setBState:[locProps isFn:1]];
    [buttonF2 setBState:[locProps isFn:2]];
    [buttonF3 setBState:[locProps isFn:3]];
    [buttonF4 setBState:[locProps isFn:4]];
    [buttonF5 setBState:[locProps isFn:5]];
    [buttonF6 setBState:[locProps isFn:6]];
    [buttonF7 setBState:[locProps isFn:7]];
    [buttonF8 setBState:[locProps isFn:8]];
  }
  
  
}

- (void) processAllEvents:(int) _VDelta {
  VDelta = _VDelta;
  processAll = TRUE;
} 


- (void) prepareFNCommand:(int) fnIndex {
  BOOL fnState = [self flipFn: fnIndex];
	
	int tmp = (fnIndex-1)/4 +1;
	NSLog(@"FNG: %d", tmp);
	
	
	NSString * stringToSend = [[NSString alloc] initWithString: 
                             [NSString stringWithFormat: @"<fn fnchanged=\"%d\" group=\"%d\" id=\"%@\" f%d=\"%@\"/>", 
                              fnIndex, tmp, [textfieldLoc text], fnIndex,  fnState?@"true":@"false" ] ];
	[rrconnection sendMessage:@"fn" message:stringToSend];
	
	NSLog(@"FN: %@", stringToSend);
	
	
	[((iRocButton *)[functionButtons objectAtIndex:fnIndex]) setBState:fnState];
	
	AudioServicesPlaySystemSound([Globals getClick]);
}

- (IBAction)doneButton:(id)sender {
	AudioServicesPlaySystemSound (self.soundFileObject);
    [textfieldLoc resignFirstResponder];
	
  [self updateFnState];

	// Save in Settings
	[[NSUserDefaults standardUserDefaults] setObject:(NSString*)[textfieldLoc text] forKey:@"loc_preference"];
	
	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
  NSLog(@"*** viewDidLoad");
    [super viewDidLoad];

	// read preferences
	defaults = [[NSUserDefaults standardUserDefaults] retain];
	
	functionButtons = [[NSArray arrayWithObjects:buttonF0,buttonF1,buttonF2,buttonF3,buttonF4,buttonF5,buttonF6,buttonF7,buttonF8,
                                                        buttonF1,buttonF2,buttonF3,buttonF4,buttonF5,buttonF6,buttonF7,buttonF8,nil] retain];
	
	textfieldLoc = [[UITextField alloc] initWithFrame:CGRectMake(20, 20, 280, 71)];
	[textfieldLoc setDelegate:self];
	[textfieldLoc setBackgroundColor:[UIColor darkGrayColor]];
	[textfieldLoc setTextColor:[UIColor lightGrayColor]];
	textfieldLoc.clearsOnBeginEditing = YES;
	[textfieldLoc setTextAlignment:UITextAlignmentCenter];
	textfieldLoc.font = [UIFont boldSystemFontOfSize:60];
	/*
	if( [[NSUserDefaults standardUserDefaults] boolForKey:@"locenter_preference"]) {
		
		[self.view addSubview:textfieldLoc];
		
		[textfieldLoc setKeyboardType:UIKeyboardTypeNumberPad];
			
		// Adding a DONE Button to the Numpad:
		[[NSNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(keyboardWillShow:) 
													 name:UIKeyboardWillShowNotification 
												   object:nil];			
	}
	 */
	
	
	//Sound
	// Get the main bundle for the app
	CFBundleRef mainBundle;
	mainBundle = CFBundleGetMainBundle ();
	
	// Get the URL to the sound file to play
	soundFileURLRef  =	CFBundleCopyResourceURL ( mainBundle, CFSTR ("tap"), CFSTR ("aif"), NULL );
	
	// Create a system sound object representing the sound file
	AudioServicesCreateSystemSoundID ( soundFileURLRef, &soundFileObject);
	
	prevVVal = 0;
	dir = true;
	stringDir = @"true";
	[buttonDir setTitle:@">" forState:UIControlStateNormal];
	
	ip = [defaults stringForKey:@"ip_preference"];
	
	textfieldLoc.text = [defaults stringForKey:@"loc_preference"];
	locProps.idLabel.text = [defaults stringForKey:@"loc_preference"];
  locProps.delegate = delegate;
  locProps.imageview = nil;

	
	}

// Adding the DONE button to the numpad
- (void)keyboardWillShow:(NSNotification *)note {  
    // create custom button
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    doneButton.frame = CGRectMake(0, 163, 106, 53);
    doneButton.adjustsImageWhenHighlighted = NO;
    [doneButton setImage:[UIImage imageNamed:@"doneup.png"] forState:UIControlStateNormal];
    [doneButton setImage:[UIImage imageNamed:@"donedown.png"] forState:UIControlStateHighlighted];
    [doneButton addTarget:self action:@selector(doneButton:) forControlEvents:UIControlEventTouchUpInside];
	
    // locate keyboard view
    UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    //UIView* keyboard;
    for(int i=0; i<[tempWindow.subviews count]; i++) {
        keyboard = [tempWindow.subviews objectAtIndex:i];
        // keyboard view found; add the custom button to it
        if([[keyboard description] hasPrefix:@"<UIKeyboard"] == YES)
            [keyboard addSubview:doneButton];
    }
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

// delegate method from textField
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	// Don't show the Keyboard
	/*
	if( ![[NSUserDefaults standardUserDefaults] boolForKey:@"locenter_preference"]){
		[delegate lcTextFieldAction];
		
	}
	
	
	return [[NSUserDefaults standardUserDefaults] boolForKey:@"locenter_preference"];
	*/
	
	return NO;
}


- (IBAction) locTextTouched:(id)sender {
	[delegate lcTextFieldAction];
}

- (void) setSlider:(double)v withDir:(NSString*)diri {

	if([diri isEqualToString:@"false"] ) {
		[buttonDir setTitle:@"<" forState:UIControlStateNormal];
		dir = FALSE;
		stringDir = @"false";
	} else {
		[buttonDir setTitle:@">" forState:UIControlStateNormal];
		dir = TRUE;
		stringDir = @"true";
	}
	//NSLog(@" V : %f ",v);
  [slideView setValue:v];
}



- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	//[rrconnection stop];
}


- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[functionButtons dealloc];
	//[rrconnection dealloc];
    [super dealloc];
}

@end
