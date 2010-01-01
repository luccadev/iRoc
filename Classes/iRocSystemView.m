//
//  iGoSystemView.m
//  iGo
//
//  Created by Rocrail on 31.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "iRocSystemView.h"


@implementation iRocSystemView
@synthesize powerON, powerOFF, rrconnection;


- (id)init {
  self = [super init];
  if( self != nil ) {
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:
                       [NSString stringWithFormat:@"System"] image:nil tag:2];
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



- (void)dealloc {
  [powerON release];
  [powerOFF release];
  [super dealloc];
}



@end
