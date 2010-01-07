//
//  iRocBkTableView.m
//  iRoc
//
//  Created by Rocrail on 07.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "iRocBkTableView.h"


@implementation iRocBkTableView
@synthesize bkContainer, menuname;



- (void)viewDidLoad {
  [super viewDidLoad];
	[self setTitle:@"Blocks"];
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


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}


  // Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [bkContainer count];
}


  // Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  static NSString *CellIdentifier = @"Cell";
  
  UITableViewCell *cell; // = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //if (cell == nil) {
	cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    //}
	
	cell.selectionStyle = UITableViewCellSelectionStyleGray;
	
	UILabel *idLabel = [[[UILabel alloc] initWithFrame:celltextRect] autorelease];
	idLabel.font = [UIFont boldSystemFontOfSize:cellfontsize];
	idLabel.textColor = celltextcolor;
	idLabel.backgroundColor = cellbackcolor;
	[cell.contentView addSubview:idLabel];
	
	Block *bk = (Block*)[bkContainer objectAtIndex:indexPath.row];
	
    //NSLog(@"COID: %@", bk.ID);
	
  idLabel.text = bk.ID;
	
	
  return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[_delegate bkAction:((Block*) [bkContainer objectAtIndex:indexPath.row]).ID];
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
  [super dealloc];
}


@end
