//
//  iRocViewController.m
//  iRoc
//
//  Created by Jean-Michel Fischer on 17.11.09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "iRocViewController.h"

@implementation iRocViewController

@synthesize button; 
@synthesize buttonAutoOff; 
@synthesize buttonDir; 
@synthesize slider; 
@synthesize messageLabel;
@synthesize textfieldLoc;

IRocConnector *rrconnection;
NSString * stringDir; 

- (IBAction) buttonClicked:(id) sender { 

	[rrconnection sendMessage:@"auto" message:@"<auto cmd=\"on\"/>"];
	
	[self setLabel:@"Auto ON"];
}

- (IBAction) buttonAutoOffClicked:(id) sender { 
	
	[rrconnection sendMessage:@"auto" message:@"<auto cmd=\"off\"/>"];
	
	[self setLabel:@"Auto OFF"];
}

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
	
	[slider setValue:0];
	
	NSString * stringToSend; 			
	stringToSend = [NSString stringWithFormat: @"<lc id=\"114\" V=\"0\"  fn=\"true\"  dir=\"%@\"/>", stringDir];
	[rrconnection sendMessage:@"lc" message:stringToSend];
}

- (IBAction) sliderMoved:(id) sender { 	
	
	NSString * stringToSend; 			
	stringToSend = [NSString stringWithFormat: @"<lc id=\"114\" V=\"%f\"  fn=\"true\"  dir=\"%@\"/>", [slider value]*100, stringDir];
	
	[rrconnection sendMessage:@"lc" message:stringToSend];
	
	[self setLabel:stringToSend];
}

- (void) setLabel:(id) message {
	[messageLabel setText:message];
}

- (IBAction) textFieldDone:(id) sender {
	
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



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	//[slider setThumbImage:[UIImage imageNamed:@"thumb.png"] forState:UIControlStateNormal];

	
	dir = false;
	stringDir = @"true";
	[buttonDir setTitle:@">" forState:UIControlStateNormal];
	
	rrconnection = [[IRocConnector alloc] init];
	[rrconnection start];
	
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
    [super dealloc];
}

@end
