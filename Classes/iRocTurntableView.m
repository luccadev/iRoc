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
@synthesize _delegate, esc, itemWithTracks, tracks;

- (void)loadView {
    [super loadView];
    [super.view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0]];
    
    CGRect bounds = self.view.bounds;
    float width = 320.0;
    
    float buttonWidth = (bounds.size.width - (3 * CONTENTBORDER + BUTTONGAP)) / 3;
    CGRect tmpFrame = CGRectMake(CONTENTBORDER, CONTENTBORDER, width - (2 * CONTENTBORDER + BUTTONGAP), BUTTONHEIGHT);
    l = [[UILabel alloc] initWithFrame:tmpFrame];
    l.textColor = [UIColor whiteColor];
    l.backgroundColor = [UIColor clearColor];
    l.font = [UIFont systemFontOfSize:25.0];
    l.textAlignment = UITextAlignmentCenter;
	//[l setText:((Item *)itemWithTracks).Id];	
    [self.view addSubview: l];

	tmpFrame = CGRectMake(CONTENTBORDER, BUTTONGAP+BUTTONHEIGHT, buttonWidth, BUTTONHEIGHT);
    openItem = [[iRocButton alloc] initWithFrame:tmpFrame];
    openItem.frame = tmpFrame;
    [openItem setTitle: NSLocalizedString(@"esc", @"esc") forState: UIControlStateNormal];
    [openItem addTarget:self action:@selector(escClicked:) forControlEvents:UIControlEventTouchUpInside];
    [openItem setColor:1];
    //[openItem setBState:[((Item *)itemWithTracks).state isEqual:@"closed"]];
    [self.view addSubview: openItem];
	
	tmpFrame = CGRectMake(2*CONTENTBORDER+buttonWidth, BUTTONGAP+BUTTONHEIGHT, buttonWidth, BUTTONHEIGHT);
    prevTrack = [[iRocButton alloc] initWithFrame:tmpFrame];
    prevTrack.frame = tmpFrame;
    [prevTrack setTitle: NSLocalizedString(@"prev", @"") forState: UIControlStateNormal];
    [prevTrack addTarget:self action:@selector(prevTrackClicked:) forControlEvents:UIControlEventTouchUpInside];
    [prevTrack setColor:3];
    [self.view addSubview: prevTrack];
	
	tmpFrame = CGRectMake(3*CONTENTBORDER+2*buttonWidth, BUTTONGAP+BUTTONHEIGHT, buttonWidth, BUTTONHEIGHT);
    nextTrack = [[iRocButton alloc] initWithFrame:tmpFrame];
    nextTrack.frame = tmpFrame;
    [nextTrack setTitle: NSLocalizedString(@"next", @"") forState: UIControlStateNormal];
    [nextTrack addTarget:self action:@selector(nextTrackClicked:) forControlEvents:UIControlEventTouchUpInside];
    [nextTrack setColor:3];
    [self.view addSubview: nextTrack];
	
    tmpFrame = CGRectMake(CONTENTBORDER, 2 * (BUTTONHEIGHT + BUTTONGAP)-6, 2*buttonWidth+BUTTONGAP, 2*BUTTONHEIGHT);
    trackPicker = [[UIPickerView alloc] initWithFrame: tmpFrame];
    trackPicker.delegate = self;
    trackPicker.dataSource = self;
    trackPicker.showsSelectionIndicator = YES;
    [self.view addSubview: trackPicker];
     
    // Mask for better look
	UIImageView *maskview = [[UIImageView alloc] 
                             initWithFrame: CGRectMake(0, 2 * (BUTTONHEIGHT + BUTTONGAP)-6, width, 219)];
	maskview.image = [UIImage imageNamed:@"mask_1.png"];
	[self.view addSubview: maskview];
    
	tmpFrame = CGRectMake(CONTENTBORDER, 5*BUTTONGAP+5*BUTTONHEIGHT, 3*buttonWidth+BUTTONGAP, BUTTONHEIGHT);
    gotoTrack = [[iRocButton alloc] initWithFrame:tmpFrame];
    gotoTrack.frame = tmpFrame;
    [gotoTrack setTitle: NSLocalizedString(@"Goto track", @"") forState: UIControlStateNormal];
    [gotoTrack addTarget:self action:@selector(gotoTrackClicked:) forControlEvents:UIControlEventTouchUpInside];
    [gotoTrack setColor:3];
    [self.view addSubview: gotoTrack];

}

- (void)viewWillAppear:(BOOL)animated {
    [l setText:_tt.ID];
}

- (void) setTurntable:(Turntable *)tt {
	_tt = tt;
    
    self.tracks = _tt.ttTracks;
    
	NSLog(@"TurntableView setTurntable: %@ ", _tt.ID);
}


- (IBAction) escClicked:(id) sender {
	[_delegate dismissModalViewController];
}

- (IBAction) prevTrackClicked:(id) sender {
    [_tt prevTrack];
    [_delegate dismissModalViewController];
}

- (IBAction) nextTrackClicked:(id) sender {
    [_tt nextTrack];
    [_delegate dismissModalViewController];
}

- (IBAction) gotoTrackClicked:(id) sender {
    [_tt gotoTrack:[trackPicker selectedRowInComponent:0]];
    [_delegate dismissModalViewController];
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component {
    NSLog(@"component=%d", component);
    return [tracks count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow: (NSInteger)row forComponent: (NSInteger)component {
    NSLog(@"component=%d", component);
    TtTrack *t = (TtTrack*)[tracks objectAtIndex:row];
    return t.desc;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent: (NSInteger)component {
    //TtTrack *t = (TtTrack*)[tracks objectAtIndex:row];
}

@end
