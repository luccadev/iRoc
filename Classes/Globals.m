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

#import "Globals.h"

@implementation Globals

+ (NSString*)getAttribute:(NSString*)attrName fromDict:(NSDictionary *)attributeDict withDefault:(NSString *)defValue {
  NSString *attrVal = [attributeDict valueForKey:attrName]; 
  return attrVal==nil ? defValue:[[NSString alloc]initWithString: attrVal];
}

static SystemSoundID click = 0;
static SystemSoundID chrr = 0;
static NSUserDefaults *defaults = 0;

+ (SystemSoundID)getClick {
  if( click == 0 ) {
    AudioServicesCreateSystemSoundID(CFBundleCopyResourceURL(CFBundleGetMainBundle(), CFSTR("click"), CFSTR("aif"), NULL), &click);
  }
  
  return click;
}

+ (SystemSoundID)getChrr {
  if( chrr == 0 ) {
    AudioServicesCreateSystemSoundID(CFBundleCopyResourceURL(CFBundleGetMainBundle(), CFSTR("chrr"), CFSTR("aif"), NULL), &chrr);
  }
  
  return chrr;
}

+ (NSUserDefaults*)getDefaults {
  if( defaults == 0 ) {
    defaults = [[NSUserDefaults standardUserDefaults] retain];
  }
  
  return defaults;
}


+ (UIColor*)getTextColor {
  if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
    return [UIColor darkTextColor];
  else
    return [UIColor lightTextColor];
}


@end
