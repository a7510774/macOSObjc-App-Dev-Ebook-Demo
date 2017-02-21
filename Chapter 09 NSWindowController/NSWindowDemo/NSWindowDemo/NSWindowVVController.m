//
//  NSWindowVVController.m
//  NSWindowController
//
//  Created by zhaojw on 15/9/13.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import "NSWindowVVController.h"

@interface NSWindowVVController ()

@end

@implementation NSWindowVVController

- (NSString*)windowNibName
{
    return @"NSWindowVVController"  ;
}
- (void)windowDidLoad {
    [super windowDidLoad];
    
    
    NSColor *semiTransparentBlue =
    [NSColor colorWithDeviceRed:0.0 green:0.0 blue:1.0 alpha:0.5];
    [self.window setBackgroundColor:semiTransparentBlue];
    
    NSLog(@"%@",self.contentViewController);
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (void)showWindow:(id)sender
{
    [super showWindow:sender];
        NSLog(@"%@",self.contentViewController);
}

@end
