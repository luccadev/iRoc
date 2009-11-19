//
//  iRocViewController.m
//  iRoc
//
//  Created by Jean-Michel Fischer on 17.11.09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//
#import "iRocViewController.h"

@implementation iRocViewController

@synthesize buttonDir; 
@synthesize slider; 
@synthesize textfieldLoc;
@synthesize slideView;

IRocConnector *rrconnection;
NSString * stringDir; 

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
	
	//[slider setValue:0];
	
	NSString * stringToSend; 			
	stringToSend = [NSString stringWithFormat: @"<lc id=\"%@\" V=\"0\"  fn=\"true\"  dir=\"%@\"/>",[textfieldLoc text], stringDir];
	[rrconnection sendMessage:@"lc" message:stringToSend];
}

- (IBAction) sliderMoved:(id) sender { 	
	
	int vVal = [slideView value]*100;
		
	if( prevVVal != vVal) {
		NSString * stringToSend; 			
		stringToSend = [NSString stringWithFormat: @"<lc id=\"%@\" V=\"%d\"  fn=\"true\"  dir=\"%@\"/>", [textfieldLoc text], vVal, stringDir];
		NSLog(stringToSend);
		//[self setLabel:stringToSend];
		[rrconnection sendMessage:@"lc" message:stringToSend];
	}
	
		prevVVal = vVal;

}

- (IBAction) textFieldDone:(id) sender {
	NSLog(@"Keyboard Done Pressed");
	
	[textfieldLoc resignFirstResponder];
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


- (void)doneButton:(id)sender {
    NSLog(@"Input: XKJSBCKJBLKJADSV");
    [textfieldLoc resignFirstResponder];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	// Adding a DONE Button to the Numpad:
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(keyboardWillShow:) 
												 name:UIKeyboardWillShowNotification 
											   object:nil];	
	
	
	
	prevVVal = 0;
	dir = true;
	stringDir = @"true";
	[buttonDir setTitle:@">" forState:UIControlStateNormal];
	
	rrconnection = [[IRocConnector alloc] init];
	[rrconnection start];
	
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
    UIView* keyboard;
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

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

@end
