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
#import "Model.h"

@interface iRocAboutView : UIViewController {
	UILabel *irocVersion;
	UILabel *rocrailVersion;
  UILabel *rocrailConnection;
	NSString *menuname;
  Model* model;
  id delegate;
}

@property (nonatomic, retain) UILabel *irocVersion, *rocrailVersion, *rocrailConnection;
@property (nonatomic, retain) NSString *menuname;


- (id)initWithDelegate:(id)_delegate andModel:(Model*)_model;

@end
