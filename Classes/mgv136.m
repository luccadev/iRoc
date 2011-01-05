//
//  mgv136.m
//  iRoc
//
//  Created by Jean-Michel Fischer on 05.01.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "mgv136.h"


@implementation mgv136
@synthesize reset, start, stop, rrconnection, menuname, leftPlus, leftMinus, rightPlus, rightMinus,
speedPlus, speedMinus, testPlus, testMinus;

- (id)init {
  if( self = [super init] ) {
		
  }  
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
	
	CGRect bounds = self.view.bounds;
	float buttonWidth = (bounds.size.width - (3 * CONTENTBORDER + BUTTONGAP)) / 3;
	double textHeight = 30;
	double buttonheight = 55;
	
	NSString * iid = [[Globals getDefaults] stringForKey:@"mgv136iid"];
	NSString * addr = [[Globals getDefaults] stringForKey:@"mgv136addr"];
	NSString * port = [[Globals getDefaults] stringForKey:@"mgv136port"];
	
	textIID = [[[UITextField alloc] initWithFrame:CGRectMake(CONTENTBORDER, CONTENTBORDER, buttonWidth, textHeight)] autorelease];						
	textIID.keyboardType = UIKeyboardTypeAlphabet;
	textIID.textColor = [UIColor blackColor];
	textIID.backgroundColor = [UIColor whiteColor];
	textIID.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	textIID.textAlignment = UITextAlignmentCenter;	
	textIID.clearsOnBeginEditing = YES;
	[textIID resignFirstResponder];
	textIID.text = iid;
	[self.view addSubview: textIID];
	
	textAddr = [[[UITextField alloc] initWithFrame:CGRectMake(CONTENTBORDER+buttonWidth+BUTTONGAP, CONTENTBORDER, buttonWidth, textHeight)] autorelease];						
	textAddr.keyboardType = UIKeyboardTypeNumberPad;
	textAddr.textColor = [UIColor blackColor];
	textAddr.backgroundColor = [UIColor whiteColor];
	textAddr.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	textAddr.textAlignment = UITextAlignmentCenter;	
	textAddr.clearsOnBeginEditing = YES;
	[textAddr resignFirstResponder];
	textAddr.text = addr;
	[self.view addSubview: textAddr];
	
	textPort = [[[UITextField alloc] initWithFrame:CGRectMake(CONTENTBORDER+(buttonWidth+BUTTONGAP)*2, CONTENTBORDER, buttonWidth, textHeight)] autorelease];						
	textPort.keyboardType = UIKeyboardTypeNumberPad;
	textPort.textColor = [UIColor blackColor];
	textPort.backgroundColor = [UIColor whiteColor];
	textPort.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	textPort.textAlignment = UITextAlignmentCenter;	
	textPort.clearsOnBeginEditing = YES;
	[textPort resignFirstResponder];
	textPort.text = port;
	[self.view addSubview: textPort];
	
	double w2 = (buttonWidth*2) + CONTENTBORDER + BUTTONGAP *2;
  
	CGRect resetFrame = CGRectMake(CONTENTBORDER, CONTENTBORDER + textHeight + BUTTONGAP, buttonWidth, buttonheight);
  reset = [[iRocButton alloc] initWithFrame:resetFrame];
  reset.frame = resetFrame;
  [reset setTitle: NSLocalizedString(@"Reset", @"") forState: UIControlStateNormal];
  [reset addTarget:self action:@selector(resetClicked:) forControlEvents:UIControlEventTouchUpInside];
  //[reset setColor:1];
  [self.view addSubview: reset];
	
	CGRect startFrame = CGRectMake(buttonWidth + CONTENTBORDER + BUTTONGAP, CONTENTBORDER + textHeight + BUTTONGAP, buttonWidth, buttonheight);
  start = [[iRocButton alloc] initWithFrame:startFrame];
  start.frame = startFrame;
  [start setTitle: NSLocalizedString(@"Start", @"") forState: UIControlStateNormal];
  [start addTarget:self action:@selector(startClicked:) forControlEvents:UIControlEventTouchUpInside];
  //[start setColor:1];
  [self.view addSubview: start];
	
	CGRect stopFrame = CGRectMake(w2, CONTENTBORDER + textHeight + BUTTONGAP, buttonWidth, buttonheight);
  stop = [[iRocButton alloc] initWithFrame:stopFrame];
  stop.frame = stopFrame;
  [stop setTitle: NSLocalizedString(@"Stop", @"") forState: UIControlStateNormal];
  [stop addTarget:self action:@selector(startClicked:) forControlEvents:UIControlEventTouchUpInside];
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
  NSLog(@"reset");
	NSString * stringToSend = [NSString stringWithFormat: @"<sw iid=\"%@\" addr1=\"%@\" port1=\"%@\" cmd=\"straight\"/>",
														 [textIID text], [textAddr text], [textPort text]];
	[rrconnection sendMessage:@"sw" message:stringToSend];
	
}

- (IBAction) startClicked:(id) sender {
	[self anyButtonClicked];
  NSLog(@"start");
	NSString * stringToSend = [NSString stringWithFormat: @"<sw iid=\"%@\" addr1=\"%@\" port1=\"%@\" cmd=\"turnout\"/>",
														 [textIID text], [textAddr text], [textPort text]];
	[rrconnection sendMessage:@"sw" message:stringToSend];
	
}

- (IBAction) stopClicked:(id) sender {
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
	[textIID resignFirstResponder];
	[textAddr resignFirstResponder];
	[textPort resignFirstResponder];
	
	[[Globals getDefaults] setObject:(NSString*)[textIID text] forKey:@"mgv136iid"];
	[[Globals getDefaults] setObject:(NSString*)[textAddr text] forKey:@"mgv136addr"];
	[[Globals getDefaults] setObject:(NSString*)[textPort text] forKey:@"mgv136port"];
}


@end
