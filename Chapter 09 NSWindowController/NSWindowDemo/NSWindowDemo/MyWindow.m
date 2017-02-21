//
//  MyWindow.m
//  NSWindowController
//
//  Created by zhaojw on 15/9/13.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import "MyWindow.h"

@implementation MyWindow

- (instancetype)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag
{
    return [super initWithContentRect:contentRect styleMask:aStyle backing:bufferingType defer:flag];
}

- (void)makeKeyWindow
{
    [super makeKeyWindow]   ;
}

- (void)orderFront:(id)sender
{
    [super orderFront:sender];
}

- (void)dealloc
{
    NSLog(@"MyWindow dealloc");
}

@end
