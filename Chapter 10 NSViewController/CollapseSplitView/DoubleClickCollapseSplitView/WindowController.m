//
//  WindowController.m
//  DoubleClickCollapseSplitView
//
//  Created by iDevFans on 2016/11/3.
//  Copyright © 2016年 macdev. All rights reserved.
//

#import "WindowController.h"
NSString *kOpenCloseViewNotification = @"OpenCloseViewNotification";
@interface WindowController ()

@end

@implementation WindowController

- (void)windowDidLoad {
    [super windowDidLoad];
}

- (IBAction)openCloseAction:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:kOpenCloseViewNotification object:nil];
}

@end
