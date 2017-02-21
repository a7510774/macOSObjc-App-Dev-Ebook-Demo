//
//  AppDelegate.m
//  Radio
//
//  Created by iDevFans on 16/10/25.
//  Copyright © 2016年 macdev. All rights reserved.
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


- (IBAction)groupAction:(id)sender {
    
    NSButton *radio = sender;
    
    NSLog(@"%ld",radio.tag);
}

@end
