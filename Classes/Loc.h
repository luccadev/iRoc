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

@interface Loc : NSObject {
@private 
	NSString *locpicdata;
	NSString *imgname;
	NSString *desc;
	NSString *roadname;
	NSString *dir;
	NSString *vstr;
	NSString *Placing;
	NSString *Vmax;
	NSString *Vmid;
	NSString *Vmin;
	NSString *SpCnt;
	NSString *Vmode;
	NSString *Fn;
	NSString *Fx;
	NSString *addr;
	NSString *consist;
	
	NSString *f0, *f1, *f2, *f3, *f4, *f5, *f6, *f7, *f8, *f9, *f10, *f11, *f12, *f13, *f14, *f15, *f16;
	
	NSString *Mode;
	int vint;
	
	NSString *vmaxstr;
	int vmax;
	BOOL fnStates[32];

	UIImage *lcimage;
	UITableViewCell *cell;
  
	BOOL hasImage;
	BOOL imageLoaded;
  BOOL imageAlreadyRequested;
	
	UIColor *cellbackcolor;
	UIColor *celltextcolor;
	int cellfontsize;
	CGRect celltextRect;
	
@public
  id _delegate;
	NSString *locid;

}


@property (nonatomic, retain) NSString *locid;
//@property (nonatomic, retain) NSString *locpicdata;
@property (nonatomic, retain) NSString *imgname;
@property (nonatomic, retain) NSString *desc;
@property (nonatomic, retain) NSString *roadname;
@property (nonatomic, retain) NSString *dir;
@property (nonatomic, retain) NSString *vstr, *Vmax, *Vmid, *Vmin, *Placing, *SpCnt, *Vmode, *Fn, *Fx, *Mode, *addr, *f0, *f1, *f2, *f3, *f4, 
														*f5, *f6, *f7, *f8, *f9, *f10, *f11, *f12, *f13, *f14, *f15, *f16;
@property (nonatomic, retain) NSString *vmaxstr, *consist;
@property (nonatomic, retain) UIImage *lcimage;
@property (nonatomic, retain) UITableViewCell *cell;
@property BOOL hasImage;
@property BOOL imageLoaded;
@property BOOL imageAlreadyRequested;
@property int vint;

- (id) initWithAttributeDict: (NSDictionary *)attributeDict;
- (void) updateWithAttributeDict: (NSDictionary *)attributeDict;

- (void)setDelegate:(id)new_delegate;
- (void) prepareImage;
- (UIImage*) getImage;
//- (int) getVint;
- (void) setLocpicdata:(NSString *) picdata;
- (int) getVmax;
- (BOOL)isFn:(int)fn;
- (void)setFn:(int)fn withState:(BOOL)state;
- (BOOL)isPlacing;
- (int)getVmid;
- (int)getVmin;
- (BOOL)isAutoMode;
- (BOOL)isHalfAutoMode;
- (void)sendVcommand;
- (void)sendFunctionCommand:(int)fnIndex;
- (void)sendVmax:(int)V;
- (void)sendVmid:(int)V;
- (void)sendVmin:(int)V;
- (double) getVpercent;
- (void) setVpercent:(double) vpercent;

- (UITableViewCell*) getCell;
- (void) createCell;
- (void)addCellLocoImage;

@end
