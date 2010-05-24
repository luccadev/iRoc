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