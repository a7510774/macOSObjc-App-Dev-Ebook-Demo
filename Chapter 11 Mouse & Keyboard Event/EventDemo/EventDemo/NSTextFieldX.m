//
//  NSTextFieldX.m
//  EventDemo
//
//  Created by zhaojw on 15/10/13.
//  Copyright © 2015年 zhaojw. All rights reserved.
//

#import "NSTextFieldX.h"

@implementation NSTextFieldX

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (BOOL)canBecomeKeyView
{
    return YES;
}

-(BOOL)acceptsFirstResponder{
    NSLog(@"NSTextFieldX Accepting");
    return YES;
}

-(BOOL)resignFirstResponder{
    NSLog(@"NSTextFieldX Resigning");
    return YES;
}

-(BOOL)becomeFirstResponder{
    NSLog(@"NSTextFieldX Becoming");
    return YES;
    
}

- (void)insertTab:(id)sender {
     NSLog(@"NSTextFieldX insertTab ");
    
    if ([[self window] firstResponder] == self) {
        [[self window] selectNextKeyView:self];
    }
}

- (void)doCommandBySelector :(SEL)aSelector;
{
     NSLog(@"NSTextFieldX doCommandBySelector ");
}

- (void)keyDown2:(NSEvent *)theEvent {
    [self interpretKeyEvents:[NSArray arrayWithObject:theEvent]];
}
- (void)insertText:(id)insertString
{
    NSLog(@"insertString %@",insertString);
    
    self.stringValue = insertString;
    
    //[super insertText:insertString];
}
@end
