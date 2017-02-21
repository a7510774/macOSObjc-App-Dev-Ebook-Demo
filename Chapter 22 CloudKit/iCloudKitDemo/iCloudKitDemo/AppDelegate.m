//
//  AppDelegate.m
//  iCloudKitDemo
//
//  Created by zhaojw on 15/10/26.
//  Copyright © 2015年 zhaojw. All rights reserved.
//

#import "AppDelegate.h"
#import <CloudKit/CloudKit.h>
@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    CKRecord *r;
    CKDatabase  *db;
    CKContainer *cb;
    
    
    NSUbiquitousKeyValueStore *dfgdg;
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
