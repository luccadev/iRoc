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
#import "iRocButton.h"
#import "Turntable.h"

@interface iRocTurntableView : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    
    iRocButton *openItem;
	iRocButton *prevTrack;
	iRocButton *nextTrack;
	iRocButton *gotoTrack;
    UIPickerView *trackPicker;
    Container *tracks;
    NSString *trackPicked;
    
    Turntable *_tt;
    
    IBOutlet iRocButton *esc;
    id _delegate;
    
    UILabel* l;

    //id itemWithTracks;
}

@property (nonatomic, retain) id itemWithTracks;
@property (nonatomic, retain) id _delegate;
@property (nonatomic, retain) iRocButton *esc;
@property (nonatomic, retain) Container *tracks;

- (IBAction) escClicked:(id) sender; 
- (void) setTurntable:(Turntable*)tt;

- (IBAction) openItemClicked:(id) sender; 
- (IBAction) prevTrackClicked:(id) sender; 
- (IBAction) nextTrackClicked:(id) sender; 
- (IBAction) gotoTrackClicked:(id) sender; 

//- (id) initWithItem:(id)_itemWithTracks andTracks:(Container *)_tracks;

@end


@interface NSObject (iRocTurntableView)
- (void)dismissModalViewController;
@end
