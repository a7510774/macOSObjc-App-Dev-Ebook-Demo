//
//  MyWindow.m
//  NSWindowController
//
//  Created by zhaojw on 15/9/13.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import "MyWindow.h"
@implementation MyWindow

- (void)makeKeyWindow {
    [super makeKeyWindow]   ;
}

- (void)makeKeyAndOrderFront:(nullable id)sender {
    [super makeKeyAndOrderFront:sender];
}

- (void)orderFront:(id)sender {
    [super orderFront:sender];
}

- (void)orderOut:(id)sender {
    [super orderOut:sender];
}

- (void)dealloc {
    NSLog(@"MyWindow dealloc");
}
@end


