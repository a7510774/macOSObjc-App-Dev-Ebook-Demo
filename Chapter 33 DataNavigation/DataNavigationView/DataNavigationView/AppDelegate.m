//
//  AppDelegate.m
//  DataNavigationView
//
//  Created by iDevFans on 16/6/3.
//  Copyright © 2016年 http://www.macdev.io All rights reserved.
//

#import "AppDelegate.h"
#import "DataNavigationViewController.h"
@interface AppDelegate ()
@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    DataNavigationViewController *dataNavigationViewController = [[DataNavigationViewController alloc]init];
    
    self.window.contentViewController = dataNavigationViewController;
    
}
- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
