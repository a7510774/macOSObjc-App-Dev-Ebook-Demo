//
//  AppDelegate.m
//  NSWindowController
//
//  Created by zhaojw on 15/9/13.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import "AppDelegate.h"
#import "NSWindowVVController.h"
#import "NSToolViewController.h"
@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;

@property (nonatomic,strong)  NSWindow *myWindow;

@property(nonatomic,strong)NSWindowVVController *wvv;

@property(nonatomic,strong)NSToolViewController *vc;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (IBAction)showAction:(id)sender
{
    
    //self.wvv = [[NSWindowVVController alloc]init];
    //[self.wvv showWindow:self];
    
    //return;
     NSRect frame = CGRectMake(0, 0, 200, 200);
    NSWindow *myWindow = [[NSWindow alloc]initWithContentRect:frame styleMask:15 backing:NSBackingStoreBuffered defer:YES];
    myWindow.title = @"TTTT";
    [myWindow makeKeyAndOrderFront:self];
    
   // self.myWindow.contentViewController = self.vc;
    
    return;
    [[NSApplication sharedApplication]runModalForWindow:self.myWindow];
    //[self showOtherWindow];
}
- (void)showOtherWindow
{
    NSRect frame = CGRectMake(0, 0, 200, 200);
    self.myWindow = [[NSWindow alloc]initWithContentRect:frame styleMask:15 backing:NSBackingStoreBuffered defer:YES];
    
   [ self.window beginSheet:self.myWindow completionHandler:^(NSModalResponse returnCode) {
        
    }
    ];
    
}


- (NSToolViewController*)vc
{
    if(!_vc){
        _vc =[[NSToolViewController alloc]initWithNibName:@"NSToolViewController" bundle:nil];
    }
    return _vc;
}

@end
