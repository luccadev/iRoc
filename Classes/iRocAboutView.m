//
//  iRocAboutView.m
//  iRoc
//
//  Created by Jean-Michel Fischer on 06.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "iRocAboutView.h"
#import "iRocAppDelegate.h"
#import "Globals.h"


@implementation iRocAboutView
@synthesize irocVersion, rocrailVersion, rocrailConnection, menuname;


- (id)initWithDelegate:(id)_delegate andModel:(Model*)_model {
  NSLog(@"01");
  if( self = [super init] ) {
    model = _model;
    delegate = _delegate;
  }
  NSLog(@"02");
  
  return self;
}

- (void)viewDidLoad {
  NSLog(@"0");
  [super viewDidLoad];
  NSLog(@"1");
  CGRect rect = CGRectMake(CONTENTBORDER, CONTENTBORDER, 120, 20);
  UILabel* l = [[UILabel alloc] initWithFrame:rect];
  l.textColor = [UIColor lightGrayColor];
  l.backgroundColor = [UIColor clearColor];
	[l setText:@"iRoc version"];	
  [self.view addSubview: l];
  
  rect = CGRectMake(CONTENTBORDER + 120, CONTENTBORDER, 150, 20);
  irocVersion = [[UILabel alloc] initWithFrame:rect];
  irocVersion.textColor = [UIColor lightGrayColor];
  irocVersion.backgroundColor = [UIColor clearColor];
	[irocVersion setText:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]];	
  [self.view addSubview: irocVersion];

  NSLog(@"2");
  rect = CGRectMake(CONTENTBORDER, CONTENTBORDER + 30, 120, 20);
  l = [[UILabel alloc] initWithFrame:rect];
  l.textColor = [UIColor lightGrayColor];
  l.backgroundColor = [UIColor clearColor];
	[l setText:@"Rocrail version"];	
  [self.view addSubview: l];
  
  rect = CGRectMake(CONTENTBORDER + 120, CONTENTBORDER + 30, 150, 20);
  rocrailVersion = [[UILabel alloc] initWithFrame:rect];
  rocrailVersion.textColor = [UIColor lightGrayColor];
  rocrailVersion.backgroundColor = [UIColor clearColor];
	[rocrailVersion setText:model.rocrailversion];
  [self.view addSubview: rocrailVersion];

  NSLog(@"3");
  rect = CGRectMake(CONTENTBORDER, CONTENTBORDER + 2 * 30, 120, 20);
  l = [[UILabel alloc] initWithFrame:rect];
  l.textColor = [UIColor lightGrayColor];
  l.backgroundColor = [UIColor clearColor];
	[l setText:@"Connected to"];	
  [self.view addSubview: l];
  
  rect = CGRectMake(CONTENTBORDER + 120, CONTENTBORDER + 2 * 30, 180, 20);
  rocrailConnection = [[UILabel alloc] initWithFrame:rect];
  rocrailConnection.textColor = [UIColor lightGrayColor];
  rocrailConnection.backgroundColor = [UIColor clearColor];
  [rocrailConnection setText:[[NSString alloc] initWithFormat:@"%@:%d", 
                              [[(iRocAppDelegate*)delegate getConnector]domain],
                              [[(iRocAppDelegate*)delegate getConnector]port]]];	
  [self.view addSubview: rocrailConnection];

  NSLog(@"4");
  rect = CGRectMake(CONTENTBORDER, CONTENTBORDER + 3 * 30, 100, 60);
  l = [[UILabel alloc] initWithFrame:rect];
  l.textColor = [UIColor whiteColor];
  l.backgroundColor = [UIColor clearColor];
  l.font = [UIFont systemFontOfSize:45.0];
	[l setText:@"iRoc"];	
  [self.view addSubview: l];
  
  rect = CGRectMake(CONTENTBORDER + 100, CONTENTBORDER + 3 * 30 + 30, 200, 20);
  l = [[UILabel alloc] initWithFrame:rect];
  l.textColor = [UIColor whiteColor];
  l.font = [UIFont systemFontOfSize:11.0];
  l.backgroundColor = [UIColor clearColor];
	[l setText:@"a controller for the mighty Rocrail."];	
  [self.view addSubview: l];
  
  NSLog(@"5");
  rect = CGRectMake(CONTENTBORDER, CONTENTBORDER + 3 * 30 + 60, 300, 20);
  l = [[UILabel alloc] initWithFrame:rect];
  l.textColor = [UIColor whiteColor];
  l.font = [UIFont systemFontOfSize:12.0];
  l.backgroundColor = [UIColor clearColor];
	[l setText:@"©rocrail.net by Jean-Michel Fischer and Rob Versluis."];	
  [self.view addSubview: l];
  
  rect = CGRectMake(CONTENTBORDER, CONTENTBORDER + 4 * 30 + 53, 300, 40);
  l = [[UILabel alloc] initWithFrame:rect];
  l.textColor = [UIColor whiteColor];
  l.backgroundColor = [UIColor clearColor];
	[l setText:@"GNU GENERAL PUBLIC LICENSE"];	
  [self.view addSubview: l];
  
  UIImage *image = [UIImage imageNamed:@"rocrail-logo-noshade-black.png"];
  rect = CGRectMake(CONTENTBORDER + 80, CONTENTBORDER + 5 * 30 + 100, 200, 53);
  UIImageView * iv = [[UIImageView alloc] initWithFrame:rect];
  iv.image = image; 
  [self.view addSubview: iv];
  
}

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
