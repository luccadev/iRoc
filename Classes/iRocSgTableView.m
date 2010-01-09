  //
  //  iRocCoTableView.m
  //  iRoc
  //
  //  Created by Jean-Michel Fischer on 09.12.09.
  //  Copyright 2009 __MyCompanyName__. All rights reserved.
  //

#import "iRocSgTableView.h"


@implementation iRocSgTableView
@synthesize sgContainer, menuname;

- (void)viewDidLoad {
  [super viewDidLoad];
	[self setTitle:@"Signals"];
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
	return [sgContainer count];
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
	
	Signal *sg = (Signal*)[sgContainer objectAtIndex:indexPath.row];
	
  idLabel.text = sg.ID;
	
	UIImage *image = [UIImage imageNamed:[sg getImgName]];
  
	CGRect imageframe = CGRectMake(280,10,20,20);	
	UIImageView *imageview = [[UIImageView alloc] initWithFrame:imageframe];
	imageview.image = image; 
	[cell.contentView addSubview:imageview];  
	
  return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[_delegate sgAction:((Signal*) [sgContainer objectAtIndex:indexPath.row]).ID];
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

