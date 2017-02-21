//
//  AppDelegate.m
//  NSSplitView
//
//  Created by zhaojw on 15/8/28.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;

@property(nonatomic,strong)NSSplitView *splitView;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    [self.window.contentView addSubview:self.splitView];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}



- (NSSplitView*)splitView{
    if(!_splitView) {
        _splitView = [[NSSplitView alloc] initWithFrame:[self.window.contentView bounds]];
        //垂直方向
        [_splitView setVertical:YES];
        //中间分割区域的样式
        [_splitView setDividerStyle:NSSplitViewDividerStyleThin];
        
        NSView *leftView = [[NSView alloc]initWithFrame:NSZeroRect];
        leftView.autoresizingMask = 0;
        [leftView setAutoresizesSubviews:YES];
        
        NSView *rightView = [[NSView alloc]initWithFrame:NSZeroRect];
        rightView.autoresizingMask = 0;
        [rightView setAutoresizesSubviews:YES];
        
        //增加左右视图
        [_splitView addSubview:leftView];
        [_splitView addSubview:rightView];
        
        
        [_splitView setAutoresizesSubviews:YES];
        [_splitView setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable ];
        
    }
    return _splitView;
}


@end
