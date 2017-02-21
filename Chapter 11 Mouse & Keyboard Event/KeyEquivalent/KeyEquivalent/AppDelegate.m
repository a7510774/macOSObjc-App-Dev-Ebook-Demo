//
//  AppDelegate.m
//  KeyEquivalent
//
//  Created by zhaojw on 15/11/13.
//  Copyright © 2015年 zhaojw. All rights reserved.
//

#import "AppDelegate.h"
#import "NSButtonX.h"
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
- (IBAction)btnClicked:(id)sender {
    
    NSLog(@"btnClicked");
    
    
    NSMenuItemCell *cell;
}
@end
