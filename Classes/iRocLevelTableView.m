//
//  iRocLevelTableView.m
//  iRoc
//
//  Created by Rocrail on 14.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "iRocLevelTableView.h"


@implementation iRocLevelTableView

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setTitle:@"ZLevels"];
  levelView = [[iRocLevelView alloc] init];

    //self.navigationController.navigationBar.tintColor = [UIColor blackColor];
  
}


- (void)setDelegate:(id)new_delegate withModel:(Model *)_model {
  _delegate = new_delegate;
  model = _model;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}


  // Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  NSLog(@"number of levels is %d", [model.levelContainer count]);
  return [model.levelContainer count];
}


  // Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  static NSString *CellIdentifier = @"Cell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
  }
	
	cell.selectionStyle = UITableViewCellSelectionStyleGray;
	[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
	
	UILabel *idLabel = [[[UILabel alloc] initWithFrame:celltextRect] autorelease];
	idLabel.font = [UIFont boldSystemFontOfSize:cellfontsize];
	idLabel.textColor = celltextcolor;
	idLabel.backgroundColor = cellbackcolor;
	[cell.contentView addSubview:idLabel];
	ZLevel *level = (ZLevel*)[model.levelContainer objectAtIndex:indexPath.row];
	idLabel.text = [level menuname];
	
  return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSLog(@"selected level is %d", indexPath.row);
	ZLevel *level = (ZLevel*)[model.levelContainer objectAtIndex:indexPath.row];
  levelView.title = level.title;
  [self.navigationController pushViewController:levelView animated:YES];
}





- (void)dealloc {
  [super dealloc];
}

@end
