//
//  NSButtonX.m
//  SysServiceDemo
//
//  Created by zhaojw on 11/19/15.
//  Copyright © 2015 zhaojw. All rights reserved.
//

#import "NSButtonX.h"

@implementation NSButtonX

+ (void)initialize
{
    static BOOL initialized = NO;
    /* Make sure code only gets executed once. */
    if (initialized == YES) return;
    initialized = YES;
    NSArray *sendTypes = [NSArray arrayWithObjects:NSStringPboardType,
         nil];
    NSArray *returnTypes = [NSArray arrayWithObjects:NSStringPboardType,
                   nil];
    [NSApp registerServicesMenuSendTypes:sendTypes
                             returnTypes:returnTypes];
}


- (BOOL)canBecomeKeyView
{
    return YES;
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


- (id)validRequestorForSendType:(NSString *)sendType
                     returnType:(NSString *)returnType {

    if ([sendType isEqual:NSStringPboardType] &&
        [returnType isEqual:NSStringPboardType]) {
        
            return self;
        
    }
    return [super validRequestorForSendType:sendType returnType:returnType];
}

- (BOOL)writeSelectionToPasteboard:(NSPasteboard *)pboard
                             types:(NSArray *)types {

    NSArray *typesDeclared;
    if ([types containsObject:NSStringPboardType] == NO) {
        return NO;
    }
    typesDeclared = [NSArray arrayWithObject:NSStringPboardType];
    [pboard declareTypes:typesDeclared owner:nil];
    return [pboard setString:[self title] forType:NSStringPboardType];
}


- (BOOL)readSelectionFromPasteboard:(NSPasteboard *)pboard {

    NSArray *types;
    NSString *theText;
    types = [pboard types];
    if ( [types containsObject:NSStringPboardType] == NO ) {
        return NO; }
    theText = [pboard stringForType:NSStringPboardType];
    self.title = theText;
    return YES;
}
    
@end
