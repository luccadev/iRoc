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
#import "Item.h"
#import "Container.h"
#import "TtTrack.h"


@interface Turntable : Item {
    NSString *ID;    
    int symbolsize;
    int bridgepos;
    BOOL sensor1;
    BOOL sensor2;
    Container *ttTracks;
}

@property (nonatomic, retain) NSString *ID;
@property (nonatomic, retain) Container *ttTracks;

- (id) initWithAttributeDict: (NSDictionary *)attributeDict;
- (void) addTrack: (NSDictionary *)attributeDict;
- (NSString*) getImgName;

- (void)closeMe:(BOOL)_close;
- (void)gotoTrack:(int)_trackID;
- (void)prevTrack;
- (void)nextTrack;
- (void)rotateBridge: (double)pos inContext: (CGContextRef)context;
- (void)rotateBridgeSensors: (double)pos inContext: (CGContextRef)context;

@end

//@interface NSObject (Turntable)
//- (void)presentTurntableView:(iRocTurntableView*)tt;
//@end