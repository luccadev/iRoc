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
        
        
        NSString *tmp = [Globals getAttribute:@"bridgepos" fromDict:attributeDict withDefault:@"0"]; 
        bridgepos = [tmp intValue];
        [tmp release];
        tmp = [Globals getAttribute:@"state1" fromDict:attributeDict withDefault:@"false"]; 
        sensor1 = [tmp isEqual:@"true"];
        [tmp release];
        tmp = [Globals getAttribute:@"state2" fromDict:attributeDict withDefault:@"false"]; 
        sensor2 = [tmp isEqual:@"true"];
        [tmp release];
        
        ttTracks = [[[Container alloc] init] retain];
        
        
        smallsymbol = [Globals getAttribute:@"smallsymbol" fromDict:attributeDict withDefault:@"false"];
    }
    
    return self;
}

- (void) updateWithAttributeDict: (NSDictionary *)attributeDict {
    [super updateWithAttributeDict:attributeDict]; 
}


- (NSString*) getImgName {
	NSString *imgname = @"";

    if ( smallsymbol ) {
        cx = 2;
        cy = 2;
    } else {
        cx = 5;
        cy = 5;
    }
    
	return imgname;
}



- (void)paint: (CGRect)rect inContext: (CGContextRef)context {
    NSLog(@"paint the turn table");		
	
    /*
    int xC = 80;
    int yC = 80 ;
    double dBridgepos = 0;
     */
    
    CGContextSetShouldAntialias(context, YES);
    
    CGContextSetRGBFillColor(context, .7, .7, .7 ,1);
    CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);	
    CGContextSetLineWidth(context, 1);
    
    
	/* Begin! */
	CGContextBeginPath(context);
    CGContextAddEllipseInRect(context, CGRectMake(1, 1, cx * 30, cy * 30));
    CGContextClosePath(context);
    CGContextStrokePath(context);
    
    
    int dBridgepos = 0;
    [self rotateBridge:dBridgepos inContext:context];
    
    
}


- (void)rotateBridge: (double)pos inContext: (CGContextRef)context {
    CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);	
    CGContextBeginPath(context);
    
    float originX = 0;
    float originY = 0;
    double bp[4] = { 10.0, 170.0, 190.0, 350.0 };
    
    for( int i = 0; i < 4; i++ ) {
        double angle = pos+bp[i];
        if( angle > 360.0 )
            angle = angle -360.0;
        double a = (angle*M_PI)/180;
        double xa = cos(a) * 30.0;
        double ya = sin(a) * 30.0;
        
        int delta = 31;
        
        if( i == 0 ) {
            originX = delta + (int)xa;
            originY = delta - (int)ya;
            CGContextMoveToPoint(context, delta + (int)xa, delta - (int)ya );
        }
        else {
            CGContextAddLineToPoint(context, delta + (int)xa, delta - (int)ya );
        }
    }
    
    // end point to close the polygon
    CGContextAddLineToPoint(context, (int)originX, (int)originY );
    
    CGContextClosePath(context);
    CGContextStrokePath(context);
    
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
