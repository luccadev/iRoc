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


#import "iRocItem.h"
#import "Globals.h"


@implementation iRocItem

- (id)initWithItem:(Item *)_item {
    item = _item;
    
    // has to be called here (cx, cy)
    NSString *imagename = [item getImgName];  
    
    //NSLog(@"item image=%@ x,y=%d,%d cx,cy=%d,%d", [item getImgName], item.x, item.y, item.cx, item.cy);
    
	
    CGRect itemframe = CGRectMake(ITEMSIZE * item.x, ITEMSIZE * item.y, ITEMSIZE * item.cx, ITEMSIZE * item.cy);	
	
    if( (self = [super initWithFrame:itemframe] )) {
        
        
        [item setView:self];
        
        [self addTarget:self action: @selector(itemAction:) forControlEvents: UIControlEventTouchDown ];
        
        self.opaque = YES;
        [self setBackgroundColor:[UIColor clearColor]];

        if( imagename != nil  || [item hasImage] ) {
          if( imagename != nil )
            image = [UIImage imageNamed:imagename];
          else if([item hasImage]) {
            image = [item getImage:false];
          }

            CGRect imageframe = CGRectMake(0, 0, ITEMSIZE * item.cx, ITEMSIZE * item.cy);	
            imageview = [[UIImageView alloc] initWithFrame:imageframe];
            imageview.image = image; 
            [item setView:self];
            imageview.contentMode = UIViewContentModeScaleAspectFit;
            [self addSubview:imageview];
        }
        
        if( item.text != nil && [item.text length] > 0 ) {
            float _2 = (2.0/32.0)*ITEMSIZE;
            float _4 = (4.0/32.0)*ITEMSIZE;
            float _6 = (6.0/32.0)*ITEMSIZE;
            float _10 = (10.0/32.0)*ITEMSIZE;
            float _24 = (24.0/32.0)*ITEMSIZE;
            float _38 = (38.0/32.0)*ITEMSIZE;
            
            if( item.textVertical ) {
                int xoff = -((ITEMSIZE * item.cy - _38) / 2);
                int yoff = (ITEMSIZE * item.cy - _24) / 2;
                label = [[[UILabel alloc] initWithFrame:CGRectMake(xoff, yoff, ITEMSIZE * item.cy - _6, ITEMSIZE * item.cx - _10 )] autorelease];
                label.transform = CGAffineTransformMakeRotation( M_PI/2 );
            }
            else {
                label = [[[UILabel alloc] initWithFrame:CGRectMake(_2, _4, ITEMSIZE * item.cx - _4, ITEMSIZE * item.cy - _10 )] autorelease];
            }
            label.font = [UIFont boldSystemFontOfSize:(int)((12.0/32.0)*ITEMSIZE)];
            label.textColor = [UIColor blackColor];
            label.backgroundColor = item.textBackgroundColor;
            label.text = item.text;
            label.textAlignment = UITextAlignmentCenter;
            [self addSubview:label];  
        }
    }
    
    [self setNeedsDisplay];
    return self;
    
    
}


- (NSString *)getId {
    return item.Id;
}

- (void)itemAction:(id)sender {
    NSLog(@"action for item %@", item.Id);
    //[self setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:0 alpha:1.0]];
    AudioServicesPlaySystemSound([Globals getClick]);
    [item flip];
}



- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    [item paint:rect inContext:UIGraphicsGetCurrentContext()];
    
    /*
     NSString *imagename = [item getImgName];  
     if( imagename != nil ) {
     
     image = [UIImage imageNamed:imagename];
     
     [image drawAtPoint:CGPointMake(0, 0)];
     }*/
    
    
} 

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touches ended for item %@", item.Id);
	
	NSUserDefaults *defaults = [[NSUserDefaults standardUserDefaults] retain];
	if([[defaults stringForKey:@"plancolor_preference"] isEqual:@"green"])
		[self setBackgroundColor:[UIColor colorWithRed:.7 green:.9 blue:.7 alpha:1.0]];
	else if([[defaults stringForKey:@"plancolor_preference"] isEqual:@"grey"])
        [self setBackgroundColor:[UIColor colorWithRed:.8 green:.8 blue:.8 alpha:1.0]];
	else
        [self setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1.0]];	
	
    //[item flip];
}

- (void)updateEvent {
    NSLog(@"update event for item %@", item.Id);
  /*
    image = [UIImage imageNamed:[item getImgName]];
    imageview.image = image; 
    if( label != nil ) {
        label.backgroundColor = item.textBackgroundColor;
        label.text = item.text;
    }
  */
  if( [item getImgName] != nil ) {
    image = [UIImage imageNamed:[item getImgName]];
    imageview.hidden = NO;
    imageview.opaque = YES;
    imageview.image = image;
  }
  else if( [item getImage:false] != nil ) {
    image = [item getImage:false];
    imageview.hidden = NO;
    imageview.opaque = YES;
    imageview.image = image;
    imageview.contentMode = UIViewContentModeScaleAspectFit;
  }
  else {
    imageview.hidden = YES;
  }
  
  if( label != nil ) {
    label.backgroundColor = item.textBackgroundColor;
    label.text = item.text;
  }

  
    [self setNeedsDisplay];
}

- (void)disable {
    imageview.hidden = YES;
    [item setView:nil];
}

- (void)dealloc {
    [imageview removeFromSuperview];
    [imageview release];
    [super dealloc];
}


@end
