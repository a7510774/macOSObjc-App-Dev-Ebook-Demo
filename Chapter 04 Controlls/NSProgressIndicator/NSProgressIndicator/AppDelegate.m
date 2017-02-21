//
//  AppDelegate.m
//  NSProgressIndicator
//
//  Created by zhaojw on 15/9/2.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
@property (weak) IBOutlet NSProgressIndicator *barIndicator;
@property (weak) IBOutlet NSProgressIndicator *smallCircleIndicator;
@property (weak) IBOutlet NSProgressIndicator *regularCircleIndicator;

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    
 
    
    
    NSApplication *g;
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (IBAction)startIndicatorAction:(id)sender;
{
    [self.barIndicator startAnimation:self];
    
    self.barIndicator.doubleValue = 50;
    
    [self.smallCircleIndicator startAnimation:self];
    
    self.smallCircleIndicator.doubleValue = 50;

    [self.regularCircleIndicator startAnimation:self];
}


- (IBAction)stopIndicatorAction:(id)sender;
{
    
    [self.barIndicator stopAnimation:self];

    [self.smallCircleIndicator stopAnimation:self];
    [self.regularCircleIndicator stopAnimation:self];
}


@end
