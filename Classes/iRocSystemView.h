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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "IRocConnector.h"
#import "iRocButton.h"
#import "iRocClock.h"


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
	iRocClock *clock;
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
