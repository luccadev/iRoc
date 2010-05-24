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


#import "iRocTableView.h"


@implementation iRocTableView

- (void)viewDidLoad {
    [super viewDidLoad];
	
	cellbackcolor = [UIColor darkGrayColor];
	celltextcolor = [UIColor lightGrayColor]; //[[UIColor colorWithRed:.16 green:.20 blue:.27 alpha:1] retain];
	cellfontsize = 18;
	celltextRect = CGRectMake(10, 10, 190, 25);
	
	self.navigationController.navigationBar.tintColor = [UIColor blackColor];
	self.tableView.backgroundColor = cellbackcolor;
	self.tableView.separatorColor = [UIColor blackColor];
	
	self.tableView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
	self.tableView.rowHeight = 45.0;
}


@end
