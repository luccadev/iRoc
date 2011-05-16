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
@synthesize ID, ttTracks;

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
        
        
        tmp = [Globals getAttribute:@"symbolsize" fromDict:attributeDict withDefault:@"5"]; 
        symbolsize = [tmp intValue];
        
        
        ttTracks = [[[Container alloc] init] retain];
        
         
    }
    
    return self;
}

- (void) updateWithAttributeDict: (NSDictionary *)attributeDict {
    [super updateWithAttributeDict:attributeDict]; 
    NSString *tmp = [Globals getAttribute:@"bridgepos" fromDict:attributeDict withDefault:[NSString stringWithFormat:@"%d", bridgepos]]; 
    bridgepos = [tmp intValue];
    [tmp release];
    tmp = [Globals getAttribute:@"state1" fromDict:attributeDict withDefault:(sensor1?@"true":@"false")]; 
    sensor1 = [tmp isEqual:@"true"];
    [tmp release];
    tmp = [Globals getAttribute:@"state2" fromDict:attributeDict withDefault:(sensor2?@"true":@"false")]; 
    sensor2 = [tmp isEqual:@"true"];
    [tmp release];
    
    NSEnumerator * trackEnum = [ttTracks getEnumerator];
    TtTrack * track = nil;
    while ((track = (TtTrack*)[trackEnum nextObject])) {
        track.state = (track.nr == bridgepos);
    }
}

- (void) addTrack: (NSDictionary *)attributeDict {
    TtTrack *track = [[TtTrack alloc] initWithAttributeDict:attributeDict];
    NSLog(@"tt track %d", track.nr);		
    
    [ttTracks addObject:track withId:[track getKey]];
}

- (NSString*) getImgName {
	NSString *imgname = @"";

    cx = symbolsize;
    cy = cx;
    
	return imgname;
}



- (void)paint: (CGRect)rect inContext: (CGContextRef)context {
    NSLog(@"paint the turn table");		
	
   
    CGContextSetShouldAntialias(context, YES);
    
    CGContextSetRGBFillColor(context, .7, .7, .7 ,1);
    CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);	
    CGContextSetLineWidth(context, 1);
    
    int diam = (symbolsize * ITEMSIZE)-2;
    
    int xC = (diam+2)/2;
    int yC = (diam+2)/2;
    double dBridgepos = 0;

	CGContextBeginPath(context);
    double circ = diam-diam/2.5;
    
    CGContextAddEllipseInRect(context, CGRectMake(xC-circ/2, yC-circ/2, circ, circ));
    CGContextAddEllipseInRect(context, CGRectMake(xC-circ/2+2, yC-circ/2+2, circ-4, circ-4));
    CGContextClosePath(context);
    CGContextStrokePath(context);
    
    NSEnumerator * trackEnum = [ttTracks getEnumerator];
    TtTrack * track = nil;
    while ((track = (TtTrack*)[trackEnum nextObject])) {
        double degr = 7.5 * track.nr;
        double a = (degr*2*M_PI)/360;
        double xa = cos(a) * (xC-0);
        double ya = sin(a) * (yC-0);
        int xx = xC + (int)xa;
        int yy = yC - (int)ya;
        
        double xaa = cos(a) * (xC- (diam/5));
        double yaa = sin(a) * (yC- (diam/5));
        int xxa = xC + (int)xaa;
        int yya = yC - (int)yaa;
        
        CGContextBeginPath(context);
        
        
        if( track.show ) {
            CGContextSetRGBStrokeColor(context, 0, 0, 0 ,1);
            CGContextSetLineWidth(context, 8);
            CGContextMoveToPoint(context, xxa, yya );
            CGContextAddLineToPoint(context, xx, yy );
        }
        
        CGContextClosePath(context);
        CGContextStrokePath(context);
        
        CGContextBeginPath(context);
        
        if( track.state || (bridgepos == track.nr) ) {
            CGContextSetRGBStrokeColor(context, 1, 1, 0 ,1);
            CGContextSetLineWidth(context, 4);
            dBridgepos = degr;
        }
        else {
            CGContextSetRGBStrokeColor(context, 0.75, 0.75, 0.75 ,1);
            CGContextSetLineWidth(context, 4);
        }
        
        xa = cos(a) * (xC-(diam/5)/4);
        ya = sin(a) * (yC-(diam/5)/4);
        xx = xC + (int)xa;
        yy = yC - (int)ya;
        
        xaa = cos(a) * (xC- (diam/5)+(diam/5)/4);
        yaa = sin(a) * (yC- (diam/5)+(diam/5)/4);
        xxa = xC + (int)xaa;
        yya = yC - (int)yaa;
        
        if( track.show ) {
            CGContextMoveToPoint(context, xxa, yya );
            CGContextAddLineToPoint(context, xx, yy );
        }
        
        CGContextClosePath(context);
        CGContextStrokePath(context);
        
    }    
       
    CGContextSetLineWidth(context, 1);
    [self rotateBridge:dBridgepos inContext:context];
    
}


- (void)rotateBridge: (double)pos inContext: (CGContextRef)context {
    CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);	
    CGContextBeginPath(context);
    
    int ang = 8;
    int l = (symbolsize * ITEMSIZE)/4;
    
    float originX = 0;
    float originY = 0;
    double bp[4] = { ang, 180-ang, 180+ang, 360-ang, };
    
    for( int i = 0; i < 4; i++ ) {
        double angle = pos+bp[i];
        if( angle > 360.0 )
            angle = angle -360.0;
        
        double a = (angle*M_PI)/180;
        
        
        
        double xa = cos(a) * l;
        double ya = sin(a) * l;
        
        int delta = (symbolsize * ITEMSIZE)/2;
        
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

- (void)gotoTrack:(int)_trackID {
    
    //int trackID = [_trackNr intValue]; 
    TtTrack *ttTrack = [ttTracks objectAtIndex:_trackID];
                   
    NSLog(@"Turntable gotoTrack [%d] -> %d ",_trackID, ttTrack.nr);

    [delegate sendMessage:@"seltab" message:[[NSString alloc] 
                                             initWithString: [NSString stringWithFormat: @"<tt id=\"%@\" cmd=\"%d\"/>", Id,  ttTrack.nr]]];
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
