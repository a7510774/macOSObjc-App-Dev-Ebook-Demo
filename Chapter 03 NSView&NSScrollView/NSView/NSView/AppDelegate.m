//
//  AppDelegate.m
//  NSView
//
//  Created by iDevFans on 16/6/21.
//  Copyright © 2016年 http://www.macdev.io. All rights reserved.
//

#import "AppDelegate.h"
#import "CustomView.h"
@interface AppDelegate ()
@property (weak) IBOutlet NSView *layerView;
@property (weak) IBOutlet CustomView *customView;
@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [self layerViewConfig];
}

- (void)layerViewConfig {
    self.layerView.wantsLayer = YES;
    self.layerView.layer.backgroundColor = [NSColor blueColor].CGColor;
}


- (IBAction)drawViewAction:(id)sender {
    [self drawViewShape];
}

- (void)drawViewShape {
    
    [self.layerView lockFocus];
    
    NSRectFill(self.layerView.bounds);
    
    NSString *str = @"RoundedRect";
    NSFont *font = [NSFont fontWithName:@"Palatino-Roman" size:14.0];
    NSColor *strColor = [NSColor greenColor];
    NSColor *bkColor = [NSColor blueColor];
    NSMutableDictionary *attrsDictionary = [NSMutableDictionary dictionary];
    
    attrsDictionary[NSFontAttributeName] = font;
    attrsDictionary[NSForegroundColorAttributeName] = strColor;
    attrsDictionary[NSBackgroundColorAttributeName] = bkColor;
    
    NSPoint p = CGPointMake(20, 20);
    [str drawAtPoint:p withAttributes:attrsDictionary];
    
    [self.layerView unlockFocus];
}


- (IBAction)saveViewImageAction:(id)sender {
    [self.customView saveSelfAsImage];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
