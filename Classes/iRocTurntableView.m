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

#import "iRocTurntableView.h"


@implementation iRocTurntableView
@synthesize _delegate, esc;

- (void)loadView {
    [super loadView];
    [super.view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0]];
    
    CGRect bounds = self.view.bounds;
    float buttonWidth = (bounds.size.width - (2 * CONTENTBORDER + BUTTONGAP)) / 2;
    
    CGRect rect = CGRectMake(CONTENTBORDER, CONTENTBORDER, bounds.size.width - (2 * CONTENTBORDER + BUTTONGAP), BUTTONHEIGHT);
    l = [[UILabel alloc] initWithFrame:rect];
    l.textColor = [UIColor whiteColor];
    l.backgroundColor = [UIColor clearColor];
    l.font = [UIFont systemFontOfSize:25.0];
    l.textAlignment = UITextAlignmentCenter;
    [l setText:_tt.ID];	
    [self.view addSubview: l];
    
    CGRect escFrame = CGRectMake(CONTENTBORDER+BUTTONGAP+buttonWidth, BUTTONGAP+BUTTONHEIGHT, buttonWidth, BUTTONHEIGHT);
    esc = [[iRocButton alloc] initWithFrame:escFrame];
    esc.frame = escFrame;
    [esc setTitle: NSLocalizedString(@"esc", @"") forState: UIControlStateNormal];
    [esc addTarget:self action:@selector(escClicked:) forControlEvents:UIControlEventTouchUpInside];
    [esc setColor:0];
    [self.view addSubview: esc];

}

- (void)viewWillAppear:(BOOL)animated {
	NSLog(@"TurntableView will appear: %@ ", _tt.ID);
    [l setText:_tt.ID];
}


- (void) setTurntable:(Turntable *)tt {
	_tt = tt;
	NSLog(@"TurntableView setTurntable: %@ ", _tt.ID);
}


- (IBAction) escClicked:(id) sender {
	[_delegate dismissModalViewController];
}

@end
