/*
 Rocrail - Model Railroad Software
 
 Copyright (C) 2009-2011 - Rob Versluis <r.j.versluis@rocrail.net>, Jean-Michel Fischer <jmf@polygonpunkt.de>
 
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

#import "mgv136servo.h"


@implementation mgv136servo
@synthesize stop, rrconnection, menuname, leftPlus, leftMinus, rightPlus, rightMinus,
speedPlus, speedMinus, testPlus, testMinus, servo1, servo2, servo3, servo4;


- (id)initWithDelegate:(id)_delegate {
  if( (self = [super init]) ) {
    delegate = _delegate;
  }  
    
  return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	CGRect bounds = self.view.bounds;
	float buttonWidth = (bounds.size.width - (3 * CONTENTBORDER + BUTTONGAP)) / 3;
	float buttonWidth4 = (bounds.size.width - (4 * CONTENTBORDER + BUTTONGAP)) / 4;
	//double textHeight = 30;
	double buttonheight = 55;
	
	double w2 = (buttonWidth*2) + CONTENTBORDER + BUTTONGAP *2;	
	double h = CONTENTBORDER;
	
	double ws = CONTENTBORDER;
	servo1 = [[iRocButton alloc] initWithFrame:CGRectMake(ws , h, buttonWidth4, buttonheight)];
	[servo1 setTitle: NSLocalizedString(@"1", @"") forState: UIControlStateNormal];
	[servo1 addTarget:self action:@selector(servo1Clicked:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview: servo1];
	
	ws = ws + buttonWidth4 + BUTTONGAP;
	servo2 = [[iRocButton alloc] initWithFrame:CGRectMake(ws, h, buttonWidth4, buttonheight)];
	[servo2 setTitle: NSLocalizedString(@"2", @"") forState: UIControlStateNormal];
	[servo2 addTarget:self action:@selector(servo2Clicked:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview: servo2];
	
	ws = ws + buttonWidth4 + BUTTONGAP;
	servo3 = [[iRocButton alloc] initWithFrame:CGRectMake(ws, h, buttonWidth4, buttonheight)];
	[servo3 setTitle: NSLocalizedString(@"3", @"") forState: UIControlStateNormal];
	[servo3 addTarget:self action:@selector(servo3Clicked:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview: servo3];
	
	ws = ws + buttonWidth4 + BUTTONGAP;
	servo4 = [[iRocButton alloc] initWithFrame:CGRectMake(ws, h, buttonWidth4, buttonheight)];
	[servo4 setTitle: NSLocalizedString(@"4", @"") forState: UIControlStateNormal];
	[servo4 addTarget:self action:@selector(servo4Clicked:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview: servo4];
	
	h = h + buttonheight + BUTTONGAP + 20;
	
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
	
	h = h + buttonheight + BUTTONGAP + 20;
	
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
	
	h = h + buttonheight + BUTTONGAP + 20;
	
	CGRect stopFrame = CGRectMake(w2, h, buttonWidth, buttonheight);
	stop = [[iRocButton alloc] initWithFrame:stopFrame];
	stop.frame = stopFrame;
	[stop setTitle: NSLocalizedString(@"Done", @"") forState: UIControlStateNormal];
	[stop addTarget:self action:@selector(stopClicked:) forControlEvents:UIControlEventTouchUpInside];
	//[stop setColor:1];
	[self.view addSubview: stop];
    
    
    [servo1 setLED];
    [servo2 setLED];
    [servo3 setLED];
    [servo4 setLED];
	
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

- (IBAction) servo1Clicked:(id) sender {
	[servo1 setBState:true];
	[servo2 setBState:false];
	[servo3 setBState:false];
	[servo4 setBState:false];
    

}
- (IBAction) servo2Clicked:(id) sender {
	[servo1 setBState:false];
	[servo2 setBState:true];
	[servo3 setBState:false];
	[servo4 setBState:false];
}
- (IBAction) servo3Clicked:(id) sender {
	[servo1 setBState:false];
	[servo2 setBState:false];
	[servo3 setBState:true];
	[servo4 setBState:false];
}
- (IBAction) servo4Clicked:(id) sender {
	[servo1 setBState:false];
	[servo2 setBState:false];
	[servo3 setBState:false];
	[servo4 setBState:true];
}

- (void) setBit:(int)addr port:(int)port on:(bool) on {
	
}
- (void) sendNibble:(int) value {
	
}

- (void) anyButtonClicked {

}



@end
