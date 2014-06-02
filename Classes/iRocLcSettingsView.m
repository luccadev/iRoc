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

#import "iRocLcSettingsView.h"
#import "Globals.h"


@implementation iRocLcSettingsView

@synthesize rrconnection, loc, lcContainer;


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

- (id)initWithDelegate:(id)_delegate andModel:(Model *)_model {
  if( self = [super init] ) {
    NSLog(@"init loco settings view");
    delegate = _delegate;
    model = _model;
		
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
	
	self.title = [NSString stringWithFormat:@"%@ [%@]", 
											NSLocalizedString(@"Settings", @""),
											[loc locid]];
	 
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  NSLog(@"sections in table");
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection: (NSInteger)section {
  NSLog(@"rows in section %d", (int)section);
  switch( section ) {
    case (0):
      return 12;
      break;
    case (1):
      return 2;
      break;
  }
  return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  NSLog(@"title for section %d", (int)section);
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
  //NSLog(@"cell height for %d:%d", [indexPath indexAtPosition:0 ], [indexPath indexAtPosition:1 ]);
	
	if ([indexPath indexAtPosition:1 ] == 10) {
		return 80;
	} else {
		return 50.0; //returns floating point which will be used for a cell row height at specified row index  
	}
  
}  


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  //NSLog(@"cell for %d:%d", [indexPath indexAtPosition:0 ], [indexPath indexAtPosition:1 ]);

  NSString *CellIdentifier = [ NSString stringWithFormat: @"%d:%d", (int)[indexPath indexAtPosition:0 ],
                              (int)[ indexPath indexAtPosition:1 ] ];
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
  	
	
  if( cell == nil ) {
    cell = [[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: CellIdentifier ] autorelease ];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
      //cell.selectionStyle = UITableViewCellSelectionStyleGray;

    switch([indexPath indexAtPosition:0 ]) {
      case (0):
        switch([indexPath indexAtPosition:1]) {
          case (0): {
            Vmax = [[iRocSlider alloc] initWithFrame: CGRectMake(170, 10, 125, 30)];
            [Vmax setValue:[loc getVmax]];
            Vmax.minimumValue = 0;
            Vmax.maximumValue = 100;
            Vmax.value = [loc getVmax];
            [Vmax addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
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
            Vmid.minimumValue = 0;
            Vmid.maximumValue = 100;
            Vmid.value = [loc getVmid];
            [Vmid addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
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
            Vmin.minimumValue = 0;
            Vmin.maximumValue = 100;
            Vmin.value = [loc getVmin];
            [Vmin addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
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
						
					case (4): { 
            Dispatch = [[iRocButton alloc] initWithFrame: CGRectMake(170, 10, 125, 30)];
            Dispatch.frame = CGRectMake(170, 10, 125, 30);
            [Dispatch addTarget:self action:@selector(dispatchClicked:) forControlEvents:UIControlEventTouchUpInside];
						[Dispatch setTitle: NSLocalizedString(@"Dispatch", @"") forState:UIControlStateNormal];
            [cell addSubview: Dispatch];
            UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(CONTENTBORDER, 10, 100, 30)] autorelease];
            label.font = [UIFont boldSystemFontOfSize:cellfontsize];
            label.textColor = celltextcolor;
            label.backgroundColor = [UIColor clearColor];
            label.text = NSLocalizedString(@"Fred", @"");
            [cell addSubview: label];
          }
            break;
						
					case (5): {
            Commuter = [[iRocButton alloc] initWithFrame: CGRectMake(170, 10, 125, 30)];
            Commuter.frame = CGRectMake(170, 10, 125, 30);
						[Commuter setBState: [loc isCommuter]];
            [Commuter addTarget:self action:@selector(commuterClicked:) forControlEvents:UIControlEventTouchUpInside];
						[Commuter setTitle: NSLocalizedString(@"Commuter", @"") forState:UIControlStateNormal];
            [cell addSubview: Commuter];
            UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(CONTENTBORDER, 10, 100, 30)] autorelease];
            label.font = [UIFont boldSystemFontOfSize:cellfontsize];
            label.textColor = celltextcolor;
            label.backgroundColor = [UIColor clearColor];
            label.text = NSLocalizedString(@"Commuter", @"");
            [cell addSubview: label];
          }
            break;
						
					case (6): {
						UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(CONTENTBORDER, 10, 100, 30)] autorelease];
            label.font = [UIFont boldSystemFontOfSize:cellfontsize];
            label.textColor = celltextcolor;
            label.backgroundColor = [UIColor clearColor];
            label.text = NSLocalizedString(@"POM", @"");
            [cell addSubview: label];
						
						writeCV = [[iRocButton alloc] initWithFrame: CGRectMake(170, 10, 125, 30)];
						[writeCV setTitle: NSLocalizedString(@"Write", @"") forState:UIControlStateNormal];
						[writeCV addTarget:self action:@selector(writeClicked:) forControlEvents:UIControlEventTouchUpInside];
						[cell addSubview: writeCV];						
					}
						break;
          case (7): {
						UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(CONTENTBORDER, 10, 100, 30)] autorelease];
            label.font = [UIFont boldSystemFontOfSize:cellfontsize];
            label.textColor = celltextcolor;
            label.backgroundColor = [UIColor clearColor];
            label.text = NSLocalizedString(@"CV", @"");
            [cell addSubview: label];
						
						textCV = [[[UITextField alloc] initWithFrame:CGRectMake(170, 10, 125, 30)] autorelease];						
						textCV.keyboardType = UIKeyboardTypeNumberPad;
						textCV.textColor = [UIColor blackColor];
						textCV.backgroundColor = [UIColor whiteColor];
						textCV.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
						textCV.textAlignment = UITextAlignmentCenter;	
						textCV.clearsOnBeginEditing = YES;
						[textCV resignFirstResponder];
						
						textCV.text = @"1";
						[cell addSubview: textCV];
					}
						 break;
					case (8): {
						UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(CONTENTBORDER, 10, 100, 30)] autorelease];
            label.font = [UIFont boldSystemFontOfSize:cellfontsize];
            label.textColor = celltextcolor;
            label.backgroundColor = [UIColor clearColor];
            label.text = NSLocalizedString(@"Value", @"");
            [cell addSubview: label];
						
						textVal = [[[UITextField alloc] initWithFrame:CGRectMake(170, 10, 125, 30)] autorelease];						
						textVal.keyboardType = UIKeyboardTypeNumberPad;
						textVal.textColor = [UIColor blackColor];
						textVal.backgroundColor = [UIColor whiteColor];
						textVal.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
						textVal.textAlignment = UITextAlignmentCenter;		
						textVal.clearsOnBeginEditing = YES;
						[textVal resignFirstResponder];
						
						textVal.text = @"1";
						[cell addSubview: textVal];
					}
					break;
						
					case (9): {
						UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(CONTENTBORDER, 10, 200, 30)] autorelease];
            label.font = [UIFont boldSystemFontOfSize:cellfontsize];
            label.textColor = celltextcolor;
            label.backgroundColor = [UIColor clearColor];
            label.text = NSLocalizedString(@"Consist:", @"");
            [cell addSubview: label];
					}
						break;
							
					case (10): {
						
						CGRect locoPickerButtonFrame = CGRectMake(CONTENTBORDER, 10, 287, 64);
						locoPickerButton = [[iRocLocoPicker alloc] initWithFrame: locoPickerButtonFrame];
						locoPickerButton.delegate = self;						
						[locoPickerButton setLocContainer:model.lcContainer];
						[locoPickerButton addTarget:self action:@selector(locoPickerClicked:) forControlEvents:UIControlEventTouchUpInside];
						[cell addSubview: locoPickerButton];
						
						Loc *consistLoco = [model.lcContainer objectWithId:loc.consist];
						if( consistLoco != NULL) {
							[locoPickerButton setLoc:consistLoco];
							[clearConsist setEnabled:YES];
							[setConsist setEnabled:NO];
						} else {
							[locoPickerButton setLoc:NULL];
							[locoPickerButton setText:NSLocalizedString(@"No consist loco.",@"")];
							[setConsist setEnabled:NO];
							[clearConsist setEnabled:NO];
						}
					
					}
						break;
						
					case (11): {
						
						setConsist = [[iRocButton alloc] initWithFrame: CGRectMake(CONTENTBORDER, 10, 135, 30)];
						[setConsist setTitle: NSLocalizedString(@"Set consist", @"") forState:UIControlStateNormal];
						[setConsist addTarget:self action:@selector(setConsistClicked:) forControlEvents:UIControlEventTouchUpInside];
						[cell addSubview: setConsist];
												
						clearConsist = [[iRocButton alloc] initWithFrame: CGRectMake(160, 10, 135, 30)];
						[clearConsist setTitle: NSLocalizedString(@"Clear consist", @"") forState:UIControlStateNormal];
						[clearConsist addTarget:self action:@selector(clearConsistClicked:) forControlEvents:UIControlEventTouchUpInside];
						[cell addSubview: clearConsist];
						
						if( [locoPickerButton getLoc] != NULL ){
							[clearConsist setEnabled:YES];
							[setConsist setEnabled:NO];
						} else {
							[setConsist setEnabled:NO];
							[clearConsist setEnabled:NO];
						}

					}
						break;
						
					case (12): {
						NSArray *itemArray = [NSArray arrayWithObjects: @"Steam", @"Diesal", @"Electric", nil];
						UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
						segmentedControl.frame = CGRectMake(CONTENTBORDER, 10, 300, 30);
						segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
						segmentedControl.tintColor = [UIColor grayColor];
				
						segmentedControl.selectedSegmentIndex = 1;
						[cell addSubview: segmentedControl];
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

- (IBAction) dispatchClicked:(id) sender {
  NSString * stringToSend = [[NSString alloc] initWithString: 
                             [NSString stringWithFormat: @"<lc id=\"%@\" cmd=\"dispatch\"/>",
                              loc.locid]];
  [rrconnection sendMessage:@"lc" message:stringToSend];
} 

- (IBAction) commuterClicked:(id) sender {
	[Commuter flipBState];
  [self updateCommuter];
  NSString * stringToSend = [[NSString alloc] initWithString: 
                             [NSString stringWithFormat: @"<model cmd=\"modify\"><lc id=\"%@\" commuter=\"%@\"/></model>",
                              loc.locid, [Commuter getBState]?@"true":@"false"]];
  [rrconnection sendMessage:@"model" message:stringToSend];
} 

- (IBAction) writeClicked:(id) sender {
 
  NSString * stringToSend = [[NSString alloc] initWithString: 
                             [NSString stringWithFormat: @"<program cmd=\"1\" addr=\"%@\" cv=\"%@\" value=\"%@\" longaddr=\"%@\" pom=\"true\" decaddr=\"%@\" />",
														  loc.locid, textCV.text, textVal.text, @"true", loc.addr  ]];
  [rrconnection sendMessage:@"program" message:stringToSend];
	
	
	[textCV resignFirstResponder];
	[textVal resignFirstResponder];
}  

- (IBAction) setConsistClicked:(id) sender {
	
	NSString * stringToSend = [[NSString alloc] initWithString: 
                             [NSString stringWithFormat: @"<model cmd=\"modify\"><lc id=\"%@\" consist=\"%@\"/></model>",
														  loc.locid, [locoPickerButton getLoc].locid ]];
  [rrconnection sendMessage:@"model" message:stringToSend];
	
	NSLog(@"setConsist: %@", stringToSend);
	
	[clearConsist setEnabled:YES];
	[setConsist setEnabled:NO];
	
	
	[delegate updateLabels];
	
} 

- (IBAction) clearConsistClicked:(id) sender {
	
	NSString * stringToSend = [[NSString alloc] initWithString: 
                             [NSString stringWithFormat: @"<model cmd=\"modify\"><lc id=\"%@\" consist=\"\"/></model>",
														  loc.locid]];
  [rrconnection sendMessage:@"model" message:stringToSend];
	
	
	NSLog(@"clearConsist: %@", stringToSend);
	
	[setConsist setEnabled:NO];
	[clearConsist setEnabled:NO];
	[locoPickerButton setLoc:NULL];
	[locoPickerButton setText:NSLocalizedString(@"No consist loco.",@"")];
	
	//[delegate.locProps updateLabels];

	[delegate updateLabels];
}

- (IBAction) locoPickerClicked:(id) sender {
	NSLog(@"locoPickerClicked ...");
	
	[setConsist setEnabled:YES];
}



- (void) updatePlacing {
  [Placing setTitle: [Placing getBState] ? NSLocalizedString(@"Swapped", @""):NSLocalizedString(@"Normal", @"") forState: UIControlStateNormal];
}  

- (void) updateCommuter {
  [Commuter setTitle: [Commuter getBState] ? NSLocalizedString(@"Commuter", @""):NSLocalizedString(@"Normal", @"") forState: UIControlStateNormal];
}

- (void) sliderValueChanged: (id)sender {
  if( Vmax == sender ) {
    NSLog(@"VMax = %d", [Vmax getValue]);
    [loc sendVmax:[Vmax getValue]];
  }
  else if( Vmid == sender ) {
    NSLog(@"VMid = %d", [Vmid getValue]);
    [loc sendVmid:[Vmid getValue]];
  }
  if( Vmin == sender ) {
    NSLog(@"VMin = %d", [Vmin getValue]);
    [loc sendVmin:[Vmin getValue]];
  }
}



@end
