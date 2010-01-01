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
	IRocConnector *rrconnection;
}
@property (nonatomic, retain) iRocButton *powerON, *powerOFF;
@property (nonatomic, retain) IRocConnector *rrconnection;

- (IBAction) powerONClicked:(id) sender; 
- (IBAction) powerOFFClicked:(id) sender; 

@end
