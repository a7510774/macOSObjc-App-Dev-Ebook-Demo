//
//  AppDelegate.m
//  Toolbar
//
//  Created by zhaojw on 15/8/27.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import "AppDelegate.h"

#define kFontToolbatItemTag    1
#define kSaveToolbatItemTag    2

@interface AppDelegate ()<NSToolbarDelegate>
@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    
    self.window.titleVisibility =  NSWindowTitleHidden;
    
    NSVisualEffectView *view = [self.window contentView];
    //view.blendingMode =  NSVisualEffectBlendingModeBehindWindow;
    
    [self setUpToolbar];

}

- (void)setUpToolbar {
    
    NSToolbar *toolbar = [[NSToolbar alloc] initWithIdentifier:@"AppToolbar"];
    [toolbar setAllowsUserCustomization:NO];
    [toolbar setAutosavesConfiguration:NO];
    [toolbar setDisplayMode:NSToolbarDisplayModeIconAndLabel];
    [toolbar setSizeMode:NSToolbarSizeModeSmall];
    [toolbar setDelegate:self];
    //[self.window setToolbar:toolbar];
    
}

#pragma NSToolbarDelegate 

- (NSArray *)toolbarAllowedItemIdentifiers:(NSToolbar *)toolbar {
    return @[@"FontSetting",@"Save"];
}

- (NSArray *)toolbarDefaultItemIdentifiers:(NSToolbar *)toolbar {
    return @[@"FontSetting",@"Save"];
}

- (NSToolbarItem *)toolbar:(NSToolbar *)toolbar itemForItemIdentifier:(NSString *)itemIdentifier willBeInsertedIntoToolbar:(BOOL)flag {

    NSToolbarItem *toolbarItem = [[NSToolbarItem alloc] initWithItemIdentifier:itemIdentifier];
    
    if ([itemIdentifier isEqualToString:@"FontSetting"]) {
        [toolbarItem setLabel:@"Font"];
        [toolbarItem setPaletteLabel:@"Font"];
        [toolbarItem setToolTip:@"Font Setting"];
        [toolbarItem setImage:[NSImage imageNamed:@"FontSetting"]];
        toolbarItem.tag = kFontToolbatItemTag;
        
    }
    else if ([itemIdentifier isEqualToString:@"Save"]) {
        [toolbarItem setLabel:@"Save"];
        [toolbarItem setPaletteLabel:@"Save"];
        [toolbarItem setToolTip:@"Save File"];
        [toolbarItem setImage:[NSImage imageNamed:@"Save"]];
        toolbarItem.tag = kSaveToolbatItemTag;
    }
    
    else {
        toolbarItem = nil;
    }
    
    [toolbarItem setMinSize:CGSizeMake(25, 25)];
    [toolbarItem setMaxSize:CGSizeMake(100, 100)];
    [toolbarItem setTarget:self];
    [toolbarItem setAction:@selector(toolbarItemClicked:)];
    
    return toolbarItem;
}



- (BOOL)validateToolbarItem:(NSToolbarItem *)theItem {
    
    if ([theItem.itemIdentifier isEqualToString:@"FontSetting"]) {
        return NO;
    }
    return YES;
}



- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
    
    NSToolbar *tool;
}

- (IBAction)toolbarItemClicked:(id)sender {
    
    
}

- (IBAction)openToolbarItemClicked:(id)sender {

    NSToolbarItem *item =  sender;
    NSInteger tag = item.tag;
    
    if(tag==1) {
        
    }
    if(tag==2 ) {
        
    }
    
}



@end
