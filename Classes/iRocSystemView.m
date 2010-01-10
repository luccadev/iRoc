//
//  iGoSystemView.m
//  iGo
//
//  Created by Rocrail on 31.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "iRocSystemView.h"
#import "globals.h"


@implementation iRocSystemView
@synthesize powerON, powerOFF, initField, autoON, autoStart, rrconnection;


- (id)init {
  self = [super init];
  if( self != nil ) {
    Power = FALSE;
    Auto = FALSE;
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:
                       NSLocalizedString(@"System", @"")
                       image:[UIImage imageNamed:@"light-on.png"] tag:4];
    self.tabBarItem.badgeValue = @"PWR";
  }
  return self;
}

- (void)loadView {
  [super loadView];
  [super.view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0]];
  
  CGRect bounds = self.view.bounds;
  float buttonWidth = (bounds.size.width - (2 * CONTENTBORDER + BUTTONGAP)) / 2;
  CGRect powerONFrame = CGRectMake(CONTENTBORDER, CONTENTBORDER, buttonWidth, BUTTONHEIGHT);
  powerON = [[iRocButton alloc] initWithFrame:powerONFrame];
  powerON.frame = powerONFrame;
  [powerON setTitle: NSLocalizedString(@"Power ON", @"") forState: UIControlStateNormal];
  [powerON addTarget:self action:@selector(powerONClicked:) forControlEvents:UIControlEventTouchUpInside];
  [powerON setColor:2];
  [powerON setBState:Power];
  [self.view addSubview: powerON];

  CGRect powerOFFFrame = CGRectMake(buttonWidth + CONTENTBORDER + BUTTONGAP, CONTENTBORDER, buttonWidth, BUTTONHEIGHT);
  powerOFF = [[iRocButton alloc] initWithFrame:powerOFFFrame];
  powerOFF.frame = powerOFFFrame;
  [powerOFF setTitle: NSLocalizedString(@"Power OFF", @"") forState: UIControlStateNormal];
  [powerOFF addTarget:self action:@selector(powerOFFClicked:) forControlEvents:UIControlEventTouchUpInside];
  [powerOFF setColor:1];
  [powerOFF setBState:!Power];
  [self.view addSubview: powerOFF];

  CGRect initFieldFrame = CGRectMake(CONTENTBORDER, CONTENTBORDER + BUTTONHEIGHT + BUTTONGAP, 2 * buttonWidth + BUTTONGAP, BUTTONHEIGHT);
  initField = [[iRocButton alloc] initWithFrame:initFieldFrame];
  initField.frame = initFieldFrame;
  [initField setTitle: NSLocalizedString(@"Init Field", @"") forState: UIControlStateNormal];
  [initField addTarget:self action:@selector(initFieldClicked:) forControlEvents:UIControlEventTouchUpInside];
  [initField setColor:3];
  [initField setEnabled:!Auto];
  [self.view addSubview: initField];

  CGRect autoONFrame = CGRectMake(CONTENTBORDER, CONTENTBORDER + 2 * BUTTONGAP + 2 * BUTTONHEIGHT, buttonWidth, BUTTONHEIGHT);
  autoON = [[iRocButton alloc] initWithFrame:autoONFrame];
  autoON.frame = autoONFrame;
  [autoON setTitle: NSLocalizedString(@"Auto ON", @"") forState: UIControlStateNormal];
  [autoON addTarget:self action:@selector(autoONClicked:) forControlEvents:UIControlEventTouchUpInside];
  [autoON setColor:0];
  [autoON setBState:Auto];
  [self.view addSubview: autoON];

  CGRect autoStartFrame = CGRectMake( CONTENTBORDER + buttonWidth + BUTTONGAP, CONTENTBORDER + 2 * BUTTONGAP + 2 * BUTTONHEIGHT, buttonWidth, BUTTONHEIGHT);
  autoStart = [[iRocButton alloc] initWithFrame:autoStartFrame];
  autoStart.frame = autoStartFrame;
  [autoStart setTitle: NSLocalizedString(@"Auto Start", @"") forState: UIControlStateNormal];
  [autoStart addTarget:self action:@selector(autoStartClicked:) forControlEvents:UIControlEventTouchUpInside];
  [autoStart setColor:0];
  [autoStart setEnabled:Auto];
  [self.view addSubview: autoStart];
  
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
  NSLog(@"rotation message: will be rotated...");
  return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
  NSLog(@"rotation message: rearange the layout...");
}

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}


- (IBAction) powerONClicked:(id) sender {
  NSLog(@"powerON");
  //[powerON flipBState];
	NSString * stringToSend = [[NSString alloc] initWithString: @"<sys cmd=\"go\"/>"];
	[rrconnection sendMessage:@"sys" message:stringToSend];
}

- (IBAction) powerOFFClicked:(id) sender {
  NSLog(@"powerOFF");
  //[powerOFF flipBState];
	NSString * stringToSend = [[NSString alloc] initWithString: @"<sys cmd=\"stop\"/>"];
	[rrconnection sendMessage:@"sys" message:stringToSend];
}

- (IBAction) initFieldClicked:(id) sender {
  NSLog(@"intField");
	NSString * stringToSend = [[NSString alloc] initWithString: @"<model cmd=\"initfield\"/>"];
	[rrconnection sendMessage:@"model" message:stringToSend];
}

- (IBAction) autoONClicked:(id) sender {
  NSLog(@"autoON");
  [autoON flipBState];
	NSString * stringToSend = [[NSString alloc] initWithString: 
                             [NSString stringWithFormat: @"<auto cmd=\"%@\"/>", [autoON getBState]?@"on":@"off"]];
	[rrconnection sendMessage:@"auto" message:stringToSend];
}

- (IBAction) autoStartClicked:(id) sender {
  NSLog(@"autoStart");
  [autoStart flipBState];
	NSString * stringToSend = [[NSString alloc] initWithString: 
                             [NSString stringWithFormat: @"<auto cmd=\"%@\"/>", [autoON getBState]?@"start":@"stop"]];
	[rrconnection sendMessage:@"auto" message:stringToSend];
}

- (void)setPower:(BOOL)state {
  Power = state;

  [powerON setBState:Power];
  [powerOFF setBState:!Power];
  
  self.tabBarItem.badgeValue = Power?nil:@"PWR";

}


- (void)setAuto:(BOOL)state {
  Auto = state;
  [autoON setBState:Auto];
  [autoStart setEnabled:Auto];
  [initField setEnabled:!Auto];

  self.tabBarItem.badgeValue = Power?nil:@"PWR";
  
}


- (void)dealloc {
  [powerON release];
  [powerOFF release];
  [super dealloc];
}



@end
