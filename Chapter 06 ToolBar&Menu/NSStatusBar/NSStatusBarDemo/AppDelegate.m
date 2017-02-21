//
//  AppDelegate.m
//  NSStatusBarDemo
//
//  Created by zhaojw on 15/9/19.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import "AppDelegate.h"
#import "AppViewController.h"
@interface AppDelegate ()
@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSMenu *shareMenu;
@property (strong,nonatomic) NSStatusItem *item;
@property (strong) NSPopover *popover;
@property(nonatomic)BOOL  isShow;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    //获取系统单例NSStatusBar对象
    NSStatusBar *statusBar = [NSStatusBar systemStatusBar];
    
    //创建固定宽度的NSStatusItem
    NSStatusItem *item = [statusBar statusItemWithLength:NSSquareStatusItemLength];
    
    [item.button setTarget:self];
    
    [item.button setAction:@selector(itemAction:)];
    
    item.button.image = [NSImage imageNamed:@"blue@2x.png"];
    
    //设置下拉菜单
   // item.menu = self.shareMenu;
    
    //保存到属性变量
    self.item = item;
    
    [self setUpPopover];
}

- (void) setUpPopover {
    self.popover = [[NSPopover alloc] init];
    self.popover.contentViewController = [[AppViewController alloc] init];
    self.popover.behavior = NSPopoverBehaviorApplicationDefined;
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
    
    NSStatusBar *statusBar = [NSStatusBar systemStatusBar];
    //删除item
    [statusBar removeStatusItem:self.item];
}

-(IBAction)itemAction:(id)sender {
    if (!self.isShow) {
        [self.popover showRelativeToRect:NSZeroRect ofView:[self item].button preferredEdge:NSRectEdgeMinY];
    } else {
        [self.popover close];
    }
    
    self.isShow = ~self.isShow;
    
//    [[NSRunningApplication currentApplication] activateWithOptions:(NSApplicationActivateAllWindows | NSApplicationActivateIgnoringOtherApps)];
}


- (IBAction)shareAction:(id)sender
{
    NSLog(@"shareAction");
}

@end
