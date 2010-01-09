//
//  iGoLcView.h
//  iGo
//
//  Created by Rocrail on 04.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IRocConnector.h"
#import "iRocTableView.h"
#import "iRocButton.h"
#import "iRocSlider.h"
#import "Loc.h"


@interface iRocLcSettingsView : iRocTableView {
  iRocSlider *Vmax;
  iRocSlider *Vmid;
  iRocSlider *Vmin;
  iRocButton *Placing;

  Loc *loc;
	IRocConnector *rrconnection;
}
@property (nonatomic, retain) IRocConnector *rrconnection;
@property (nonatomic, retain) Loc *loc;

- (id)init;
- (void)dealloc;
- (void)setLoco:(Loc*)loco;
- (void)updatePlacing;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection: (NSInteger)section;
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
