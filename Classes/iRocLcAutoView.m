//
//  iGoLcView.m
//  iGo
//
//  Created by Rocrail on 04.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "iRocLcAutoView.h"
#import "globals.h"
#import "Block.h"
#import "Schedule.h"


@implementation iRocLcAutoView
@synthesize schedules, blocks, bkContainer, scContainer;



- (id)init {
  self = [super init];
    //self = [super initWithStyle: UITableViewStyleGrouped];
  if( self != nil ) {

    self.title = @"Automatic";
    
    schedules = [[NSMutableArray alloc] init];
    blocks = [[NSMutableArray alloc] init];

  
  }
  return self;
}

- (void)loadView {
  [super loadView];
  [super.view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0]];

  [blocks removeAllObjects];
  [blocks addObject: @"none"];
  int cnt = [bkContainer count];
  NSLog(@"number of blocks=%d", cnt);
  for( int i = 0; i < cnt; i++ ) {
    Block *bk = (Block*)[bkContainer objectAtIndex:i];
    [blocks addObject: bk.ID];
  }
  
  [schedules removeAllObjects];
  [schedules addObject: @"none"];
  cnt = [scContainer count];
  NSLog(@"number of schedules=%d", cnt);
  for( int i = 0; i < cnt; i++ ) {
    Schedule *sc = (Schedule*)[scContainer objectAtIndex:i];
    [schedules addObject: sc.ID];
  }
  
  CGRect bounds = self.view.bounds;
  
  float buttonWidth = (bounds.size.width - (2 * CONTENTBORDER + BUTTONGAP)) / 2;
  
  CGRect autoONFrame = CGRectMake(CONTENTBORDER, 0, buttonWidth, BUTTONHEIGHT);
  autoON = [[iRocButton alloc] initWithFrame: autoONFrame];
  autoON.frame = autoONFrame;
  [autoON setTitle: @"START" forState: UIControlStateNormal];
  [autoON addTarget:self action:@selector(autoONClicked:) forControlEvents:UIControlEventTouchUpInside];
  [autoON setColor:0];
  [self.view addSubview: autoON];

  CGRect halfAutoONFrame = CGRectMake(buttonWidth + CONTENTBORDER + BUTTONGAP, 0, buttonWidth, BUTTONHEIGHT);
  halfAutoON = [[iRocButton alloc] initWithFrame: halfAutoONFrame];
  halfAutoON.frame = halfAutoONFrame;
  [halfAutoON setTitle: @"HalfAuto" forState: UIControlStateNormal];
  [halfAutoON addTarget:self action:@selector(halfAutoONClicked:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview: halfAutoON];
  
  schedulePicker = [[UIPickerView alloc] initWithFrame: CGRectMake(0, BUTTONHEIGHT + BUTTONGAP, 0, 0)];
  schedulePicker.delegate = self;
  schedulePicker.dataSource = self;
  schedulePicker.showsSelectionIndicator = YES;
  [self.view addSubview: schedulePicker];


  CGRect setInBlockFrame = CGRectMake( CONTENTBORDER, BUTTONHEIGHT + BUTTONGAP + 216 + BUTTONGAP, 2 * buttonWidth + BUTTONGAP, BUTTONHEIGHT);
  setInBlock = [[iRocButton alloc] initWithFrame: setInBlockFrame];
  setInBlock.frame = setInBlockFrame;
  [setInBlock setTitle: @"Set in block" forState: UIControlStateNormal];
  [setInBlock addTarget:self action:@selector(setInBlockClicked:) forControlEvents:UIControlEventTouchUpInside];
  [setInBlock setColor:3];
  [self.view addSubview: setInBlock];
  
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


- (IBAction) setInBlockClicked:(id) sender {
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
