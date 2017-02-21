//
//  AppDelegate.m
//  NSPopUpButton
//
//  Created by zhaojw on 15/9/2.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
@property (weak) IBOutlet NSPopUpButton *popUpButton;

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    NSArray *items = @[
                       
                       @"China",
                       @"Japan",
                       @"USA"
                       ];
    
    [self.popUpButton addItemsWithTitles:items];
    
    
    NSAlert *gg;
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (IBAction)popUpBtnAction:(id)sender
{
    NSPopUpButton *popBtn = sender;
    
    NSArray *items = popBtn.itemTitles ;
    
    NSInteger indexOfSelectedItem = popBtn.indexOfSelectedItem;
    
    NSString *title =items[indexOfSelectedItem];
    
    NSString *titleOfSelectedItem = popBtn.titleOfSelectedItem;
    
    
    
};


@end
