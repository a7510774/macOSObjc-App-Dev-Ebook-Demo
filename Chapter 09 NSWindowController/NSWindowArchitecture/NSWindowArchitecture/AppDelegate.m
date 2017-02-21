//
//  AppDelegate.m
//  NSWindowArchitecture
//
//  Created by zhaojw on 5/9/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//

#import "AppDelegate.h"
#import "AppMainWindowController.h"
@interface AppDelegate ()
@property(nonatomic,strong)AppMainWindowController *mainWindowController;
@end

@implementation AppDelegate
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    NSViewController *viewController =  [[NSViewController alloc]init];
    CGRect frame = CGRectMake(0, 0, 200, 200);
    NSView *view = [[NSView alloc]initWithFrame:frame];
    viewController.view = view;
    
    self.mainWindowController.contentViewController = viewController;
    
    [self.mainWindowController showWindow:self];
}

- (AppMainWindowController *)mainWindowController {
    if(!_mainWindowController){
        _mainWindowController = [[AppMainWindowController alloc]init];
    }
    return _mainWindowController;
}
@end
