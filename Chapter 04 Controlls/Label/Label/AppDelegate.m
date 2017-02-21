//
//  AppDelegate.m
//  Label
//
//  Created by zhaojw on 15/8/25.
//  Copyright (c) 2015年 http://macdev.io All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;

@property (weak) IBOutlet NSTextField *richTextLabel;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    NSString *text =@"please visit http://www.apple.com/";
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:text];
    
    NSString *linkURLText = @"http://www.apple.com/";
    
    NSURL *linkURL = [NSURL URLWithString:linkURLText];
    
    NSRange selectedRange = [text rangeOfString:linkURLText];
    
    [string beginEditing];
    [string addAttribute:NSLinkAttributeName
                   value:linkURL
                   range:selectedRange];
    [string addAttribute:NSForegroundColorAttributeName
                   value:[NSColor blueColor]
                   range:selectedRange];
    [string addAttribute:NSUnderlineStyleAttributeName
                   value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:selectedRange];
    [string endEditing];
    
    self.richTextLabel.attributedStringValue = string;
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
    
   
}

@end
