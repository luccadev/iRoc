//
//  iGoLcView.h
//  iGo
//
//  Created by Rocrail on 04.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iRocTableView.h"
#import "iRocButton.h"
#import "iRocSlider.h"


@interface iRocLcAutoView : iRocTableView <UIPickerViewDelegate, UIPickerViewDataSource> {
  iRocSlider *Vmax;
  iRocSlider *Vmid;
  iRocSlider *Vmin;
  iRocButton *autoON;
  UIPickerView *schedulePicker;
  NSMutableArray *schedules;
  UIPickerView *blockPicker;
  NSMutableArray *blocks;
}
@property (nonatomic, retain) NSMutableArray *schedules;
@property (nonatomic, retain) NSMutableArray *blocks;

- (IBAction) autoONClicked:(id) sender; 


- (id)init;
- (void)dealloc;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection: (NSInteger)section;
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

- (NSInteger)numberOfComponentsInPickerView:(UITableView *)tableView;
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component;
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow: (NSInteger)row forComponent: (NSInteger)component;
- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent: (NSInteger)component;

@end
