//
//  AppDelegate.m
//  NSButton
//
//  Created by zhaojw on 15/8/25.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    [self createButton];
}

- (void)createButton {
    
    NSButton *btn =  [[NSButton alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];
    
    
    [btn setButtonType:NSPushOnPushOffButton];
    
    btn.bezelStyle =  NSRoundedBezelStyle;
    
    btn.title = @"CodeButton";
    
    [self.window.contentView addSubview:btn];
    
    btn.target = self;
    
    btn.action = @selector(codeButtonClicked:);
    
}



- (IBAction)codeButtonClicked:(id) sender {
    NSLog(@"Code Button Clicked!");
}


- (IBAction)buttonClicked:(id)sender {
    NSLog(@"Button Clicked!");
}


@end
