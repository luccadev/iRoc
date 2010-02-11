//
//  iRocBlockView.h
//  iRoc
//
//  Created by Jean-Michel Fischer on 30.01.10.
//  Copyright 2010 rocrail.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iRocButton.h"
#import "Block.h"
#import "Loc.h"
#import "Container.h"


@interface iRocBlockView : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
  IBOutlet iRocButton *selectLoc;
	IBOutlet iRocButton *intoOP;
	IBOutlet iRocButton *esc;
  iRocButton *setInBlock;

  UIPickerView *locoPicker;
  NSMutableArray *locos;
  int locoPicked;
  Loc *loc;
	Container *lcContainer;

	id _delegate;
	
	UILabel* l;
	Block *_block;
}
@property (nonatomic, retain) iRocButton *selectLoc;
@property (nonatomic, retain) iRocButton *intoOP;
@property (nonatomic, retain) iRocButton *esc;
@property (nonatomic, retain) NSMutableArray *locos;
@property (nonatomic, retain) Container *lcContainer;

@property (nonatomic, retain) id _delegate;
//@property (nonatomic, retain) Block *block;

- (IBAction) selectLocClicked:(id) sender;
- (IBAction) intoOPClicked:(id) sender; 
- (IBAction) escClicked:(id) sender; 
- (IBAction) setInBlockClicked:(id) sender; 

- (void) setBlock:(Block*)block;

- (NSInteger)numberOfComponentsInPickerView:(UITableView *)tableView;
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component;
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow: (NSInteger)row forComponent: (NSInteger)component;
- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent: (NSInteger)component;


@end

@interface NSObject (iRocBlockView)
- (void)dismissModalViewController;
- (void)lcTextFieldAction;
@end