

//
//  iRocTurntableView.m
//  iRoc
//
//  Created by Jean-Michel Fischer on 09.05.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "iRocTurntableView.h"


@implementation iRocTurntableView
@synthesize _delegate, esc;

- (void)loadView {
    [super loadView];
    [super.view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0]];
    
    CGRect bounds = self.view.bounds;
    float buttonWidth = (bounds.size.width - (2 * CONTENTBORDER + BUTTONGAP)) / 2;
    
    CGRect escFrame = CGRectMake(CONTENTBORDER+BUTTONGAP+buttonWidth, BUTTONGAP+BUTTONHEIGHT, buttonWidth, BUTTONHEIGHT);
    esc = [[iRocButton alloc] initWithFrame:escFrame];
    esc.frame = escFrame;
    [esc setTitle: NSLocalizedString(@"OK", @"") forState: UIControlStateNormal];
    [esc addTarget:self action:@selector(escClicked:) forControlEvents:UIControlEventTouchUpInside];
    [esc setColor:0];
    [self.view addSubview: esc];

}

- (void)viewWillAppear:(BOOL)animated {
	
	NSLog(@"TurntableView will appear: %@ ", _tt.ID);
    
}


- (void) setTurntable:(Turntable *)tt {
	_tt = tt;
	NSLog(@"TurntableView setTurntable: %@ ", _tt.ID);
}


- (IBAction) escClicked:(id) sender {
	[_delegate dismissModalViewController];
}

@end
