//
//  AppDelegate.m
//  CheckBox
//
//  Created by zhaojw on 15/9/2.
//  Copyright (c) 2015年 http://macdev.io All rights reserved.
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
- (IBAction)checkboxAction:(id)sender {
    
    NSButton *checkBtn = sender;
    BOOL isOn = checkBtn.state;
    NSLog(@"@%d",isOn);
    //checkBtn.state = NSMixedState;
}

@end
