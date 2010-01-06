//
//  iGoLcView.m
//  iGo
//
//  Created by Rocrail on 04.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "iRocLcAutoView.h"


@implementation iRocLcAutoView
@synthesize schedules, blocks;



- (id)init {
  self = [super init];
    //self = [super initWithStyle: UITableViewStyleGrouped];
  if( self != nil ) {
    self.tableView.backgroundColor = [UIColor blackColor];
    self.tableView.separatorColor = [UIColor blackColor];

    self.title = @"Automatic";
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:
                       [NSString stringWithFormat:@"Settings"] image:nil tag:3];
    
    schedules = [[NSMutableArray alloc] init];
    [schedules addObject: @"none"];
    [schedules addObject: @"Scd 1"];
    [schedules addObject: @"Scd 2"];
    [schedules addObject: @"Scd 3"];
    [schedules addObject: @"Scd 4"];
    [schedules addObject: @"Scd 5"];
    [schedules addObject: @"Scd 6"];
    [schedules addObject: @"Scd 7"];
    [schedules addObject: @"Scd 8"];
    [schedules addObject: @"Scd 9"];
    [schedules addObject: @"Scd 10"];

    blocks = [[NSMutableArray alloc] init];
    [blocks addObject: @"none"];
    [blocks addObject: @"Block 1"];
    [blocks addObject: @"Block 2"];
    [blocks addObject: @"Block 3"];
    [blocks addObject: @"Block 4"];
    [blocks addObject: @"Block 5"];
    [blocks addObject: @"Block 6"];
    [blocks addObject: @"Block 7"];
    [blocks addObject: @"Block 8"];
    [blocks addObject: @"Block 9"];
    [blocks addObject: @"Block 10"];

  
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  NSLog(@"sections in table");
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection: (NSInteger)section {
  NSLog(@"rows in section %d", section);
  switch( section ) {
    case (0):
      return 5;
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
  switch([indexPath indexAtPosition:1 ]) {
    case (3):
      return 50.0;
      break;
    case (4):
      return 216.0;
      break;
  }
  return 40.0; //returns floating point which will be used for a cell row height at specified row index  
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
            [Vmax setValue:100];
              //Vmax.minimumValue = 0;
              //Vmax.maximumValue = 100;
              //Vmax.value = 100;
            [cell addSubview: Vmax];

            UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(10, 8, 100, 20)] autorelease];
            label.font = [UIFont boldSystemFontOfSize:cellfontsize];
            label.textColor = celltextcolor;
            label.backgroundColor = [UIColor clearColor];
            label.text = @"Vmax";
            [cell addSubview: label];
          }
          break;
          case (1): {
            Vmid = [[iRocSlider alloc] initWithFrame: CGRectMake(170, 10, 125, 30)];
            [Vmid setValue:50];
            [cell addSubview: Vmid];
            UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(10, 8, 100, 20)] autorelease];
            label.font = [UIFont boldSystemFontOfSize:cellfontsize];
            label.textColor = celltextcolor;
            label.backgroundColor = [UIColor clearColor];
            label.text = @"Vmid";
            [cell addSubview: label];
          }
          break;
          case (2): {
            Vmin = [[iRocSlider alloc] initWithFrame: CGRectMake(170, 10, 125, 30)];
            [Vmin setValue:10];
            [cell addSubview: Vmin];
            UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(10, 8, 100, 20)] autorelease];
            label.font = [UIFont boldSystemFontOfSize:cellfontsize];
            label.textColor = celltextcolor;
            label.backgroundColor = [UIColor clearColor];
            label.text = @"Vmin";
            [cell addSubview: label];
          }
          break;
          //case (1):
          //switch([indexPath indexAtPosition:1]) {
          case (3): {
            autoON = [[iRocButton alloc] initWithFrame: CGRectMake(170, 5, 125, 40)];
            autoON.frame = CGRectMake(170, 5, 125, 40);
            [autoON setTitle: @"START" forState: UIControlStateNormal];
            [autoON addTarget:self action:@selector(autoONClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            
            
            [cell addSubview:autoON];
            UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(10, 15, 100, 20)] autorelease];
            label.font = [UIFont boldSystemFontOfSize:cellfontsize];
            label.textColor = celltextcolor;
            label.backgroundColor = [UIColor clearColor];
            label.text = @"Run";
            [cell addSubview: label];
          }
          break;
          case (4): {
            schedulePicker = [[UIPickerView alloc] initWithFrame: CGRectMake(0, 0, 0, 0)];
            schedulePicker.delegate = self;
            schedulePicker.dataSource = self;
            schedulePicker.showsSelectionIndicator = YES;
            [cell addSubview:schedulePicker];
              //cell.text = @"Schedule";
          }
            break;
        }
        break;
    }
  }
  
  return cell;
}

- (IBAction) autoONClicked:(id) sender {
  [autoON flipBState];
  [autoON setTitle: [autoON getBState] ? @"STOP":@"START" forState: UIControlStateNormal];
}


- (NSInteger)numberOfComponentsInPickerView:(UITableView *)tableView {
  return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component {
  NSLog(@"component=%d", component);
  return component == 0 ? [self.schedules count]:[self.blocks count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow: (NSInteger)row forComponent: (NSInteger)component {
  NSLog(@"component=%d", component);
  return component == 0 ? [self.schedules objectAtIndex: row]:[self.blocks objectAtIndex: row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent: (NSInteger)component {
}


@end
