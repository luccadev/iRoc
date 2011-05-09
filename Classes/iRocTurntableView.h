//
//  iRocTurntableView.h
//  iRoc
//
//  Created by Jean-Michel Fischer on 09.05.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iRocButton.h"
#import "Turntable.h"

@interface iRocTurntableView : UIViewController {
    
    IBOutlet iRocButton *esc;
    id _delegate;
    
    Turntable *_tt;
}

@property (nonatomic, retain) id _delegate;
@property (nonatomic, retain) iRocButton *esc;

- (IBAction) escClicked:(id) sender; 
- (void) setTurntable:(Turntable*)tt;

@end


@interface NSObject (iRocTurntableView)
- (void)dismissModalViewController;
@end
