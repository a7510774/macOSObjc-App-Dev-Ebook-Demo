//
//  AppMainWindowController.m
//  NSWindowArchitecture
//
//  Created by zhaojw on 5/9/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//

#import "AppMainWindowController.h"
@interface AppMainWindowController ()
@end

@implementation AppMainWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    [self.window center];
}

- (NSString*)windowNibName {
    return @"AppMainWindowController";
}
@end
