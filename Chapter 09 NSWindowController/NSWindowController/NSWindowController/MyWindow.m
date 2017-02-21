//
//  MyWindow.m
//  NSWindowController
//
//  Created by zhaojw on 15/9/13.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import "MyWindow.h"

@implementation MyWindow
- (void)setWindowController:(NSWindowController *)windowController
{
    [super setWindowController:windowController];
    
    NSApplication *f;
    
    NSWindowController *wc;
}

- (void)sendEvent:(NSEvent *)theEvent
{
    
     NSLog(@"theEvent %@ ",theEvent);
    return;
    
    [super sendEvent:theEvent];
    
    
    
    if(theEvent.type ==NSEventTypePressure){
        
    }
    else{
        NSLog(@"%ld",theEvent.type);
    }
}
- (instancetype)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag
{
    return [super initWithContentRect:contentRect styleMask:aStyle backing:bufferingType defer:flag];
}
- (instancetype)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag screen:(NSScreen *)screen
{
    return [super initWithContentRect:contentRect styleMask:aStyle backing:bufferingType defer:flag screen:screen];
}

- (void)makeKeyWindow
{
    [super makeKeyWindow]   ;
    
    NSRect frame = NSMakeRect(0, 0, 100, 40);
    
    self.textField = [[NSTextField alloc]initWithFrame:frame];
    
    [self.contentView addSubview:self.textField];
    
    self.textField.delegate = self;
}

- (void)controlTextDidBeginEditing:(NSNotification *)obj
{
    id text = obj.object;
    
   
    
}


- (void)orderFront:(id)sender
{
    [super orderFront:sender];
}
- (void)setContentSize:(NSSize)aSize
{
    [super setContentSize:aSize];
}

- (BOOL)makeFirstResponder:(NSResponder *)aResponder
{
   return [super makeFirstResponder:aResponder];
}
- (void)displayIfNeeded
{
    [super displayIfNeeded];
}
- (void)display
{
    [super display];
}
@end
