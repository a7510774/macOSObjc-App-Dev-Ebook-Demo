//
//  AppDelegate.m
//  TableDataNavigationViewController
//
//  Created by zhaojw on 16/6/4.
//  Copyright © 2016年 http://www.macdev.io All rights reserved.
//

#import "AppDelegate.h"

#import "NoXibDemoViewController.h"
#import "XibDemoViewController.h"
@interface AppDelegate ()
@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
     // Insert code here to initialize your application
    
    
     //you can use NoXibDemoViewController or XibDemoViewController
    
    
     NoXibDemoViewController *dataNavigationViewController = [[NoXibDemoViewController alloc]init];
    
     //XibDemoViewController *dataNavigationViewController = [[XibDemoViewController alloc]init];
    
    self.window.contentViewController = dataNavigationViewController;
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
