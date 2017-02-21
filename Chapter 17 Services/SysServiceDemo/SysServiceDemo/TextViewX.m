//
//  TextViewX.m
//  SysServiceDemo
//
//  Created by zhaojw on 11/20/15.
//  Copyright © 2015 zhaojw. All rights reserved.
//

#import "TextViewX.h"

@implementation TextViewX

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (id)validRequestorForSendType:(NSString *)sendType
                     returnType:(NSString *)returnType
{
    if ([sendType isEqual:NSStringPboardType] &&
        [returnType isEqual:NSStringPboardType]) {
        
        return self;
        
    }
    return [super validRequestorForSendType:sendType returnType:returnType];
}

- (BOOL)writeSelectionToPasteboard:(NSPasteboard *)pboard
                             types:(NSArray *)types
{
    NSArray *typesDeclared;
    if ([types containsObject:NSStringPboardType] == NO) {
        return NO;
    }
    typesDeclared = [NSArray arrayWithObject:NSStringPboardType];
    [pboard declareTypes:typesDeclared owner:nil];
    return [pboard setString:[self string] forType:NSStringPboardType];
}


- (BOOL)readSelectionFromPasteboard:(NSPasteboard *)pboard
{
    NSArray *types;
    NSString *theText;
    types = [pboard types];
    if ( [types containsObject:NSStringPboardType] == NO ) {
        return NO; }
    theText = [pboard stringForType:NSStringPboardType];
    self.string = theText;
    return YES;
}

@end
