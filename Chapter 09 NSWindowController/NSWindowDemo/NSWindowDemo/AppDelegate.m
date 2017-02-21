//
//  AppDelegate.m
//  NSWindowDemo
//
//  Created by zhaojw on 15/9/14.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import "AppDelegate.h"
#import "MyWindow.h"
#import "NSToolViewController.h"
@interface AppDelegate ()<NSWindowDelegate>

@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSWindow *otherWindow;

@property (strong,nonatomic)  MyWindow *myWindow;

@property (strong,nonatomic)  NSWindowController *myWindowController;

@property (strong,nonatomic)  NSToolViewController *viewController;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    //self.window.contentView = self.viewController.view;
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (IBAction)showWindowAction:(id)sender
{
    //[self.myWindow makeKeyAndOrderFront:self];
    
    //[self.otherWindow makeKeyAndOrderFront:self];

    [self.myWindowController showWindow:self];
}


- (IBAction)showModelWindowAction:(id)sender {
    [[NSApplication sharedApplication]runModalForWindow:self.myWindowController.window];
}

- (void)windowWillClose:(NSNotification *)notification
{
    NSLog(@"");
    
    NSWindow *window = notification.object;
    //[window close];
    if(self.myWindow == window){
         [[NSApplication sharedApplication]stopModal];
    }
    

}

- (void)windowDidResignKey:(NSNotification *)notification;
{
    NSLog(@"");
    
    NSWindow *window = notification.object;
    //[window close];
    if(self.myWindow == window){
        // [[NSApplication sharedApplication]stopModal];
    }

}

- (IBAction)stopModelWindowAction:(id)sender
{
    [[NSApplication sharedApplication]stopModal];
    
}

- (NSToolViewController*)viewController
{
    if(!_viewController){
        _viewController = [[NSToolViewController alloc]init];
    }
    return _viewController;
}
- (MyWindow*)myWindow
{
    if(!_myWindow){
        
        NSRect frame = CGRectMake(0, 0, 400, 200);
        
        NSUInteger style = 15;// NSTitledWindowMask | NSClosableWindowMask |NSMiniaturizableWindowMask | NSResizableWindowMask;
        
        _myWindow = [[MyWindow alloc]initWithContentRect:frame styleMask:style backing:NSBackingStoreRetained defer:YES];
      
        _myWindow.title = @"New Create Window";
        
        //_myWindow.hidesOnDeactivate = YES;
        
        //_myWindow.delegate = self;
        
       

    }
    return _myWindow;
}

- (NSWindowController*)myWindowController
{
    if(!_myWindowController)
    {
        _myWindowController = [[NSWindowController alloc]init];
        
        //self.myWindow.windowController = self.myWindowController;
        
       // _myWindowController.window = self.myWindow;
    }
    return _myWindowController;
}
@end
