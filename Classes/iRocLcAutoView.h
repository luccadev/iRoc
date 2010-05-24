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

#import <UIKit/UIKit.h>
#import "IRocConnector.h"
#import "iRocTableView.h"
#import "iRocButton.h"
#import "iRocSlider.h"
#import "Container.h"
#import "Loc.h"


@interface iRocLcAutoView : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
  iRocButton *autoON;
  iRocButton *halfAutoON;
  iRocButton *setInBlock;
  UIPickerView *schedulePicker;
  NSMutableArray *schedules;
  UIPickerView *blockPicker;
  NSMutableArray *blocks;
  Container *bkContainer;
	Container *scContainer;
  int blockPicked;
  int schedulePicked;
  Loc *loc;
  BOOL Auto;
	IRocConnector *rrconnection;
}
@property (nonatomic, retain) NSMutableArray *schedules;
@property (nonatomic, retain) NSMutableArray *blocks;
@property (nonatomic, retain) Container *bkContainer;
@property (nonatomic, retain) Container *scContainer;
@property (nonatomic, retain) IRocConnector *rrconnection;
@property (nonatomic, retain) Loc *loc;

- (IBAction) autoONClicked:(id) sender; 
- (IBAction) halfAutoONClicked:(id) sender; 
- (IBAction) setInBlockClicked:(id) sender; 


- (id)init;
- (void)dealloc;
- (void)setLoco:(Loc*)loco;
- (void)updateAutoButton;
- (void)setAuto:(BOOL)state;

- (NSInteger)numberOfComponentsInPickerView:(UITableView *)tableView;
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component;
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow: (NSInteger)row forComponent: (NSInteger)component;
- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent: (NSInteger)component;

@end
