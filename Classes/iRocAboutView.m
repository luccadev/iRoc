//
//  iRocAboutView.m
//  iRoc
//
//  Created by Jean-Michel Fischer on 06.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "iRocAboutView.h"


@implementation iRocAboutView
@synthesize labelVersion;

- (void)viewDidLoad {
    [super viewDidLoad];
	[labelVersion setText:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]];	
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
