//
//  NSButtonX.m
//  KeyEquivalent
//
//  Created by zhaojw on 15/11/13.
//  Copyright © 2015年 zhaojw. All rights reserved.
//

#import "NSButtonX.h"

@implementation NSButtonX

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}


-(BOOL)acceptsFirstResponder{
    NSLog(@"NSViewX Accepting");
    return YES;
}


- (void)mouseDown2:(NSEvent *)theEvent {
     NSLog(@"mouseDown");
}
- (void)keyDown:(NSEvent *)theEvent {
    
    NSLog(@"button keyDown");
    [self interpretKeyEvents:[NSArray arrayWithObject:theEvent]];
}

- (void)insertText:(id)insertString
{
    NSLog(@"button insertString %@",insertString);
}

- (BOOL)sendAction:(SEL)theAction to:(id)theTarget {
    
    NSLog(@"sendAction");
    
    return [super sendAction:theAction to:theTarget];
    
    //return YES;
}


- (BOOL)sendAction:(SEL)theAction to:(nullable id)theTarget from:(nullable id)sender {
    
    NSLog(@"sendAction");
    
    return YES;
}

- (void)mouseDown333:(NSEvent *)theEvent {
    
    [self setNeedsDisplay:YES];
}

- (void)mouseUp33:(NSEvent *)theEvent {
    //[self setFrameColor:[NSColor greenColor]];
    //[self setNeedsDisplay:YES];
    [NSApp sendAction:[self action] to:[self target] from:self];
}

- (void)keyUp:(NSEvent *)theEvent {
    
    NSLog(@"keyUp");
}

- (BOOL)performKeyEquivalent:(NSEvent *)theEvent {
    
    NSString  *characters;
    
    characters = [theEvent charactersIgnoringModifiers];
    // is the "r" key pressed?
    if ([characters isEqual:@"l"]) {
        [self performClick:self];
        
        return YES;

    }
    
    return NO;
}

@end
