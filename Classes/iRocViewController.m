//
//  iRocViewController.m
//  iRoc
//
//  Created by Jean-Michel Fischer on 17.11.09.
//  Copyright rocrail.net 2009. All rights reserved.
//
#import "iRocViewController.h"
#import "iRocButton.h"

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

- (IBAction) buttonDirClicked:(id) sender { 
  if([buttonFn getBState]) {
    NSString * stringToSend = [[NSString alloc] initWithString: [NSString stringWithFormat: @"<lc throttleid=\"%@\" cmd=\"release\" id=\"%@\"/>", 
                                                                 (NSString*)[[UIDevice currentDevice] name], [textfieldLoc text] ] ];
    [rrconnection sendMessage:@"lc" message:stringToSend];
  }
  else {
  
	if(dir) {
		[buttonDir setTitle:@"<" forState:UIControlStateNormal];
		dir = !dir;
		stringDir = @"false";
	} else {
		[buttonDir setTitle:@">" forState:UIControlStateNormal];
		dir = !dir;
		stringDir = @"true";
	}
	//AudioServicesPlaySystemSound (self.soundFileObject);

	[slideView setValue:0];	
	[rrconnection sendMessage:@"lc" message:[[NSString alloc] initWithString: [NSString stringWithFormat: @"<lc throttleid=\"%@\" id=\"%@\" V=\"0\" dir=\"%@\" fn=\"%@\"/>",
    (NSString*)[[UIDevice currentDevice] name],
    [textfieldLoc text], stringDir, [buttonF0 getBState]?@"true":@"false"]] ];
  }
}

- (IBAction) sliderMoved:(id) sender { 	
	Loc *lc = (Loc*)[delegate getLoc:[textfieldLoc text]];
	int vVal = [slideView value]*100*([lc getVmax]/100.00);
  
  if( processAll && (abs( prevVVal - vVal) < VDelta ) && vVal != 0 )
    return;
		
	if( prevVVal != vVal) {
    //NSLog(@"%@", [[UIDevice currentDevice] name]);

		NSString * stringToSend; 			
		stringToSend = [NSString stringWithFormat: @"<lc throttleid=\"%@\" id=\"%@\" V=\"%d\" dir=\"%@\" fn=\"%@\"/>", 
                    (NSString*)[[UIDevice currentDevice] name],
                    [textfieldLoc text], vVal, stringDir, [buttonF0 getBState]?@"true":@"false"];
		//NSLog(stringToSend);
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
    	
	NSString * stringToSend = [[NSString alloc] initWithString: 
                             [NSString stringWithFormat: @"<fn group=\"1\" id=\"%@\" f%d=\"%@\"/>", 
                              [textfieldLoc text], 0,  fnState?@"true":@"false" ] ];
	[rrconnection sendMessage:@"fn" message:stringToSend];
	
	
	[((iRocButton *)[functionButtons objectAtIndex:0]) setBState:fnState];
	
	/*
	for (int i = 0; i < 9; i++) {
		NSLog(@"F %d : %d", i, fnStates[i]);
	}
	*/
	
	//fnStates[0] = !fnStates[0];
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
	
	/*
	NSString * stringToSend = [[NSString alloc] initWithString: [NSString stringWithFormat: @"<fn group=\"1\" id=\"%@\" ", [textfieldLoc text]]];
	
	
	for (int i = 0; i < 9; i++) {		
		stringToSend = [stringToSend stringByAppendingString: [NSString stringWithFormat:@"f%d=\"%@\" ", i, fnStates[i]?@"true":@"false"] ];
	}
	stringToSend = [stringToSend stringByAppendingString: [NSString stringWithFormat:@"/>"] ];
	*/
	NSLog(@"FN: %@", stringToSend);
	
	
	//NSString * stringToSend = [[NSString alloc] initWithString: [NSString stringWithFormat: @"<fn group=\"1\" id=\"%@\" f%d=\"%@\"/>", [textfieldLoc text], fnIndex, fnStates[fnIndex]?@"true":@"false" ] ];
	//[rrconnection sendMessage:@"fn" message:stringToSend];
	
	[((iRocButton *)[functionButtons objectAtIndex:fnIndex]) setBState:fnState];
	
	//AudioServicesPlaySystemSound (self.soundFileObject);
}

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
 */

- (IBAction)doneButton:(id)sender {
	AudioServicesPlaySystemSound (self.soundFileObject);
    [textfieldLoc resignFirstResponder];
	
  [self updateFnState];

	// Save in Settings
	[[NSUserDefaults standardUserDefaults] setObject:(NSString*)[textfieldLoc text] forKey:@"loc_preference"];
	
	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
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
	
	if( [[NSUserDefaults standardUserDefaults] boolForKey:@"locenter_preference"]) {
		
		[self.view addSubview:textfieldLoc];
		
		[textfieldLoc setKeyboardType:UIKeyboardTypeNumberPad];
			
		// Adding a DONE Button to the Numpad:
		[[NSNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(keyboardWillShow:) 
													 name:UIKeyboardWillShowNotification 
												   object:nil];			
		
		
	}
	
	
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
	
	if( ![[NSUserDefaults standardUserDefaults] boolForKey:@"locenter_preference"]){
		[delegate lcTextFieldAction];
		
	}
	
	return [[NSUserDefaults standardUserDefaults] boolForKey:@"locenter_preference"];
}


- (IBAction) locTextTouched:(id)sender {
	[delegate lcTextFieldAction];
}

- (void) setSlider:(int)v withDir:(NSString*)diri {
	
	/*
	if([diri isEqualToString:@"false"] ) {
		[buttonDir setTitle:@"<" forState:UIControlStateNormal];
		dir = !dir;
		stringDir = @"false";
	} else {
		[buttonDir setTitle:@">" forState:UIControlStateNormal];
		dir = !dir;
		stringDir = @"true";
	}
		 
		[slideView setValue:v];
	 */
	
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
