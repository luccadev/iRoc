//
//  iRocBlockView.m
//  iRoc
//
//  Created by Jean-Michel Fischer on 30.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "iRocBlockView.h"
#import "Globals.h"


@implementation iRocBlockView
@synthesize selectLoc, _delegate;


- (void)loadView {
  [super loadView];
  [super.view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0]];
  
  CGRect bounds = self.view.bounds;
  float buttonWidth = (bounds.size.width - (2 * CONTENTBORDER + BUTTONGAP)) / 2;
  CGRect selectLocFrame = CGRectMake(CONTENTBORDER, CONTENTBORDER, buttonWidth, BUTTONHEIGHT);
  selectLoc = [[iRocButton alloc] initWithFrame:selectLocFrame];
  selectLoc.frame = selectLocFrame;
  [selectLoc setTitle: NSLocalizedString(@"Set Loco", @"") forState: UIControlStateNormal];
  [selectLoc addTarget:self action:@selector(selectLocClicked:) forControlEvents:UIControlEventTouchUpInside];
  [selectLoc setColor:2];
  //[selectLoc setBState:Power];
  [self.view addSubview: selectLoc];
}

- (IBAction) selectLocClicked:(id) sender {
	
	[_delegate dismissModalViewController];
	
  //TODO: something like that ...
	//[_delegate lcTextFieldAction];
	
	
	
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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
