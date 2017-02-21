//
//  AppDelegate.m
//  NSWindowControllerWithXib
//
//  Created by iDevFans on 16/10/28.
//  Copyright © 2016年 macdev. All rights reserved.
//

#import "AppDelegate.h"
#import "MyWindow.h"
@interface AppDelegate ()
@property (weak) IBOutlet NSWindow *window;
@property (strong,nonatomic)  MyWindow *myWindow;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}

- (IBAction)showWindowAction:(id)sender {
    [self.myWindow makeKeyAndOrderFront:self];
    [self.myWindow center];
}

- (MyWindow*)myWindow {
    if(!_myWindow){
        NSRect frame = CGRectMake(0, 0, 400, 200);
        NSUInteger style =  NSTitledWindowMask | NSClosableWindowMask |NSMiniaturizableWindowMask | NSResizableWindowMask;
        
        _myWindow = [[MyWindow alloc]initWithContentRect:frame styleMask:style backing:NSBackingStoreRetained defer:YES];
        
        _myWindow.title = @"New Create Window";
    }
    return _myWindow;
}
@end
