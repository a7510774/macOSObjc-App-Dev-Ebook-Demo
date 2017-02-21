//
//  AppDelegate.m
//  AnimationDemo
//
//  Created by zhaojw on 3/14/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//

#import "AppDelegate.h"
#import "WindowController.h"
@interface AppDelegate ()
@property(nonatomic,strong)WindowController *mainWindowController;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    [self.mainWindowController showWindow:self];
    
    //CAShapeLayer *dgd;
    
    
   
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (WindowController*)mainWindowController {
    if(!_mainWindowController){
        _mainWindowController = [[WindowController alloc]initWithWindowNibName:@"WindowController"];
    }
    return _mainWindowController;
}


@end
