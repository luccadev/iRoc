/*
 Rocrail - Model Railroad Software
 
 Copyright (C) 2009-2011 - Rob Versluis <r.j.versluis@rocrail.net>, Jean-Michel Fischer <jmf@polygonpunkt.de>
 
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


@interface mgv136servo : UIViewController {
	IBOutlet iRocButton *stop;
	
	IBOutlet iRocButton *servo1;
	IBOutlet iRocButton *servo2;
	IBOutlet iRocButton *servo3;
	IBOutlet iRocButton *servo4;
	
	IBOutlet iRocButton *leftPlus;
	IBOutlet iRocButton *leftMinus;
	
	IBOutlet iRocButton *rightPlus;
	IBOutlet iRocButton *rightMinus;
	
	IBOutlet iRocButton *speedPlus;
	IBOutlet iRocButton *speedMinus;
	
	IBOutlet iRocButton *testPlus;
	IBOutlet iRocButton *testMinus;
	
	IRocConnector *rrconnection;
	NSString *menuname;
	
	id delegate;
}

@property (nonatomic, retain) iRocButton *stop, *leftPlus, *leftMinus, *rightPlus, *rightMinus,
*speedPlus, *speedMinus, *testPlus, *testMinus, *servo1, *servo2, *servo3, *servo4;
@property (nonatomic, retain) IRocConnector *rrconnection;
@property (nonatomic, retain) NSString *menuname;

- (IBAction) resetClicked:(id) sender; 
- (IBAction) startClicked:(id) sender; 
- (IBAction) stopClicked:(id) sender; 

- (IBAction) leftPlusClicked:(id) sender; 
- (IBAction) leftMinusClicked:(id) sender; 

- (IBAction) rightPlusClicked:(id) sender; 
- (IBAction) rightMinusClicked:(id) sender; 

- (IBAction) speedPlusClicked:(id) sender; 
- (IBAction) speedMinusClicked:(id) sender; 

- (IBAction) testPlusClicked:(id) sender; 
- (IBAction) testMinusClicked:(id) sender; 

- (IBAction) servo1Clicked:(id) sender; 
- (IBAction) servo2Clicked:(id) sender; 
- (IBAction) servo3Clicked:(id) sender; 
- (IBAction) servo4Clicked:(id) sender; 

- (id)initWithDelegate:(id)_delegate;

- (void) setBit:(int)addr port:(int)port on:(bool) on;
- (void) sendNibble:(int) value;

- (void) anyButtonClicked;

@end


@interface NSObject (mgv136servo)
- (void)dismissModalViewController;
@end
