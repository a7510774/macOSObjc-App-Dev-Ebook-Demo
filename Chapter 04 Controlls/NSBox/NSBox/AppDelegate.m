//
//  AppDelegate.m
//  NSBox
//
//  Created by zhaojw on 15/9/2.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    
    NSBox *box=[[NSBox alloc]
                                initWithFrame:NSMakeRect(15.0,200.0,160.0,100)];
    [box setBoxType:NSBoxPrimary];
    
    NSSize margin = NSMakeSize(20, 20);
    
    box.contentViewMargins = margin;
    
    
    NSTextField *textField = [[ NSTextField alloc]
initWithFrame:NSMakeRect(10,10,80,20)];
    
    [box.contentView addSubview:textField];
    
    
  
    
    
    [self.window.contentView addSubview:box];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
    
    
   
}

@end
