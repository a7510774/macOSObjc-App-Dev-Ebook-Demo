//
//  NSViewX.m
//  EventDemo
//
//  Created by zhaojw on 15/10/13.
//  Copyright © 2015年 zhaojw. All rights reserved.
//

#import "NSViewX.h"

@implementation NSViewX


- (BOOL)performKeyEquivalent:(NSEvent *)theEvent {
    
    return YES;
}



- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (BOOL)isFlipped
{
    return YES;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
   
    
    CGRect eyeBox = CGRectMake(0, 0, 40, 40);
    
    NSTrackingArea *trackingArea = [[NSTrackingArea alloc] initWithRect:eyeBox
                                                options: (NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved |
                                                          NSTrackingActiveInKeyWindow|NSTrackingCursorUpdate )
                   
                   
                                                  owner:self userInfo:nil];
    
    [self addTrackingArea:trackingArea];
    
}


- (void)mouseEntered:(NSEvent *)theEvent {
   
    NSPoint eyeCenter = [self convertPoint:[theEvent locationInWindow] fromView:nil];
    
    NSLog(@"mouseEntered");
    
}

- (void)mouseExited:(NSEvent *)theEvent {
    
     NSLog(@"mouseExited");
    
     [[NSCursor arrowCursor] set];
}

- (void)mouseMoved:(NSEvent *)theEvent {
    
    NSLog(@"mouseMoved");
    
 
}

-(void)cursorUpdate:(NSEvent *)theEvent
{
    [[NSCursor crosshairCursor] set];
}

- (BOOL)canBecomeKeyView
{
    return NO;
}

-(BOOL)acceptsFirstResponder{
    NSLog(@"NSViewX Accepting");
    return YES;
}

-(BOOL)resignFirstResponder{
    NSLog(@"NSViewX Resigning");
    return YES;
}

-(BOOL)becomeFirstResponder{
    NSLog(@"NSViewX Becoming");
    return YES;
    
}

- (void)insertTab:(id)sender {
    NSLog(@"NSViewX insertTab ");
}




- (void)mouseDown:(NSEvent *)theEvent {
    if(1) {
        NSLog(@"mouseDown");

    }
    else{
        [super mouseDown:theEvent];
    }
}

- (void)mouseUp:(NSEvent *)theEvent {
    
    if(1) {
         NSLog(@"mouseUp");
    }
    else{
        [super mouseUp:theEvent];
    }
    
}

- (void)keyDown:(NSEvent *)theEvent {
    
    NSString *str = theEvent.characters;
    
    NSString *strIg = theEvent.charactersIgnoringModifiers;
    
    NSInteger code = theEvent.keyCode;
    
     NSLog(@"str %@",str);
    
     NSLog(@"strIg %@",strIg);
    
     NSLog(@"code %ld ",code);
    
    [self interpretKeyEvents:[NSArray arrayWithObject:theEvent]];
}

- (void)doCommandBySelector3333:(SEL)aSelector;
{
    NSLog(@"NSViewX doCommandBySelector ");
}
- (void)insertText:(id)insertString
{
    NSLog(@"insertString %@",insertString);
}
- (void)keyDown2:(NSEvent *)theEvent
{
     NSLog(@"theEvent %@",theEvent);
}
@end
