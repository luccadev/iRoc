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

- (IBAction) sliderMoved:(id) sender { 	
	
	int vVal = [slideView value]*100;
  
  if( processAll && abs( prevVVal - vVal) < VDelta )
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


- (IBAction) buttonF0Clicked:(id) sender {	
	fnStates[0] = !fnStates[0];

	[rrconnection sendMessage:@"lc" message:[[NSString alloc] initWithString: [NSString stringWithFormat: @"<lc throttleid=\"%@\" id=\"%@\" fn=\"%@\"/>",
    (NSString*)[[UIDevice currentDevice] name], [textfieldLoc text], fnStates[0]?@"true":@"false"]] ];
    	
	NSString * stringToSend = [[NSString alloc] initWithString: [NSString stringWithFormat: @"<fn group=\"1\" id=\"%@\" f%d=\"%@\"/>", [textfieldLoc text], 0,  fnStates[0]?@"true":@"false" ] ];
	[rrconnection sendMessage:@"fn" message:stringToSend];
	
	
	[((iRocButton *)[functionButtons objectAtIndex:0]) setBState:fnStates[0]];
	
	/*
	for (int i = 0; i < 9; i++) {
		NSLog(@"F %d : %d", i, fnStates[i]);
	}
	*/
	
	//fnStates[0] = !fnStates[0];
}
- (IBAction) buttonF1Clicked:(id) sender {
	[self prepareFNCommand:1];
}
- (IBAction) buttonF2Clicked:(id) sender {
	[self prepareFNCommand:2];
}
- (IBAction) buttonF3Clicked:(id) sender {
	[self prepareFNCommand:3];
}
- (IBAction) buttonF4Clicked:(id) sender {
	[self prepareFNCommand:4];
}
- (IBAction) buttonF5Clicked:(id) sender {
	[self prepareFNCommand:5];
}
- (IBAction) buttonF6Clicked:(id) sender {
	[self prepareFNCommand:6];
}
- (IBAction) buttonF7Clicked:(id) sender {
	[self prepareFNCommand:7];
}
- (IBAction) buttonF8Clicked:(id) sender {
	[self prepareFNCommand:8];
}
- (IBAction) buttonFnClicked:(id) sender {
	NSString * stringToSend = [[NSString alloc] initWithString: [NSString stringWithFormat: @"<lc throttleid=\"%@\" cmd=\"release\" id=\"%@\"/>", 
    (NSString*)[[UIDevice currentDevice] name], [textfieldLoc text] ] ];
	[rrconnection sendMessage:@"lc" message:stringToSend];
}

- (void) processAllEvents:(int) _VDelta {
  VDelta = _VDelta;
  processAll = TRUE;
} 


- (void) prepareFNCommand:(int) fnIndex {
	fnStates[fnIndex] = !fnStates[fnIndex];
	
	int tmp = (fnIndex-1)/4 +1;
	NSLog(@"FNG: %d", tmp);
	
	
	NSString * stringToSend = [[NSString alloc] initWithString: [NSString stringWithFormat: @"<fn group=\"%d\" id=\"%@\" f%d=\"%@\"/>", tmp, [textfieldLoc text], fnIndex,  fnStates[fnIndex]?@"true":@"false" ] ];
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
	
	[((iRocButton *)[functionButtons objectAtIndex:fnIndex]) setBState:fnStates[fnIndex]];
	
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
	
	// Reset Fuction states TODO: this has be be later read from rr
	for(int i = 0; i < 9; i++) {
		fnStates[i] = FALSE; 
		[((iRocButton *)[functionButtons objectAtIndex:i]) setBState:fnStates[i]];
	}
	
	// Light on on init
	fnStates[0] = TRUE;
	[buttonF0 setBState:TRUE];

	// Save in Settings
	[[NSUserDefaults standardUserDefaults] setObject:(NSString*)[textfieldLoc text] forKey:@"loc_preference"];
	
	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	// read preferences
	defaults = [[NSUserDefaults standardUserDefaults] retain];
	
	functionButtons = [[NSArray arrayWithObjects:buttonF0,buttonF1,buttonF2,buttonF3,buttonF4,buttonF5,buttonF6,buttonF7,buttonF8,nil] retain];
	
	
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
	
	// Fuction states
	for(int i = 0; i < 9; i++)
		fnStates[i] = FALSE; 
	
	fnStates[0] = TRUE;
	[buttonF0 setBState:TRUE];
	
	prevVVal = 0;
	dir = true;
	stringDir = @"true";
	[buttonDir setTitle:@">" forState:UIControlStateNormal];
	
	ip = [defaults stringForKey:@"ip_preference"];
	
	textfieldLoc.text = [defaults stringForKey:@"loc_preference"];
	locProps.idLabel.text = [defaults stringForKey:@"loc_preference"];
  locProps.delegate = delegate;
  //locProps.loc = nil;

	
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
