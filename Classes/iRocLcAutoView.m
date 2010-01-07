//
//  iGoLcView.m
//  iGo
//
//  Created by Rocrail on 04.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "iRocLcAutoView.h"
#import "globals.h"


@implementation iRocLcAutoView
@synthesize schedules, blocks;



- (id)init {
  self = [super init];
    //self = [super initWithStyle: UITableViewStyleGrouped];
  if( self != nil ) {

    self.title = @"Automatic";
    
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
  [super.view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0]];
    
  CGRect bounds = self.view.bounds;
  
  float buttonWidth = (bounds.size.width - (2 * CONTENTBORDER + BUTTONGAP)) / 2;
  CGRect autoONFrame = CGRectMake(CONTENTBORDER, CONTENTBORDER, buttonWidth, BUTTONHEIGHT);

  autoON = [[iRocButton alloc] initWithFrame: autoONFrame];
  autoON.frame = autoONFrame;
  [autoON setTitle: @"START" forState: UIControlStateNormal];
  [autoON addTarget:self action:@selector(autoONClicked:) forControlEvents:UIControlEventTouchUpInside];
  [autoON setColor:0];
  [self.view addSubview: autoON];

  CGRect halfAutoONFrame = CGRectMake(buttonWidth + CONTENTBORDER + BUTTONGAP, CONTENTBORDER, buttonWidth, BUTTONHEIGHT);
  halfAutoON = [[iRocButton alloc] initWithFrame: halfAutoONFrame];
  halfAutoON.frame = halfAutoONFrame;
  [halfAutoON setTitle: @"HalfAuto" forState: UIControlStateNormal];
  [halfAutoON addTarget:self action:@selector(halfAutoONClicked:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview: halfAutoON];
  
  schedulePicker = [[UIPickerView alloc] initWithFrame: CGRectMake(0, CONTENTBORDER + BUTTONHEIGHT + BUTTONGAP, 0, 0)];
  schedulePicker.delegate = self;
  schedulePicker.dataSource = self;
  schedulePicker.showsSelectionIndicator = YES;
  [self.view addSubview: schedulePicker];
}

- (void)dealloc {
  [super dealloc];
}


- (IBAction) autoONClicked:(id) sender {
  [autoON flipBState];
  [autoON setTitle: [autoON getBState] ? @"STOP":@"START" forState: UIControlStateNormal];
  [autoON setColor:[autoON getBState] ? 1:0];
}

- (IBAction) halfAutoONClicked:(id) sender {
  [halfAutoON flipBState];
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
