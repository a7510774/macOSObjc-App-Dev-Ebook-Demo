//
//  AppDelegate.m
//  TabView
//
//  Created by zhaojw on 15/8/27.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()<NSTabViewDelegate>
@property (weak) IBOutlet NSTabView *tabView;

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (void)tabView:(NSTabView *)tabView didSelectTabViewItem:(NSTabViewItem *)tabViewItem {
    NSLog(@"tab title %@",tabViewItem.label);
    NSLog(@"tab identifier %@",tabViewItem.identifier);
}

- (IBAction)AddTabBtnClicked:(id)sender {

    
    NSTabViewItem *tabViewItem = [[NSTabViewItem alloc]initWithIdentifier:@"Untitled"];
    
    tabViewItem.label = @"Untitled";
    
    NSView *view = [[NSView alloc]initWithFrame:NSZeroRect];
    
    [view setAutoresizesSubviews:YES];
   
    [view setAutoresizingMask:
     
     NSViewWidthSizable|NSViewHeightSizable
     ];
    tabViewItem.view = view;
    
    [self.tabView addTabViewItem:tabViewItem];
    
}

@end
