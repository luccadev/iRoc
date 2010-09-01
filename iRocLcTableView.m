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


#import "iRocLcTableView.h"


@implementation iRocLcTableView

@synthesize lcContainer, menuname;

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
}
*/


- (void)viewDidLoad {
    [super viewDidLoad];
	[self setTitle:NSLocalizedString(@"Locomotives", @"Title")];
	
	[self.tableView setRowHeight:70];
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
 */

/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
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


#pragma mark Table view methods

/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
 */


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [lcContainer count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
	// Get the specific loc for this row.
	Loc *loc = (Loc*)[lcContainer objectAtIndex:indexPath.row];
    
	NSString *CellIdentifier = [NSString stringWithFormat:@"Cell_%@",loc.locid];
    
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		NSLog(@"creating cell for loco %@...", loc.locid);
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    
		
		cell.selectionStyle = UITableViewCellSelectionStyleGray;
		
		UILabel *locidLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, 8, 100, 20)] autorelease];
		locidLabel.font = [UIFont boldSystemFontOfSize:cellfontsize];
		locidLabel.textColor = celltextcolor;
		locidLabel.backgroundColor = [UIColor clearColor];
		
		UILabel *descLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, 29, 100, 20)] autorelease];
		descLabel.font = [UIFont boldSystemFontOfSize:12];
		descLabel.textColor = celltextcolor;
		descLabel.backgroundColor = [UIColor clearColor];
		
		UILabel *routeLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, 44, 100, 20)] autorelease];
		routeLabel.font = [UIFont boldSystemFontOfSize:12];
		routeLabel.textColor = celltextcolor;
		routeLabel.backgroundColor = [UIColor clearColor];
    
		[cell.contentView addSubview:descLabel];
		[cell.contentView addSubview:routeLabel];
		[cell.contentView addSubview:locidLabel];
		
		if ( [[loc consist] isEqualToString:@""] ) {
			locidLabel.text = [loc locid];
		} else {
			locidLabel.text = [NSString stringWithFormat:@"%@ + [%@]", loc.locid, loc.consist];
		}
		
		
		routeLabel.text = loc.roadname;
		descLabel.text = loc.desc;
		loc.cell = cell;
		
		NSLog(@"calling addCellLocoImage for loco %@...", loc.locid);
		[self addCellLocoImage:loc];
	}
	
  return cell;
}

- (void)addCellLocoImage:(Loc *)loc {
  if( [loc imageLoaded] && [loc hasImage] && loc.cell != nil) {
    NSLog(@"addCellLocoImage for loco %@...", loc.locid);
    UIImage *img = [loc getImage];
    UITableViewCell *cell = loc.cell;
    
    int breite = 50*(img.size.width/img.size.height);
    
    int diff = 150 - breite;
    
    CGRect imageframe = CGRectMake(160 + diff,10,breite,50);	
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:imageframe];
    imageview.image = [loc getImage];
    [cell.contentView addSubview:imageview];
    [cell.contentView bringSubviewToFront:imageview];
    [imageview release];
  } else if( [loc hasImage] && ![loc imageAlreadyRequested]){
    loc.imageAlreadyRequested=TRUE;
    //[_delegate askForLocpic:loc.locid withFilename:loc.imgname];
  }
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[_delegate lcAction:((Loc*) [lcContainer objectAtIndex:indexPath.row]).locid];
}

- (id)delegate
{
    return _delegate;
}

- (void)setDelegate:(id)new_delegate
{
    _delegate = new_delegate;
}

- (void)dealloc {
	[lcContainer release];
    [super dealloc];
}


@end

