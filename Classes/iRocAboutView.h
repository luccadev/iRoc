//
//  iRocAboutView.h
//  iRoc
//
//  Created by Jean-Michel Fischer on 06.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface iRocAboutView : UIViewController {
	IBOutlet UILabel *labelVersion;
	NSString *menuname;
}

@property (nonatomic, retain) UILabel *labelVersion;
@property (nonatomic, retain) NSString *menuname;

@end
