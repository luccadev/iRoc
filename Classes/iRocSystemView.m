//
//  iGoSystemView.m
//  iGo
//
//  Created by Rocrail on 31.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "iRocSystemView.h"


@implementation iRocSystemView
@synthesize powerON, powerOFF, initField, autoON, autoOFF, autoStart, autoStop, rrconnection;


- (id)init {
  self = [super init];
  if( self != nil ) {
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:
                       [NSString stringWithFormat:@"System"] image:nil tag:4];
  }
  return self;
}

- (void)loadView {
  [super loadView];
  [super.view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0]];
  
  CGRect bounds = self.view.bounds;
  float buttonWidth = (bounds.size.width - 75) / 2;
  CGRect powerONFrame = CGRectMake(25.0, 25.0, buttonWidth, 60.0);
  powerON = [[iRocButton alloc] initWithFrame:powerONFrame];
  powerON.frame = powerONFrame;
  [powerON setTitle: @"Power ON" forState: UIControlStateNormal];
  [powerON addTarget:self action:@selector(powerONClicked:) forControlEvents:UIControlEventTouchUpInside];
  [powerON setColor:2];
  [self.view addSubview: powerON];

  CGRect powerOFFFrame = CGRectMake(buttonWidth + 50.0, 25.0, buttonWidth, 60.0);
  powerOFF = [[iRocButton alloc] initWithFrame:powerOFFFrame];
  powerOFF.frame = powerOFFFrame;
  [powerOFF setTitle: @"Power OFF" forState: UIControlStateNormal];
  [powerOFF addTarget:self action:@selector(powerOFFClicked:) forControlEvents:UIControlEventTouchUpInside];
  [powerOFF setColor:1];
  [self.view addSubview: powerOFF];

  CGRect initFieldFrame = CGRectMake(25.0, 25.0 + 60.0 + 25.0, 2 * buttonWidth + 25.0, 60.0);
  initField = [[iRocButton alloc] initWithFrame:initFieldFrame];
  initField.frame = initFieldFrame;
  [initField setTitle: @"init Field" forState: UIControlStateNormal];
  [initField addTarget:self action:@selector(initFieldClicked:) forControlEvents:UIControlEventTouchUpInside];
  [initField setColor:3];
  [self.view addSubview: initField];

  CGRect autoONFrame = CGRectMake(25.0, 3 * 25.0 + 2 * 60.0, buttonWidth, 60.0);
  autoON = [[iRocButton alloc] initWithFrame:autoONFrame];
  autoON.frame = autoONFrame;
  [autoON setTitle: @"Auto ON" forState: UIControlStateNormal];
  [autoON addTarget:self action:@selector(autoONClicked:) forControlEvents:UIControlEventTouchUpInside];
  [autoON setColor:3];
  [self.view addSubview: autoON];

  CGRect autoOFFFrame = CGRectMake(buttonWidth + 50.0, 3 * 25.0 + 2 * 60.0, buttonWidth, 60.0);
  autoOFF = [[iRocButton alloc] initWithFrame:autoOFFFrame];
  autoOFF.frame = autoOFFFrame;
  [autoOFF setTitle: @"Auto OFF" forState: UIControlStateNormal];
  [autoOFF addTarget:self action:@selector(autoOFFClicked:) forControlEvents:UIControlEventTouchUpInside];
  [autoOFF setColor:3];
  [self.view addSubview: autoOFF];

  CGRect autoStartFrame = CGRectMake(25.0, 4 * 25.0 + 3 * 60.0, buttonWidth, 60.0);
  autoStart = [[iRocButton alloc] initWithFrame:autoStartFrame];
  autoStart.frame = autoStartFrame;
  [autoStart setTitle: @"Auto Start" forState: UIControlStateNormal];
  [autoStart addTarget:self action:@selector(autoStartClicked:) forControlEvents:UIControlEventTouchUpInside];
  [autoStart setColor:3];
  [self.view addSubview: autoStart];
  
  CGRect autoStopFrame = CGRectMake(buttonWidth + 50.0, 4 * 25.0 + 3 * 60.0, buttonWidth, 60.0);
  autoStop = [[iRocButton alloc] initWithFrame:autoStopFrame];
  autoStop.frame = autoStopFrame;
  [autoStop setTitle: @"Auto Stop" forState: UIControlStateNormal];
  [autoStop addTarget:self action:@selector(autoStopClicked:) forControlEvents:UIControlEventTouchUpInside];
  [autoStop setColor:3];
  [self.view addSubview: autoStop];
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
	NSString * stringToSend = [[NSString alloc] initWithString: @"<auto cmd=\"on\"/>"];
	[rrconnection sendMessage:@"auto" message:stringToSend];
}

- (IBAction) autoOFFClicked:(id) sender {
  NSLog(@"autoOFF");
	NSString * stringToSend = [[NSString alloc] initWithString: @"<auto cmd=\"off\"/>"];
	[rrconnection sendMessage:@"auto" message:stringToSend];
}

- (IBAction) autoStartClicked:(id) sender {
  NSLog(@"autoStart");
	NSString * stringToSend = [[NSString alloc] initWithString: @"<auto cmd=\"start\"/>"];
	[rrconnection sendMessage:@"auto" message:stringToSend];
}

- (IBAction) autoStopClicked:(id) sender {
  NSLog(@"autoStop");
	NSString * stringToSend = [[NSString alloc] initWithString: @"<auto cmd=\"stop\"/>"];
	[rrconnection sendMessage:@"auto" message:stringToSend];
}



- (void)dealloc {
  [powerON release];
  [powerOFF release];
  [super dealloc];
}



@end
