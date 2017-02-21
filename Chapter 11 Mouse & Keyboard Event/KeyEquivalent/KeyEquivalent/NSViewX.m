//
//  NSViewX.m
//  KeyEquivalent
//
//  Created by zhaojw on 15/11/15.
//  Copyright © 2015年 zhaojw. All rights reserved.
//

#import "NSViewX.h"

@implementation NSViewX

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}


- (void)awakeFromNib {
    
    self.wantsLayer = YES;
    self.layer.backgroundColor = [NSColor redColor].CGColor;
}

-(BOOL)acceptsFirstResponder{
    return YES;
}

- (void)keyDown:(NSEvent *)theEvent {
    
    NSLog(@"keyDown");
    [self interpretKeyEvents:[NSArray arrayWithObject:theEvent]];
}

- (void)insertText:(id)insertString
{
    NSLog(@"insertString %@",insertString);
}

- (void)doCommandBySelector:(SEL)aSelector {
    
    NSLog(@"doCommandBySelector %@",NSStringFromSelector(aSelector));
    [super doCommandBySelector:aSelector];
}

-(void)moveUp:(id)sender {

}
-(void)moveDown:(id)sender {
    
}
-(void)moveLeft:(id)sender {
    
}
-(void)moveRight:(id)sender {
    
}
-(void)deleteBackward:(id)sender {
    
}
-(void)insertNewline:(id)sender {
    
}


@end
