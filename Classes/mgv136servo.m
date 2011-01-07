//
//  mgv136servo.m
//  iRoc
//
//  Created by Jean-Michel Fischer on 07.01.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "mgv136servo.h"


@implementation mgv136servo
@synthesize stop, rrconnection, menuname, leftPlus, leftMinus, rightPlus, rightMinus,
speedPlus, speedMinus, testPlus, testMinus;


- (id)initWithDelegate:(id)_delegate {
  if( self = [super init] ) {
    delegate = _delegate;
  }  
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
	
	CGRect bounds = self.view.bounds;
	float buttonWidth = (bounds.size.width - (3 * CONTENTBORDER + BUTTONGAP)) / 3;
	double textHeight = 30;
	double buttonheight = 55;
	


double w2 = (buttonWidth*2) + CONTENTBORDER + BUTTONGAP *2;

CGRect stopFrame = CGRectMake(w2, CONTENTBORDER + textHeight + BUTTONGAP, buttonWidth, buttonheight);
stop = [[iRocButton alloc] initWithFrame:stopFrame];
stop.frame = stopFrame;
[stop setTitle: NSLocalizedString(@"Stop", @"") forState: UIControlStateNormal];
[stop addTarget:self action:@selector(stopClicked:) forControlEvents:UIControlEventTouchUpInside];
//[stop setColor:1];
[self.view addSubview: stop];

double h = CONTENTBORDER + textHeight + buttonheight + BUTTONGAP * 2;


leftPlus = [[iRocButton alloc] initWithFrame:CGRectMake(CONTENTBORDER , h, buttonWidth, buttonheight)];
[leftPlus setTitle: NSLocalizedString(@"+", @"") forState: UIControlStateNormal];
[leftPlus addTarget:self action:@selector(leftPlusClicked:) forControlEvents:UIControlEventTouchUpInside];
//[leftPlus setColor:1];
[self.view addSubview: leftPlus];

leftMinus = [[iRocButton alloc] initWithFrame:CGRectMake(w2, h, buttonWidth, buttonheight)];
[leftMinus setTitle: NSLocalizedString(@"-", @"") forState: UIControlStateNormal];
[leftMinus addTarget:self action:@selector(leftMinusClicked:) forControlEvents:UIControlEventTouchUpInside];
//[leftMinus setColor:2];
[self.view addSubview: leftMinus];

h = h + buttonheight + BUTTONGAP;

rightPlus = [[iRocButton alloc] initWithFrame:CGRectMake(CONTENTBORDER , h, buttonWidth, buttonheight)];
[rightPlus setTitle: NSLocalizedString(@"+", @"") forState: UIControlStateNormal];
[rightPlus addTarget:self action:@selector(rightPlusClicked:) forControlEvents:UIControlEventTouchUpInside];
//[rightPlus setColor:1];
[self.view addSubview: rightPlus];

rightMinus = [[iRocButton alloc] initWithFrame:CGRectMake(w2, h, buttonWidth, buttonheight)];
[rightMinus setTitle: NSLocalizedString(@"-", @"") forState: UIControlStateNormal];
[rightMinus addTarget:self action:@selector(rightMinusClicked:) forControlEvents:UIControlEventTouchUpInside];
//[rightMinus setColor:2];
[self.view addSubview: rightMinus];

h = h + buttonheight + BUTTONGAP;

speedPlus = [[iRocButton alloc] initWithFrame:CGRectMake(CONTENTBORDER , h, buttonWidth, buttonheight)];
[speedPlus setTitle: NSLocalizedString(@"+", @"") forState: UIControlStateNormal];
[speedPlus addTarget:self action:@selector(speedPlusClicked:) forControlEvents:UIControlEventTouchUpInside];
//[speedPlus setColor:1];
[self.view addSubview: speedPlus];

speedMinus = [[iRocButton alloc] initWithFrame:CGRectMake(w2, h, buttonWidth, buttonheight)];
[speedMinus setTitle: NSLocalizedString(@"-", @"") forState: UIControlStateNormal];
[speedMinus addTarget:self action:@selector(speedMinusClicked:) forControlEvents:UIControlEventTouchUpInside];
//[speedMinus setColor:2];
[self.view addSubview: speedMinus];

h = h + buttonheight + BUTTONGAP;

testPlus = [[iRocButton alloc] initWithFrame:CGRectMake(CONTENTBORDER , h, buttonWidth, buttonheight)];
[testPlus setTitle: NSLocalizedString(@"+", @"") forState: UIControlStateNormal];
[testPlus addTarget:self action:@selector(testPlusClicked:) forControlEvents:UIControlEventTouchUpInside];
//[testPlus setColor:1];
[self.view addSubview: testPlus];

testMinus = [[iRocButton alloc] initWithFrame:CGRectMake(w2, h, buttonWidth, buttonheight)];
[testMinus setTitle: NSLocalizedString(@"-", @"") forState: UIControlStateNormal];
[testMinus addTarget:self action:@selector(testMinusClicked:) forControlEvents:UIControlEventTouchUpInside];
//[testMinus setColor:2];
[self.view addSubview: testMinus];

}

- (IBAction) resetClicked:(id) sender {
	[self anyButtonClicked];
  	
}

- (IBAction) startClicked:(id) sender {
	[self anyButtonClicked];
 	
}

- (IBAction) stopClicked:(id) sender {
	
	
	NSLog(@"STOP");
	
	[delegate dismissModalViewController];
}

- (IBAction) leftPlusClicked:(id) sender {
}

- (IBAction) leftMinusClicked:(id) sender {
}


- (IBAction) rightPlusClicked:(id) sender {
}

- (IBAction) rightMinusClicked:(id) sender {
}


- (IBAction) speedPlusClicked:(id) sender {
}

- (IBAction) speedMinusClicked:(id) sender {
}


- (IBAction) testPlusClicked:(id) sender {
}

- (IBAction) testMinusClicked:(id) sender {
}


- (void) setBit:(int)addr port:(int)port on:(bool) on {
	
}
- (void) sendNibble:(int) value {
	
}

- (void) anyButtonClicked {

}



@end
