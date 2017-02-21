//
//  AppDelegate.m
//  NSSlider
//
//  Created by iDevFans on 16/10/26.
//  Copyright © 2016年 macdev. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (IBAction)sliderAction:(id)sender {
    
    NSSlider *slider = sender;
    
    NSInteger value = slider.integerValue;
    
    float fvalue = slider.floatValue;
    
    NSLog(@"sliderAction value %ld fvalue%lf",value,fvalue);
    
    
}
@end
