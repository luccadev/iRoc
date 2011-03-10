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

#import "mgv136.h"


@implementation mgv136
@synthesize reset, start, stop, rrconnection, menuname, leftPlus, leftMinus, rightPlus, rightMinus,
speedPlus, speedMinus, testPlus, testMinus;

- (id)initWithDelegate:(id)_delegate {
  if( self = [super init] ) {
    delegate = _delegate;
		
		servoView = [[mgv136servo alloc] initWithDelegate:delegate];

  }  
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
	
		/**VON**/
	CGRect bounds1 = [[UIScreen mainScreen] applicationFrame];
	scrollView = [[UIScrollView alloc] initWithFrame: bounds1];
	CGSize plansize = CGSizeMake(ITEMSIZE*80, ITEMSIZE*60);	
	scrollView.contentSize = plansize;
	scrollView.delegate = self;
		/**BIS**/

	
	CGRect bounds = self.view.bounds;
	float buttonWidth = (bounds.size.width - (3 * CONTENTBORDER + BUTTONGAP)) / 3;
	double textHeight = 30;
	double buttonheight = 55;
	
	NSString * iid = [[Globals getDefaults] stringForKey:@"mgv136iid"];
	NSString * addr = [[Globals getDefaults] stringForKey:@"mgv136addr"];
	NSString * port = [[Globals getDefaults] stringForKey:@"mgv136port"];

	//double w0 = CONTENTBORDER;
	double w1 = (buttonWidth) + CONTENTBORDER + BUTTONGAP;
	double w2 = (buttonWidth*2) + CONTENTBORDER + BUTTONGAP *2;
  	
	double h = CONTENTBORDER;

	CGRect resetFrame = CGRectMake(w1, h, buttonWidth, buttonheight);
	reset = [[iRocButton alloc] initWithFrame:resetFrame];
	reset.frame = resetFrame;
	[reset setTitle: NSLocalizedString(@"Reset", @"") forState: UIControlStateNormal];
	[reset addTarget:self action:@selector(resetClicked:) forControlEvents:UIControlEventTouchUpInside];
	//[reset setColor:1];
	[self.view addSubview: reset];
	
	CGRect startFrame = CGRectMake(w2, h, buttonWidth, buttonheight);
	start = [[iRocButton alloc] initWithFrame:startFrame];
	start.frame = startFrame;
	[start setTitle: NSLocalizedString(@"Start", @"") forState: UIControlStateNormal];
	[start addTarget:self action:@selector(startClicked:) forControlEvents:UIControlEventTouchUpInside];
	//[start setColor:1];
	[self.view addSubview: start];
	
	h = h + buttonheight + BUTTONGAP;
	
	textIID = [[[UITextField alloc] initWithFrame:CGRectMake(w1, h, buttonWidth*2 + BUTTONGAP, textHeight)] autorelease];						
	textIID.keyboardType = UIKeyboardTypeAlphabet;
	textIID.textColor = [UIColor blackColor];
	textIID.backgroundColor = [UIColor whiteColor];
	textIID.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	textIID.textAlignment = UITextAlignmentCenter;	
	textIID.clearsOnBeginEditing = YES;
	[textIID resignFirstResponder];
	textIID.text = iid;
	[self.view addSubview: textIID];
	
	 
	h = h + textHeight + BUTTONGAP;
	
	textAddr1 = [[[UITextField alloc] initWithFrame:CGRectMake(w1, h, buttonWidth, textHeight)] autorelease];						
	textAddr1.keyboardType = UIKeyboardTypeNumberPad;
	textAddr1.textColor = [UIColor blackColor];
	textAddr1.backgroundColor = [UIColor whiteColor];
	textAddr1.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	textAddr1.textAlignment = UITextAlignmentCenter;	
	textAddr1.clearsOnBeginEditing = YES;
	[textAddr1 resignFirstResponder];
	textAddr1.text = addr;
	[self.view addSubview: textAddr1];
	
	textPort1 = [[[UITextField alloc] initWithFrame:CGRectMake(w2, h, buttonWidth, textHeight)] autorelease];						
	textPort1.keyboardType = UIKeyboardTypeNumberPad;
	textPort1.textColor = [UIColor blackColor];
	textPort1.backgroundColor = [UIColor whiteColor];
	textPort1.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	textPort1.textAlignment = UITextAlignmentCenter;	
	textPort1.clearsOnBeginEditing = YES;
	[textPort1 resignFirstResponder];
	textPort1.text = port;
	[self.view addSubview: textPort1];
	
	h = h + textHeight + BUTTONGAP;
	
	textAddr2 = [[[UITextField alloc] initWithFrame:CGRectMake(w1, h, buttonWidth, textHeight)] autorelease];						
	textAddr2.keyboardType = UIKeyboardTypeNumberPad;
	textAddr2.textColor = [UIColor blackColor];
	textAddr2.backgroundColor = [UIColor whiteColor];
	textAddr2.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	textAddr2.textAlignment = UITextAlignmentCenter;	
	textAddr2.clearsOnBeginEditing = YES;
	[textAddr2 resignFirstResponder];
	textAddr2.text = addr;
	[self.view addSubview: textAddr2];
	
	textPort2 = [[[UITextField alloc] initWithFrame:CGRectMake(w2, h, buttonWidth, textHeight)] autorelease];						
	textPort2.keyboardType = UIKeyboardTypeNumberPad;
	textPort2.textColor = [UIColor blackColor];
	textPort2.backgroundColor = [UIColor whiteColor];
	textPort2.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	textPort2.textAlignment = UITextAlignmentCenter;	
	textPort2.clearsOnBeginEditing = YES;
	[textPort2 resignFirstResponder];
	textPort2.text = port;
	[self.view addSubview: textPort2];
	
	h = h + textHeight + BUTTONGAP;
	
	textAddr3 = [[[UITextField alloc] initWithFrame:CGRectMake(w1, h, buttonWidth, textHeight)] autorelease];						
	textAddr3.keyboardType = UIKeyboardTypeNumberPad;
	textAddr3.textColor = [UIColor blackColor];
	textAddr3.backgroundColor = [UIColor whiteColor];
	textAddr3.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	textAddr3.textAlignment = UITextAlignmentCenter;	
	textAddr3.clearsOnBeginEditing = YES;
	[textAddr3 resignFirstResponder];
	textAddr3.text = addr;
	[self.view addSubview: textAddr3];
	
	textPort3 = [[[UITextField alloc] initWithFrame:CGRectMake(w2, h, buttonWidth, textHeight)] autorelease];						
	textPort3.keyboardType = UIKeyboardTypeNumberPad;
	textPort3.textColor = [UIColor blackColor];
	textPort3.backgroundColor = [UIColor whiteColor];
	textPort3.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	textPort3.textAlignment = UITextAlignmentCenter;	
	textPort3.clearsOnBeginEditing = YES;
	[textPort3 resignFirstResponder];
	textPort3.text = port;
	[self.view addSubview: textPort3];
	
	h = h + textHeight + BUTTONGAP;
	
	textAddr4 = [[[UITextField alloc] initWithFrame:CGRectMake(w1, h, buttonWidth, textHeight)] autorelease];						
	textAddr4.keyboardType = UIKeyboardTypeNumberPad;
	textAddr4.textColor = [UIColor blackColor];
	textAddr4.backgroundColor = [UIColor whiteColor];
	textAddr4.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	textAddr4.textAlignment = UITextAlignmentCenter;	
	textAddr4.clearsOnBeginEditing = YES;
	[textAddr4 resignFirstResponder];
	textAddr4.text = addr;
	[self.view addSubview: textAddr4];
	
	textPort4 = [[[UITextField alloc] initWithFrame:CGRectMake(w2, h, buttonWidth, textHeight)] autorelease];						
	textPort4.keyboardType = UIKeyboardTypeNumberPad;
	textPort4.textColor = [UIColor blackColor];
	textPort4.backgroundColor = [UIColor whiteColor];
	textPort4.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	textPort4.textAlignment = UITextAlignmentCenter;	
	textPort4.clearsOnBeginEditing = YES;
	[textPort4 resignFirstResponder];
	textPort4.text = port;
	[self.view addSubview: textPort4];
	
}

- (IBAction) resetClicked:(id) sender {
	[self anyButtonClicked];
  NSLog(@"reset");
	NSString * stringToSend = [NSString stringWithFormat: @"<sw iid=\"%@\" addr1=\"%@\" port1=\"%@\" cmd=\"straight\"/>",
														 [textIID text], [textAddr1 text], [textPort1 text]];
	[rrconnection sendMessage:@"sw" message:stringToSend];
	
}

- (IBAction) startClicked:(id) sender {
	[self anyButtonClicked];
	[delegate presentModalViewController:servoView animated:YES];
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
	[textAddr1 resignFirstResponder];
	[textPort1 resignFirstResponder];
	
	[[Globals getDefaults] setObject:(NSString*)[textIID text] forKey:@"mgv136iid"];
	[[Globals getDefaults] setObject:(NSString*)[textAddr1 text] forKey:@"mgv136addr"];
	[[Globals getDefaults] setObject:(NSString*)[textPort1 text] forKey:@"mgv136port"];
}


@end
