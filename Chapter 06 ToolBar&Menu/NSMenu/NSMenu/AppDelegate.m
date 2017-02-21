//
//  AppDelegate.m
//  NSMenu
//
//  Created by zhaojw on 15/8/26.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;

@property (weak) IBOutlet NSMenu *myMenu;

@property (nonatomic,strong)  NSMenu *customMenu;
@property (weak) IBOutlet NSView *contextView;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    NSMenu *customMenu = [[NSMenu alloc]init];
    
    self.customMenu = customMenu;
    
    NSMenuItem *openMenuItem = [[NSMenuItem alloc]initWithTitle:@"Open" action:@selector(menuClicked:) keyEquivalent:@""];
    
    
    NSMenuItem *openRecentMenuItem = [[NSMenuItem alloc]initWithTitle:@"Open Recent..." action:nil keyEquivalent:@""];
    
    NSMenu *recentMenu = [[NSMenu alloc]init];
    
    [openRecentMenuItem setSubmenu:recentMenu];
    
    
    NSMenuItem *file1MenuItem = [[NSMenuItem alloc]initWithTitle:@"File1" action:@selector(menuClicked:) keyEquivalent:@""];
    
    NSMenuItem *file2MenuItem = [[NSMenuItem alloc]initWithTitle:@"File2" action:@selector(menuClicked:) keyEquivalent:@""];
    
    [recentMenu addItem:file1MenuItem];
    
    [recentMenu addItem:file2MenuItem];
    
    
    NSMenuItem *closeMenuItem = [[NSMenuItem alloc]initWithTitle:@"Close" action:@selector(menuClicked:) keyEquivalent:@""];
    
    [customMenu addItem:openMenuItem];
    
    [customMenu addItem:openRecentMenuItem];

    [customMenu addItem:closeMenuItem];
    
    
    
    NSMenu *menu = [NSApp menu];
    
    NSArray *subitems = [menu itemArray];
    
    
    for(NSMenuItem *item in subitems) {
        
        NSString *title = item.title;
        
        NSLog(@"title %@",title);
        
        NSMenu *submenu = item.menu;
        
        NSArray *subsubitems = [submenu itemArray];
        
        for(NSMenuItem *subsubitem in subsubitems) {
            
            NSLog(@"subsubitem %@",subsubitem.title);
        }
        
    }
    
    
    self.contextView.wantsLayer = YES;
    
    self.contextView.layer.backgroundColor = [NSColor redColor].CGColor;
    
    self.contextView.menu = self.customMenu;
    
}


- (IBAction)menuClicked:(id)sender {
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (IBAction)popButtonClicked:(id)sender
{
    NSButton *button = (NSButton *)sender;
    NSPoint point = button.frame.origin;
    point.x += button.frame.size.width;
    point.y = point.y ;
    [self.customMenu popUpMenuPositioningItem:nil atLocation:point inView:self.window.contentView];
    
    
}
@end
