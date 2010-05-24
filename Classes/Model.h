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
#import "Container.h"
#import "Track.h"
#import "Sensor.h"
#import "Text.h"


@interface Model : NSObject {
  NSString *title;
  NSString *name;
  NSString *rocrailversion;
  NSString *rocguiversion;
  
	Container *levelContainer;
	Container *swContainer;
	Container *sgContainer;
	Container *tkContainer;
	Container *fbContainer;
	Container *bkContainer;
	Container *coContainer;
	Container *txContainer;
  Container *rtContainer;
	Container *lcContainer;
	Container *scContainer;
  

}
@property(nonatomic, retain) Container *levelContainer, *swContainer, *sgContainer, *tkContainer, 
    *fbContainer, *bkContainer, *coContainer, *txContainer, *rtContainer, *lcContainer, *scContainer;
@property(nonatomic, retain) NSString *title, *name, *rocguiversion, *rocrailversion;

- (void) setupWithAttributeDict: (NSDictionary *)attributeDict;


@end
