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

#import "Turntable.h"
#import "iRocAppDelegate.h"


@implementation Turntable
@synthesize ID;

- (id) initWithAttributeDict: (NSDictionary *)attributeDict {
    if( (self = [super initWithAttributeDict:attributeDict]) ) {
        
        
    }
    
    return self;
}

- (void) updateWithAttributeDict: (NSDictionary *)attributeDict {
    [super updateWithAttributeDict:attributeDict]; 
}


- (NSString*) getImgName {
	NSString *imgname = @"";
    
        cx = 2;
        cy = 2;
        imgname = @"button-active.png"; // TODO: correct symbol!
   	
	return imgname;
}

- (void)flip {
	NSLog(@"Turntable Flip");
	[delegate presentTurntableView:self];
}

- (void)closeMe:(BOOL)_close {
    [delegate sendMessage:@"seltab" message:[[NSString alloc] 
                                           initWithString: [NSString stringWithFormat: @"<tt id=\"%@\" state=\"%@\"/>", Id, [state isEqual:@"closed"]?@"open":@"closed"]]];
    
}

- (void)gotoTrack:(NSString *)_trackNr {
    [delegate sendMessage:@"seltab" message:[[NSString alloc] 
                                           initWithString: [NSString stringWithFormat: @"<tt id=\"%@\" cmd=\"%@\"/>", Id, _trackNr]]];
}

- (void)prevTrack {
    [delegate sendMessage:@"seltab" message:[[NSString alloc] 
                                           initWithString: [NSString stringWithFormat: @"<tt id=\"%@\" cmd=\"prev\"/>", Id]]];
}

- (void)nextTrack {
    [delegate sendMessage:@"seltab" message:[[NSString alloc] 
                                           initWithString: [NSString stringWithFormat: @"<tt id=\"%@\" cmd=\"next\"/>", Id]]];
}

- (void)dealloc {
    [ID release];
    [super dealloc];
}

@end
