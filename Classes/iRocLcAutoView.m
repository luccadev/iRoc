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

#import "iRocLcAutoView.h"
#import "Globals.h"
#import "Block.h"
#import "Schedule.h"


@implementation iRocLcAutoView
@synthesize schedules, blocks, bkContainer, scContainer, rrconnection, loc;



- (id)init {
  self = [super init];
    //self = [super initWithStyle: UITableViewStyleGrouped];
  if( self != nil ) {
    Auto = FALSE;

    self.title = NSLocalizedString(@"Automatic", @"");
    
    schedules = [[NSMutableArray alloc] init];
    blocks = [[NSMutableArray alloc] init];

  
  }
  return self;
}

- (void)loadView {
  [super loadView];
  if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
    [super.view setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1.0]];
  else
    [super.view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0]];

  [blocks removeAllObjects];
  [blocks addObject: NSLocalizedString(@"none", @"")];
  int cnt = [bkContainer count];
  NSLog(@"number of blocks=%d", cnt);
  for( int i = 0; i < cnt; i++ ) {
    Block *bk = (Block*)[bkContainer objectAtIndex:i];
    [blocks addObject: bk.ID];
  }
  
  [schedules removeAllObjects];
  [schedules addObject: NSLocalizedString(@"none", @"")];
  cnt = [scContainer count];
  NSLog(@"number of schedules=%d", cnt);
  for( int i = 0; i < cnt; i++ ) {
    Schedule *sc = (Schedule*)[scContainer objectAtIndex:i];
    [schedules addObject: sc.ID];
  }
  
  CGRect bounds = self.view.bounds;
  
  float buttonWidth = (bounds.size.width - (2 * CONTENTBORDER + BUTTONGAP)) / 2;
  
  CGRect autoONFrame = CGRectMake(CONTENTBORDER, BUTTONGAP, buttonWidth, BUTTONHEIGHT);
  autoON = [[iRocButton alloc] initWithFrame: autoONFrame];
  autoON.frame = autoONFrame;
  [autoON setTitle: NSLocalizedString(@"START", @"") forState: UIControlStateNormal];
  [autoON addTarget:self action:@selector(autoONClicked:) forControlEvents:UIControlEventTouchUpInside];
  [autoON setColor:3];
  [autoON setEnabled:Auto];
  [self.view addSubview: autoON];

  CGRect halfAutoONFrame = CGRectMake(buttonWidth + CONTENTBORDER + BUTTONGAP, BUTTONGAP, buttonWidth, BUTTONHEIGHT);
  halfAutoON = [[iRocButton alloc] initWithFrame: halfAutoONFrame];
  halfAutoON.frame = halfAutoONFrame;
  [halfAutoON setTitle: NSLocalizedString(@"HalfAuto", @"") forState: UIControlStateNormal];
  [halfAutoON addTarget:self action:@selector(halfAutoONClicked:) forControlEvents:UIControlEventTouchUpInside];
  [halfAutoON setColor:3];
  [self.view addSubview: halfAutoON];
  
  schedulePicker = [[UIPickerView alloc] initWithFrame: CGRectMake(CONTENTBORDER, BUTTONHEIGHT + 2* BUTTONGAP, 2 * buttonWidth + BUTTONGAP, 2*BUTTONHEIGHT)];
  schedulePicker.delegate = self;
  schedulePicker.dataSource = self;
  schedulePicker.showsSelectionIndicator = YES;
  schedulePicker.backgroundColor = [UIColor clearColor];
  [self.view addSubview: schedulePicker];
	
  if ([[[UIDevice currentDevice] systemVersion] floatValue] <= 6) {
  	// Mask for better look
	  UIImageView *maskview = [[UIImageView alloc] initWithFrame: CGRectMake(0, BUTTONHEIGHT + BUTTONGAP - 5, 320, 219)];
	  maskview.image = [UIImage imageNamed:@"mask.png"];
	  [self.view addSubview: maskview];
	}
  
  CGRect setInBlockFrame = CGRectMake( CONTENTBORDER, 4 * BUTTONHEIGHT + 3 * BUTTONGAP, 2 * buttonWidth + BUTTONGAP, BUTTONHEIGHT);
  setInBlock = [[iRocButton alloc] initWithFrame: setInBlockFrame];
  setInBlock.frame = setInBlockFrame;
  [setInBlock setTitle: NSLocalizedString(@"Set in block", @"") forState: UIControlStateNormal];
  [setInBlock addTarget:self action:@selector(setInBlockClicked:) forControlEvents:UIControlEventTouchUpInside];
  [setInBlock setColor:3];
  [self.view addSubview: setInBlock];
  
}

- (void)dealloc {
  [super dealloc];
}

- (void)setLoco:(Loc*)loco {
  self.loc = loco;
  [autoON setBState:[loc isAutoMode]];
  [self updateAutoButton];
	
	self.title = [NSString stringWithFormat:@"%@ [%@]", 
								NSLocalizedString(@"Automatic", @""),
								[loc locid]];
}

- (void)updateAutoButton{
  [autoON setTitle: [autoON getBState] ? NSLocalizedString(@"STOP", @""):NSLocalizedString(@"START", @"") forState: UIControlStateNormal];
  [autoON setColor:[autoON getBState] ? 1:0];
}

- (IBAction) autoONClicked:(id) sender {
  [autoON flipBState];
  [self updateAutoButton];
  [halfAutoON setEnabled:![autoON getBState]];
  [setInBlock setEnabled:![autoON getBState]];
  if([autoON getBState]) {
      // Send optional destination block or schedule before sending the start auto command.
    if( [halfAutoON getBState] ) {
      NSString * stringToSend = [[NSString alloc] initWithString: 
                                 [NSString stringWithFormat: @"<lc id=\"%@\" cmd=\"gomanual\"/>",
                                  loc.locid ]];
      [rrconnection sendMessage:@"lc" message:stringToSend];
    }
    else if ( blockPicked > 0 ) {
      NSString * stringToSend = [[NSString alloc] initWithString: 
                                 [NSString stringWithFormat: @"<lc id=\"%@\" cmd=\"gotoblock\" blockid=\"%@\"/>",
                                  loc.locid, [blocks objectAtIndex: blockPicked] ]];
      [rrconnection sendMessage:@"lc" message:stringToSend];
      stringToSend = [[NSString alloc] initWithString: 
											[NSString stringWithFormat: @"<lc id=\"%@\" cmd=\"go\"/>",
											 loc.locid ]];
      [rrconnection sendMessage:@"lc" message:stringToSend];
    }
    else if( schedulePicked > 0 ) {
      NSString * stringToSend = [[NSString alloc] initWithString: 
                                 [NSString stringWithFormat: @"<lc id=\"%@\" cmd=\"useschedule\" scheduleid=\"%@\"/>",
                                  loc.locid, [schedules objectAtIndex: schedulePicked] ]];
      [rrconnection sendMessage:@"lc" message:stringToSend];
      stringToSend = [[NSString alloc] initWithString: 
                                 [NSString stringWithFormat: @"<lc id=\"%@\" cmd=\"go\"/>",
                                  loc.locid ]];
      [rrconnection sendMessage:@"lc" message:stringToSend];
    }
    else {
      NSString * stringToSend = [[NSString alloc] initWithString: 
                                 [NSString stringWithFormat: @"<lc id=\"%@\" cmd=\"go\"/>",
                                  loc.locid ]];
      [rrconnection sendMessage:@"lc" message:stringToSend];
    }
  }
  else {
    NSString * stringToSend = [[NSString alloc] initWithString: 
                               [NSString stringWithFormat: @"<lc id=\"%@\" cmd=\"stop\"/>",
                                loc.locid ]];
    [rrconnection sendMessage:@"lc" message:stringToSend];
  }
}

- (IBAction) halfAutoONClicked:(id) sender {
  [halfAutoON flipBState];
}


- (IBAction) setInBlockClicked:(id) sender {
  if ( blockPicked > 0 ) { 
    NSString * stringToSend = [[NSString alloc] initWithString: //<lc id=.. cmd="block" blockid=... />
                               [NSString stringWithFormat: @"<lc id=\"%@\" cmd=\"block\" blockid=\"%@\"/>",
                                 loc.locid, [blocks objectAtIndex: blockPicked]]];
    [rrconnection sendMessage:@"lc" message:stringToSend];
  }
}


- (NSInteger)numberOfComponentsInPickerView:(UITableView *)tableView {
  return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component {
  NSLog(@"component=%d", (int)component);
  return component == 1 ? [self.schedules count]:[self.blocks count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow: (NSInteger)row forComponent: (NSInteger)component {
  NSLog(@"component=%d", (int)component);
  return component == 1 ? [self.schedules objectAtIndex: row]:[self.blocks objectAtIndex: row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent: (NSInteger)component {
  if( [halfAutoON getBState] ) {
    [pickerView selectRow:0 inComponent:0 animated:TRUE];
    [pickerView selectRow:0 inComponent:1 animated:TRUE];
  }
  else if( component == 0 ) {
    blockPicked = (int)row;
    if( row > 0 ) {
      schedulePicked = 0;
      [pickerView selectRow:0 inComponent:1 animated:TRUE];
    }
  }
  else if( component == 1 ) {
    schedulePicked = (int)row;
    if( row > 0 ) {
      blockPicked = 0;
      [pickerView selectRow:0 inComponent:0 animated:TRUE];
    }
  }
}


- (void)setAuto:(BOOL)state {
  Auto = state;
  [autoON setEnabled:Auto];
}


@end
