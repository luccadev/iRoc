/*
 Rocrail - Model Railroad Software
 
 Copyright (C) 2009-2010 - Rob Versluis <r.j.versluis@rocrail.net>, Jean-Michel Fischer <jmf@polygonpunkt.de>
 
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


#import "iRocBlockView.h"
#import "Globals.h"


@implementation iRocBlockView
@synthesize selectLoc, intoOP, _delegate, esc, locos, lcContainer;


- (void)loadView {
  [super loadView];
  [super.view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0]];
	
  locos = [[NSMutableArray alloc] init];

  [locos removeAllObjects];
  [locos addObject: NSLocalizedString(@"none", @"")];
  int cnt = [lcContainer count];
  NSLog(@"number of locos=%d", cnt);
  for( int i = 0; i < cnt; i++ ) {
    Loc *lc = (Loc*)[lcContainer objectAtIndex:i];
    [locos addObject: lc.locid];
  }
  
  
  CGRect bounds = self.view.bounds;
  float buttonWidth = (bounds.size.width - (2 * CONTENTBORDER + BUTTONGAP)) / 2;
	CGRect rect = CGRectMake(CONTENTBORDER, CONTENTBORDER, bounds.size.width - (2 * CONTENTBORDER + BUTTONGAP), BUTTONHEIGHT);
  l = [[UILabel alloc] initWithFrame:rect];
  l.textColor = [UIColor whiteColor];
  l.backgroundColor = [UIColor clearColor];
  l.font = [UIFont systemFontOfSize:25.0];
  l.textAlignment = UITextAlignmentCenter;
	[l setText:_block.ID];	
  [self.view addSubview: l];

	/*
  CGRect selectLocFrame = CGRectMake(CONTENTBORDER, BUTTONGAP+BUTTONHEIGHT, buttonWidth, BUTTONHEIGHT);
  selectLoc = [[iRocButton alloc] initWithFrame:selectLocFrame];
  selectLoc.frame = selectLocFrame;
  [selectLoc setTitle: NSLocalizedString(@"Set Loco", @"") forState: UIControlStateNormal];
  [selectLoc addTarget:self action:@selector(selectLocClicked:) forControlEvents:UIControlEventTouchUpInside];
  [selectLoc setColor:2];
  //[selectLoc setBState:Power];
  [self.view addSubview: selectLoc];
	 */
	
	CGRect selectLocFrame = CGRectMake(CONTENTBORDER, BUTTONGAP+BUTTONHEIGHT, buttonWidth, BUTTONHEIGHT);
  intoOP = [[iRocButton alloc] initWithFrame:selectLocFrame];
  intoOP.frame = selectLocFrame;
  [intoOP setTitle: NSLocalizedString(@"Close", @"") forState: UIControlStateNormal];
  [intoOP addTarget:self action:@selector(intoOPClicked:) forControlEvents:UIControlEventTouchUpInside];
  [intoOP setColor:0];
  //[intoOP setBState:[_block.state isEqual:@"closed"]];
  [self.view addSubview: intoOP];
	
  CGRect escFrame = CGRectMake(CONTENTBORDER+BUTTONGAP+buttonWidth, BUTTONGAP+BUTTONHEIGHT, buttonWidth, BUTTONHEIGHT);
  esc = [[iRocButton alloc] initWithFrame:escFrame];
  esc.frame = escFrame;
  [esc setTitle: NSLocalizedString(@"OK", @"") forState: UIControlStateNormal];
  [esc addTarget:self action:@selector(escClicked:) forControlEvents:UIControlEventTouchUpInside];
  [esc setColor:0];
  [self.view addSubview: esc];
	
	/*
  locoPicker = [[UIPickerView alloc] initWithFrame: CGRectMake(0, 2 * BUTTONHEIGHT + 2 * BUTTONGAP - 5, 0, 0)];
  locoPicker.delegate = self;
  locoPicker.dataSource = self;
  locoPicker.showsSelectionIndicator = YES;
  [self.view addSubview: locoPicker];
	 
	 // Mask for better look
	 UIImageView *maskview = [[UIImageView alloc] initWithFrame: CGRectMake(0, 2 * BUTTONHEIGHT + 2 * BUTTONGAP - 5, 320, 219)];
	 maskview.image = [UIImage imageNamed:@"mask.png"];
	 [self.view addSubview: maskview];
	 */
	
	CGRect locoPickerButtonFrame = CGRectMake( CONTENTBORDER, 2 * BUTTONHEIGHT + 2* BUTTONGAP, 2*buttonWidth+BUTTONGAP, BUTTONHEIGHT);
	locoPickerButton = [[iRocLocoPicker alloc] initWithFrame: locoPickerButtonFrame];
	locoPickerButton.delegate = self;
	[locoPickerButton setLocContainer:lcContainer];
  [self.view addSubview: locoPickerButton];


  CGRect setInBlockFrame = CGRectMake( CONTENTBORDER, 3 * BUTTONHEIGHT + 2* BUTTONGAP + BUTTONGAP, buttonWidth, BUTTONHEIGHT);
  setInBlock = [[iRocButton alloc] initWithFrame: setInBlockFrame];
  setInBlock.frame = setInBlockFrame;
  [setInBlock setTitle: NSLocalizedString(@"Set in block", @"") forState: UIControlStateNormal];
  [setInBlock addTarget:self action:@selector(setInBlockClicked:) forControlEvents:UIControlEventTouchUpInside];
  [setInBlock setColor:3];
  [self.view addSubview: setInBlock];
	
	CGRect resetInBlockFrame = CGRectMake( CONTENTBORDER+BUTTONGAP+buttonWidth, 3 * BUTTONHEIGHT + 2* BUTTONGAP + BUTTONGAP, buttonWidth, BUTTONHEIGHT);
  resetInBlock = [[iRocButton alloc] initWithFrame: resetInBlockFrame];
  resetInBlock.frame = resetInBlockFrame;
  [resetInBlock setTitle: NSLocalizedString(@"Reset block", @"") forState: UIControlStateNormal];
  [resetInBlock addTarget:self action:@selector(resetInBlockClicked:) forControlEvents:UIControlEventTouchUpInside];
  [resetInBlock setColor:1];
  [self.view addSubview: resetInBlock];
	
	CGRect accepidentFrame = CGRectMake( CONTENTBORDER+BUTTONGAP+buttonWidth, 4 * BUTTONHEIGHT + 4* BUTTONGAP, buttonWidth, BUTTONHEIGHT);
  acceptIdent = [[iRocButton alloc] initWithFrame: accepidentFrame];
  acceptIdent.frame = accepidentFrame;
  [acceptIdent setTitle: NSLocalizedString(@"Accept Ident", @"") forState: UIControlStateNormal];
  [acceptIdent addTarget:self action:@selector(acceptIdentClicked:) forControlEvents:UIControlEventTouchUpInside];
  [acceptIdent setColor:2];
  [self.view addSubview: acceptIdent];

}

- (void)drawRect:(CGRect)rect {
	
	NSLog(@"iRocBlockView: drawRect");
	
}


- (IBAction) selectLocClicked:(id) sender {
	
	[_delegate dismissModalViewController];

}

- (IBAction) acceptIdentClicked:(id) sender {
	
	[_block sendAcceptIdent];
	
	[_delegate dismissModalViewController];
	
}

- (IBAction) intoOPClicked:(id) sender {

	if( [_block.state isEqual:@"closed"]) {
		[_block sendOpen];
	} else {
		[_block sendClose];
	}

	NSLog(@"BlockView : block.id: %@ ", _block.ID);
	
	[_delegate dismissModalViewController];
}

- (IBAction) escClicked:(id) sender {
	[_delegate dismissModalViewController];
}

- (void) setBlock:(Block*)block {
	_block = block;
	NSLog(@"BlockView setBlock: %@ ", _block.ID);
}


- (void)viewWillAppear:(BOOL)animated {
	
	NSLog(@"BlockView will appear: %@ ", _block.ID);
	
	BOOL isClosed = [_block.state isEqual:@"closed"];
		
	Loc *lc = NULL;
	if( [_block.locid isEqualToString:@""]) {
		lc = [[Loc alloc] retain];
		lc.locid = NSLocalizedString(@"Block is empty",@"");
		lc.desc = NSLocalizedString(@"select loco ...", @"");
	} else {
		lc = [lcContainer objectWithId:_block.locid];
	}
	
	if( lc != NULL) {
		[locoPickerButton setLoc:lc];
	}
		
	[intoOP setTitle: isClosed?NSLocalizedString(@"Open", @""):NSLocalizedString(@"Close", @"") forState: UIControlStateNormal];
	[intoOP setColor:isClosed?2:1];
	[l setText:_block.ID];
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
  NSLog(@"rotation message: BlockView will be rotated...");
  return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	
	//NSLog(@"Rotation Rotation Rotation"); 
	
	/*
	CGRect setInBlockFrame = CGRectMake( CONTENTBORDER, CONTENTBORDER, BUTTONHEIGHT, BUTTONHEIGHT);
  setInBlock.frame = setInBlockFrame;
	 */
	
	
}


- (NSInteger)numberOfComponentsInPickerView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component {
  NSLog(@"component=%d", component);
  return [self.locos count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow: (NSInteger)row forComponent: (NSInteger)component {
  NSLog(@"component=%d", component);
  return [self.locos objectAtIndex: row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent: (NSInteger)component {
  locoPicked = row;
}

- (IBAction) setInBlockClicked:(id) sender {
	
	[_block setLoco:[locoPickerButton getLoc].locid];
		
	[_delegate dismissModalViewController];
}

- (IBAction) resetInBlockClicked:(id) sender {
	[_block resetLoco];
	
		 
	[_delegate dismissModalViewController];
}




- (void)dealloc {
    [super dealloc];
}


@end
