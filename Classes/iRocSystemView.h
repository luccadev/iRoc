//
//  iGoSystemView.h
//  iGo
//
//  Created by Rocrail on 31.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "IRocConnector.h"
#import "iRocButton.h"


@interface iRocSystemView : UIViewController{
  IBOutlet iRocButton *powerON;
  IBOutlet iRocButton *powerOFF;
  IBOutlet iRocButton *initField;
  IBOutlet iRocButton *autoON;
  IBOutlet iRocButton *autoStart;
	IRocConnector *rrconnection;
  BOOL Power;
  BOOL Auto;
  UIAlertView *autoStartAlert;
}
@property (nonatomic, retain) iRocButton *powerON, *powerOFF, *initField, *autoON, *autoStart;
@property (nonatomic, retain) IRocConnector *rrconnection;

- (IBAction) powerONClicked:(id) sender; 
- (IBAction) powerOFFClicked:(id) sender; 
- (IBAction) initFieldClicked:(id) sender; 
- (IBAction) autoONClicked:(id) sender; 
- (IBAction) autoStartClicked:(id) sender; 

- (void)setPower:(BOOL)state;
- (void)setAuto:(BOOL)state;
@end
