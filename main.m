//
//  main.m
//  iRoc
//
//  Created by Jean-Michel Fischer on 17.11.09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

int main(int argc, char *argv[]) {
    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, @"iRocAppDelegate");
    [pool release];
    return retVal;
}
