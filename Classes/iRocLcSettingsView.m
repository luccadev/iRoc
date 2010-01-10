//
//  iGoLcView.m
//  iGo
//
//  Created by Rocrail on 04.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "iRocLcSettingsView.h"
#import "globals.h"


@implementation iRocLcSettingsView

@synthesize rrconnection, loc;


- (id)init {
  self = [super init];
    //self = [super initWithStyle: UITableViewStyleGrouped];
  if( self != nil ) {
    self.tableView.backgroundColor = [UIColor blackColor];
    self.tableView.separatorColor = [UIColor blackColor];

    self.title = NSLocalizedString(@"Settings", @"");
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:
                       NSLocalizedString(@"Settings", @"") image:nil tag:3];
    
  }
  return self;
}

- (void)loadView {
  [super loadView];
}

- (void)dealloc {
  [Vmax release];
  [Vmid release];
  [Vmin release];
  [super dealloc];
}

- (void)setLoco:(Loc*)loco {
  self.loc = loco;
  [Placing setBState: ![loc isPlacing]];
  [self updatePlacing];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  NSLog(@"sections in table");
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection: (NSInteger)section {
  NSLog(@"rows in section %d", section);
  switch( section ) {
    case (0):
      return 4;
      break;
    case (1):
      return 2;
      break;
  }
  return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  NSLog(@"title for section %d", section);
  /*
  switch( section ) {
    case (0):
      return @"Velocity";
      break;
    case (1):
      return @"Automatic";
      break;
  }
   */
  return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  
{  
  NSLog(@"cell height for %d:%d", [indexPath indexAtPosition:0 ], [indexPath indexAtPosition:1 ]);
  return 50.0; //returns floating point which will be used for a cell row height at specified row index  
}  


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSLog(@"cell for %d:%d", [indexPath indexAtPosition:0 ], [indexPath indexAtPosition:1 ]);

  NSString *CellIdentifier = [ NSString stringWithFormat: @"%d:%d", [indexPath indexAtPosition:0 ],
                              [ indexPath indexAtPosition:1 ] ];
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
  
  if( cell == nil ) {
    cell = [[[UITableViewCell alloc] initWithFrame: CGRectZero reuseIdentifier: CellIdentifier ] autorelease ];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
      //cell.selectionStyle = UITableViewCellSelectionStyleGray;

    switch([indexPath indexAtPosition:0 ]) {
      case (0):
        switch([indexPath indexAtPosition:1]) {
          case (0): {
            Vmax = [[iRocSlider alloc] initWithFrame: CGRectMake(170, 10, 125, 30)];
            [Vmax setValue:[loc getVmax]];
              //Vmax.minimumValue = 0;
              //Vmax.maximumValue = 100;
              //Vmax.value = 100;
            [cell addSubview: Vmax];

            UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(CONTENTBORDER, 10, 100, 30)] autorelease];
            label.font = [UIFont boldSystemFontOfSize:cellfontsize];
            label.textColor = celltextcolor;
            label.backgroundColor = [UIColor clearColor];
            label.text = @"Vmax";
            [cell addSubview: label];
          }
          break;
          case (1): {
            Vmid = [[iRocSlider alloc] initWithFrame: CGRectMake(170, 10, 125, 30)];
            [Vmid setValue:[loc getVmid]];
            [cell addSubview: Vmid];
            UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(CONTENTBORDER, 10, 100, 30)] autorelease];
            label.font = [UIFont boldSystemFontOfSize:cellfontsize];
            label.textColor = celltextcolor;
            label.backgroundColor = [UIColor clearColor];
            label.text = @"Vmid";
            [cell addSubview: label];
          }
          break;
          case (2): {
            Vmin = [[iRocSlider alloc] initWithFrame: CGRectMake(170, 10, 125, 30)];
            [Vmin setValue:[loc getVmin]];
            [cell addSubview: Vmin];
            UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(CONTENTBORDER, 10, 100, 30)] autorelease];
            label.font = [UIFont boldSystemFontOfSize:cellfontsize];
            label.textColor = celltextcolor;
            label.backgroundColor = [UIColor clearColor];
            label.text = @"Vmin";
            [cell addSubview: label];
          }
          break;
          case (3): {
            Placing = [[iRocButton alloc] initWithFrame: CGRectMake(170, 10, 125, 30)];
            Placing.frame = CGRectMake(170, 10, 125, 30);
            [Placing setBState: ![loc isPlacing]];
            [self updatePlacing];
            [Placing addTarget:self action:@selector(placingClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview: Placing];
            UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(CONTENTBORDER, 10, 100, 30)] autorelease];
            label.font = [UIFont boldSystemFontOfSize:cellfontsize];
            label.textColor = celltextcolor;
            label.backgroundColor = [UIColor clearColor];
            label.text = NSLocalizedString(@"Placing", @"");
            [cell addSubview: label];
          }
            break;
        }
        break;
    }
  }
  
  return cell;
}

- (IBAction) placingClicked:(id) sender {
  [Placing flipBState];
  [self updatePlacing];
  NSString * stringToSend = [[NSString alloc] initWithString: 
                             [NSString stringWithFormat: @"<lc id=\"%@\" cmd=\"swap\" placing=\"%@\"/>",
                              loc.locid, [Placing getBState]?@"false":@"true" ]];
  [rrconnection sendMessage:@"lc" message:stringToSend];
}  

- (void) updatePlacing {
  [Placing setTitle: [Placing getBState] ? NSLocalizedString(@"Swapped", @""):NSLocalizedString(@"Normal", @"") forState: UIControlStateNormal];
}  

@end
