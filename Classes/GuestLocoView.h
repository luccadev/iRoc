/*
 Rocrail - Model Railroad Software
 
 Copyright (C) 2009-2014 - Rob Versluis <r.j.versluis@rocrail.net>
 
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

#import <Foundation/Foundation.h>
#import "IRocConnector.h"
#import "iRocButton.h"
#import "Model.h"

@class DetailView;

@interface GuestLocoView : UIViewController <UITextFieldDelegate, UIScrollViewDelegate> {
	IRocConnector *rrconnection;
  Model *model;
  id delegate;
  UITextField* textAddr;
  UITextField* textID;
  UISegmentedControl *speedSteps;
  UISegmentedControl *protocol;
  iRocButton *buttonAdd;
  iRocButton *buttonCancel;
  NSString* addressText;
  NSString* shortIDText;
  NSString* speedStepsText;
  NSString* protocolText;
  NSString *menuname;
	UIScrollView *scrollView;

}
@property (nonatomic, retain) DetailView *detailView;
@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) IRocConnector *rrconnection;
@property (nonatomic, retain) NSString *menuname;

- (id)initWithDelegate:(id)_delegate andModel:(Model*)_model;
- (IBAction) buttonAddClicked:(id) sender;
- (void) protocolClicked:(id)sender;
- (void) speedStepsClicked:(id)sender;


@end
