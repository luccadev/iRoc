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


@interface iRocLcAutoView : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
  iRocButton *autoON;
  iRocButton *halfAutoON;
  iRocButton *setInBlock;
  UIPickerView *schedulePicker;
  NSMutableArray *schedules;
  UIPickerView *blockPicker;
  NSMutableArray *blocks;
}
@property (nonatomic, retain) NSMutableArray *schedules;
@property (nonatomic, retain) NSMutableArray *blocks;

- (IBAction) autoONClicked:(id) sender; 
- (IBAction) halfAutoONClicked:(id) sender; 
- (IBAction) setInBlockClicked:(id) sender; 


- (id)init;
- (void)dealloc;

- (NSInteger)numberOfComponentsInPickerView:(UITableView *)tableView;
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component;
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow: (NSInteger)row forComponent: (NSInteger)component;
- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent: (NSInteger)component;

@end
