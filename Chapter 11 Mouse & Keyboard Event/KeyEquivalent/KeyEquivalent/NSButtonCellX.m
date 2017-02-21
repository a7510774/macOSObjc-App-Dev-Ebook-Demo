//
//  NSButtonCellX.m
//  KeyEquivalent
//
//  Created by zhaojw on 15/11/14.
//  Copyright © 2015年 zhaojw. All rights reserved.
//

#import "NSButtonCellX.h"

@implementation NSButtonCellX
- (BOOL)sendAction:(SEL)theAction to:(nullable id)theTarget from:(nullable id)sender {
    
    NSLog(@"sendAction");
    
    return YES;
}

- (void)mouseDown:(NSEvent *)theEvent {
    //[self setFrameColor:[NSColor redColor]];
     NSLog(@"mouseDown");
}

- (void)mouseUp:(NSEvent *)theEvent {
    //[self setFrameColor:[NSColor greenColor]];
    //[self setNeedsDisplay:YES];
    [NSApp sendAction:[self action] to:[self target] from:self];
}

@end
