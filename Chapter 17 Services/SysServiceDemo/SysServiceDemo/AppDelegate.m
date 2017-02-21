//
//  AppDelegate.m
//  SysServiceDemo
//
//  Created by zhaojw on 11/19/15.
//  Copyright © 2015 zhaojw. All rights reserved.
//

#import "AppDelegate.h"
#import "ServiceProvider.h"
@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    ServiceProvider *provider;
    provider = [[ServiceProvider alloc] init];
    [NSApp setServicesProvider:provider];
    NSUpdateDynamicServices();
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}



@end
