//
//  AppDelegate.m
//  NSViewControllerSwitchViewDemo
//
//  Created by iDevFans on 2016/11/2.
//  Copyright © 2016年 macdev. All rights reserved.
//

#import "AppDelegate.h"
#import "TestViewController.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;

@property(nonatomic,strong)TestViewController *testViewController;


@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    self.testViewController = [[TestViewController alloc]initWithNibName:@"TestViewController" bundle:nil];
    
    self.window.contentViewController = self.testViewController;
    
    
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}
@end
