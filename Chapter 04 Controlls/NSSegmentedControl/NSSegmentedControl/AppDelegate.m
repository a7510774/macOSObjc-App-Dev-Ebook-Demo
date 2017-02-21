//
//  AppDelegate.m
//  NSSegmentedControl
//
//  Created by zhaojw on 15/9/1.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (IBAction)segmentAction:(id)sender
{
    NSSegmentedControl *segment = sender;
    
    NSInteger index = segment.selectedSegment;
    
    NSLog(@"selected segment index %ld",index);
    
}

@end
