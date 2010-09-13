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
#import "Loc.h"
#import "Container.h"
#import "iRocLocoPicker.h"


@interface iRocLcSettingsView : iRocTableView {
  iRocSlider *Vmax;
  iRocSlider *Vmid;
  iRocSlider *Vmin;
  iRocButton *Placing;
	iRocButton *Commuter;
	iRocButton *Dispatch;
	iRocButton *writeCV;
	iRocButton *setConsist;
	iRocButton *clearConsist;
	UITextField *textVal;
	UITextField *textCV;
	
	iRocLocoPicker *locoPickerButton;
	Container *lcContainer;

  Loc *loc;
	IRocConnector *rrconnection;
	
	Model *model;
	id delegate;	
	
}
@property (nonatomic, retain) IRocConnector *rrconnection;
@property (nonatomic, retain) Loc *loc;
@property (nonatomic, retain) Container *lcContainer;

- (id)init;
- (id)initWithDelegate:(id)_delegate andModel:(Model*)_model;
- (void)dealloc;
- (void)setLoco:(Loc*)loco;
- (void)updatePlacing;
- (void)updateCommuter;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection: (NSInteger)section;
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
