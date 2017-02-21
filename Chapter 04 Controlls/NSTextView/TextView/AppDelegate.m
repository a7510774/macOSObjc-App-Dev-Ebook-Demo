//
//  AppDelegate.m
//  TextView
//
//  Created by zhaojw on 15/8/26.
//  Copyright (c) 2015年 http://macdev.io All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()<NSTextViewDelegate>
@property (unsafe_unretained) IBOutlet NSTextView *textView;

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


#pragma mark-- NSTextView

//- (BOOL)textShouldBeginEditing:(NSText *)textObject {
//    return YES;
//}
//- (BOOL)textShouldEndEditing:(NSText *)textObject {
//    return NO;
//}
- (void)textDidBeginEditing:(NSNotification *)notification {
    NSTextView *textView = notification.object;
    
    NSLog(@"textDidBeginEditing textView %@",textView.string);
}
- (void)textDidEndEditing:(NSNotification *)notification {
    NSTextView *textView = notification.object;
    
    NSLog(@"textDidEndEditing textView %@",textView.string);
}
- (void)textDidChange:(NSNotification *)notification {
    NSTextView *textView = notification.object;
    
    NSLog(@"textDidChange textView %@",textView.string);
}




@end
