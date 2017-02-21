//
//  AppDelegate.m
//  CocoaDrawDemo
//
//  Created by zhaojw on 2/24/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//

#import "AppDelegate.h"
#import "CDMainWindowController.h"
@interface AppDelegate ()
@property(nonatomic,strong)CDMainWindowController *mainWindowController;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    [self.mainWindowController showWindow:self];
    
    NSLog(@"%@",[[NSScreen mainScreen ]deviceDescription]);
    
    NSColor *color;
    
    NSColorPanel *sdfsd;
    
    NSImage *image = [NSImage imageNamed:@"image"];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (CDMainWindowController*)mainWindowController {
    if(!_mainWindowController){
        _mainWindowController = [[CDMainWindowController alloc]initWithWindowNibName:@"CDMainWindowController"];
    }
    return _mainWindowController;
}
@end
