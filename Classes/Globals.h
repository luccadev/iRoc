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
#define BUTTONGAP 8
#define BUTTONHEIGHT 64
#define CONTENTBORDER 8
#define ITEMSIZE 32

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface Globals : NSObject {
}

+ (NSString*)getAttribute:(NSString*)attrName fromDict:(NSDictionary *)attributeDict withDefault:(NSString *)defValue;
+ (SystemSoundID)getClick;
+ (SystemSoundID)getChrr;
+ (NSUserDefaults*)getDefaults;
+ (UIColor*)getTextColor;

@end
