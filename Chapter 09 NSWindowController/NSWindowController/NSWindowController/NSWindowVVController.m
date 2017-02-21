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
    
    
    NSLog(@"%@",self.contentViewController);
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (void)showWindow:(id)sender
{
    [super showWindow:sender];
        NSLog(@"%@",self.contentViewController);
}

@end
