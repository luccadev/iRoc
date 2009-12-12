//
//  iRocLocTableViewController.m
//  iRoc
//
//  Created by Jean-Michel Fischer on 07.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//


#import "iRocLcTableView.h"


@implementation iRocLcTableView

@synthesize lcList, menuname;

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
	
	[self.tableView setRowHeight:80];
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
    return [lcList count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
	// Get the specific loc for this row.
	Loc *loc = [lcList objectAtIndex:indexPath.row];
    
	NSString *CellIdentifier = [NSString stringWithFormat:@"Cell_%@",loc.locid];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
	cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	
	cell.selectionStyle = UITableViewCellSelectionStyleGray;
	
	UILabel *locidLabel = [[[UILabel alloc] initWithFrame:celltextRect] autorelease];
	locidLabel.font = [UIFont boldSystemFontOfSize:cellfontsize];
	locidLabel.textColor = celltextcolor;
	locidLabel.backgroundColor = cellbackcolor;
	
	UILabel *descLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, 25, 100, 20)] autorelease];
	descLabel.font = [UIFont boldSystemFontOfSize:12];
	descLabel.textColor = celltextcolor;
	descLabel.backgroundColor = cellbackcolor;
    
	[cell.contentView addSubview:descLabel];
	[cell.contentView addSubview:locidLabel];
	
	locidLabel.text = loc.locid;
	descLabel.text = loc.desc;
		
	//NSLog(@"ONE");
	
	if( [loc hasImage] ) {
		
		//NSLog(@"TWO");
		
		

		if( [loc imageLoaded]) {
			
			//NSLog(@"THREE");
			
		
			
			CGRect imageframe = CGRectMake(230,10,80,60);	
			UIImageView *imageview = [[UIImageView alloc] initWithFrame:imageframe];
			imageview.image = [loc getImage];
			[cell.contentView addSubview:imageview];
		} else {
			
			NSLog(@"ONLY ONCE ... : %@", loc.locid);
			[_delegate askForLocpic:loc.locid withFilename:loc.imgname];
		}
	}	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[_delegate lcAction:((Loc*) [lcList objectAtIndex:indexPath.row]).locid];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (id)delegate
{
    return _delegate;
}

- (void)setDelegate:(id)new_delegate
{
    _delegate = new_delegate;
}

- (void)dealloc {
	[lcList release];
    [super dealloc];
}


@end

