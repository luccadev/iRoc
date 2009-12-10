//
//  iRocTableView.m
//  iRoc
//
//  Created by Jean-Michel Fischer on 10.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "iRocTableView.h"


@implementation iRocTableView

- (void)viewDidLoad {
    [super viewDidLoad];
	
	cellbackcolor = [UIColor darkGrayColor];
	celltextcolor = [UIColor lightGrayColor]; //[[UIColor colorWithRed:.16 green:.20 blue:.27 alpha:1] retain];
	cellfontsize = 20;
	celltextRect = CGRectMake(10, 10, 190, 20);
	
	self.navigationController.navigationBar.tintColor = [UIColor blackColor];
	self.tableView.backgroundColor = cellbackcolor;
	self.tableView.separatorColor = [UIColor blackColor];
	
	self.tableView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
	self.tableView.rowHeight = 40.0;
}


@end