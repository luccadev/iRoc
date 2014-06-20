/*
 Rocrail - Model Railroad Software
 
 Copyright (C) 2009-2014 - Rob Versluis <r.j.versluis@rocrail.net>
 
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

#import "GuestLocoView.h"
#import "Globals.h"

@interface GuestLocoView ()

@end

@implementation GuestLocoView

@synthesize detailView;
@synthesize delegate;
@synthesize rrconnection, menuname;

- (id)initWithDelegate:(id)_delegate andModel:(Model*)_model {
  if( self = [super init] ) {
    self.delegate = _delegate;
    model = _model;
  }
  return self;
}


- (IBAction) buttonAddClicked:(id) sender {
  NSLog(@"addr=%@ shortID=%@ speedsteps=%@ protocol=%@", textAddr.text, textID.text, speedStepsText, protocolText);
	NSString * stringToSend = [[NSString alloc]  initWithString: [NSString stringWithFormat: @"<lc id=\"%@\" shortid=\"%@\" spcnt=\"%@\" prot=\"%@\" V=\"0\"/>",
                             textAddr.text, textID.text, speedStepsText, protocolText] ];
  [rrconnection sendMessage:@"sys" message:stringToSend];
}

-(void) protocolClicked:(id)sender{
  UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
  protocolText = [segmentedControl titleForSegmentAtIndex: [segmentedControl selectedSegmentIndex]];
}

-(void) speedStepsClicked:(id)sender{
  UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
  speedStepsText = [segmentedControl titleForSegmentAtIndex: [segmentedControl selectedSegmentIndex]];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  CGRect bounds = self.view.bounds;
  float width = bounds.size.width;
  float buttonWidth = (bounds.size.width - (2 * CONTENTBORDER + BUTTONGAP)) / 2;
  
  UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((width-buttonWidth)/2, BUTTONGAP, buttonWidth, BUTTONHEIGHT)];
  label.font = [UIFont boldSystemFontOfSize:22];
  //label.textColor = celltextcolor;
  label.backgroundColor = [UIColor clearColor];
  label.textAlignment = UITextAlignmentCenter;
  label.text = NSLocalizedString(@"Guest Loco",@"");
  [self.view addSubview:label];
  
  label = [[UILabel alloc] initWithFrame:CGRectMake(CONTENTBORDER, BUTTONGAP + 1 * BUTTONHEIGHT, buttonWidth, TEXTHEIGHT)];
  label.font = [UIFont boldSystemFontOfSize:18];
  label.textColor = [Globals getTextColor];
  label.backgroundColor = [UIColor clearColor];
  label.text = NSLocalizedString(@"Address",@"");
  [self.view addSubview:label];
  
  
  textAddr = [[[UITextField alloc] initWithFrame:CGRectMake(CONTENTBORDER + BUTTONGAP + buttonWidth, BUTTONGAP + 1 * BUTTONHEIGHT, buttonWidth, TEXTHEIGHT )] autorelease];
	textAddr.keyboardType = UIKeyboardTypeNumberPad;
	//textAddr.textColor = [Globals getTextColor];
	textAddr.backgroundColor = [UIColor whiteColor];
	textAddr.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	textAddr.textAlignment = UITextAlignmentCenter;
	textAddr.clearsOnBeginEditing = YES;
	[textAddr resignFirstResponder];
	textAddr.text = @"";
  textAddr.delegate = self;
	[self.view addSubview: textAddr];
	
  
  label = [[UILabel alloc] initWithFrame:CGRectMake(CONTENTBORDER, 2 * BUTTONGAP + 2 * BUTTONHEIGHT, buttonWidth, TEXTHEIGHT)];
  label.font = [UIFont boldSystemFontOfSize:18];
  label.textColor = [Globals getTextColor];
  label.backgroundColor = [UIColor clearColor];
  label.text = NSLocalizedString(@"Short ID",@"");
  [self.view addSubview:label];
  
  textID = [[[UITextField alloc] initWithFrame:CGRectMake(CONTENTBORDER + BUTTONGAP + buttonWidth, 2 * BUTTONGAP + 2 * BUTTONHEIGHT, buttonWidth, TEXTHEIGHT )] autorelease];
	textID.keyboardType = UIKeyboardTypeAlphabet;
	//textID.textColor = [UIColor blackColor];
	textID.backgroundColor = [UIColor whiteColor];
	textID.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	textID.textAlignment = UITextAlignmentCenter;
	textID.clearsOnBeginEditing = YES;
	[textID resignFirstResponder];
  textID.delegate = self;
	textID.text = @"";
	[self.view addSubview: textID];
  
  label = [[UILabel alloc] initWithFrame:CGRectMake(CONTENTBORDER, 3 * BUTTONGAP + 3 * BUTTONHEIGHT, buttonWidth, TEXTHEIGHT)];
  label.font = [UIFont boldSystemFontOfSize:18];
  label.textColor = [Globals getTextColor];
  label.backgroundColor = [UIColor clearColor];
  label.text = NSLocalizedString(@"Speed steps",@"");
  [self.view addSubview:label];
  
  NSArray *itemArray = [NSArray arrayWithObjects: @"14", @"28", @"128", nil];
  speedSteps = [[UISegmentedControl alloc] initWithItems:itemArray];
  speedSteps.frame = CGRectMake(CONTENTBORDER + BUTTONGAP + buttonWidth, 3 * BUTTONGAP + 3 * BUTTONHEIGHT, buttonWidth, TEXTHEIGHT);
  speedSteps.segmentedControlStyle = UISegmentedControlStylePlain;
  speedSteps.selectedSegmentIndex = 1;
  [speedSteps addTarget:self action:@selector(speedStepsClicked:) forControlEvents:UIControlEventValueChanged];
  //speedSteps.backgroundColor = [UIColor colorWithRed:0 green:1 blue:1 alpha:1.0];
  [self.view addSubview:speedSteps];
  speedStepsText = @"28";
  
  label = [[UILabel alloc] initWithFrame:CGRectMake(CONTENTBORDER, 4 * BUTTONGAP + 4 * BUTTONHEIGHT, buttonWidth, TEXTHEIGHT)];
  label.font = [UIFont boldSystemFontOfSize:18];
  label.textColor = [Globals getTextColor];
  label.backgroundColor = [UIColor clearColor];
  label.text = NSLocalizedString(@"Protocol",@"");
  [self.view addSubview:label];
  
  NSArray *protocolArray = [NSArray arrayWithObjects: @"DCC", @"MM", nil];
  protocol = [[UISegmentedControl alloc] initWithItems:protocolArray];
  protocol.frame = CGRectMake(CONTENTBORDER + BUTTONGAP + buttonWidth, 4 * BUTTONGAP + 4 * BUTTONHEIGHT, buttonWidth, TEXTHEIGHT);
  protocol.segmentedControlStyle = UISegmentedControlStylePlain;
  protocol.selectedSegmentIndex = 0;
  [protocol addTarget:self action:@selector(protocolClicked:) forControlEvents:UIControlEventValueChanged];
  //protocol.backgroundColor = [UIColor colorWithRed:0 green:1 blue:1 alpha:1.0];
  [self.view addSubview:protocol];
  protocolText = @"DCC";
  
  CGRect rect = CGRectMake(CONTENTBORDER, 5 * BUTTONGAP + 5 * BUTTONHEIGHT, buttonWidth * 2 + BUTTONGAP, BUTTONHEIGHT);
  buttonAdd = [[iRocButton alloc] initWithFrame:rect];
  buttonAdd.frame = rect;
  [buttonAdd setTitle: NSLocalizedString(@"Add", @"") forState: UIControlStateNormal];
  [buttonAdd setColor:2];
  [buttonAdd addTarget:self action:@selector(buttonAddClicked:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview: buttonAdd];
  
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[super touchesBegan:touches withEvent:event];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  [textField resignFirstResponder];
  
  return YES;
}

- (void)dealloc {
  [super dealloc];
}


@end
