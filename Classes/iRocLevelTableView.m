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


#import "iRocLevelTableView.h"


@implementation iRocLevelTableView
@synthesize levelView;

- (void)viewDidLoad {
  [super viewDidLoad];
  NSLog(@"did load plan level view");
  
  planTitle = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 200.0, 40.0)];
  [planTitle setText:model.title];
  [planTitle setFont:[UIFont boldSystemFontOfSize:13.0]];
  [planTitle setTextAlignment:UITextAlignmentCenter];
  planTitle.backgroundColor = [UIColor clearColor];
  planTitle.textColor = [UIColor grayColor];

  
  self.navigationItem.titleView = planTitle;
	
  [self setTitle:@"Plan"];
}

- (void)planLoaded {
  [self.tableView reloadData];
  [planTitle setText:model.title];
}


- (id)initWithDelegate:(id)_delegate andModel:(Model *)_model {
  if( self = [super init] ) {
    NSLog(@"init plan level view");
    delegate = _delegate;
    model = _model;
    levelView = [[iRocLevelView alloc] init];
    levelView.model = _model;
  }
  return self;
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
	idLabel.textColor = [Globals getTextColor];
	idLabel.backgroundColor = [UIColor clearColor];
	[cell.contentView addSubview:idLabel];
	ZLevel *level = (ZLevel*)[model.levelContainer objectAtIndex:(int)indexPath.row];
	idLabel.text = [level menuname];
	
  return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSLog(@"selected level is %d", (int)indexPath.row);
	ZLevel *level = (ZLevel*)[model.levelContainer objectAtIndex:(int)indexPath.row];
  levelView.title = level.title;
  levelView.zlevel = level;
  [levelView reView];
  [self.navigationController pushViewController:levelView animated:YES];
}



- (BOOL)shouldAutorotate {
  NSLog(@"iRocLevelTableView: shouldAutorotate");
  return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
  NSLog(@"iRocLevelTableView: supportedInterfaceOrientations");
  return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
  NSLog(@"iRocLevelTableView: shouldAutorotateToInterfaceOrientation");
  return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
  NSLog(@"rotation message for LevelTableView");
  if( fromInterfaceOrientation == UIDeviceOrientationLandscapeLeft || fromInterfaceOrientation == UIDeviceOrientationLandscapeRight ) {
    NSLog(@"rotation message: will be rotated to portrait...");
  }
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation // iOS 6 autorotation fix
{
  NSLog(@"iRocLevelTableView: preferredInterfaceOrientationForPresentation");
  return UIInterfaceOrientationMaskAllButUpsideDown;
}



- (void)dealloc {
  [super dealloc];
}

@end
