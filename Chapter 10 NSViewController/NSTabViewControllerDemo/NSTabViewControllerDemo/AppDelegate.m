//
//  AppDelegate.m
//  NSTabViewControllerDemo
//
//  Created by zhaojw on 15/9/15.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import "AppDelegate.h"
#import "TabViewController.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;

@property(nonatomic,strong)TabViewController *tabViewController;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    self.window.contentViewController = self.tabViewController;
    
   
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag {
    [self.window makeKeyAndOrderFront:self];
    return YES;
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (TabViewController*)tabViewController
{
    if(!_tabViewController){
        _tabViewController =[[TabViewController alloc]init];
       
    }
    return _tabViewController;
}




@end
