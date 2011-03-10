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

@class iRocButton;

@interface iRocButton : UIButton {
	CGContextRef context;
	int began, moved, ended;
	int touchState;
	
	BOOL hasLED;
	
	BOOL bState;
  int color; // 0 = default, 1 = red, 2 = green, 3 = blue
}

- (void) setColor:(int) clr;
- (void) setBState:(BOOL) staten;
- (BOOL) getBState;
- (void) flipBState;
- (void) setLED;

//@property (nonatomic) BOOL state; 

@end
