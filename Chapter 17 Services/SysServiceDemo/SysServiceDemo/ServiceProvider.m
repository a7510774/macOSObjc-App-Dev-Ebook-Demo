//
//  ServiceProvider.m
//  SysServiceDemo
//
//  Created by zhaojw on 11/19/15.
//  Copyright © 2015 zhaojw. All rights reserved.
//

#import "ServiceProvider.h"

@implementation ServiceProvider


- (NSString*)convertToUpperCase:(NSString*)string {
    
    if(string){
        return  string.uppercaseString;
    }
    return string;
}

- (void)upperCaseText:(NSPasteboard *)pboard
          userData:(NSString *)userData error:(NSString **)error {
    
    NSArray *classes = [NSArray arrayWithObject:[NSString class]];
    NSDictionary *options = [NSDictionary dictionary];
    if (![pboard canReadObjectForClasses:classes options:options]) {
        *error = NSLocalizedString(@"Error: couldn't convert text.",
                                   @"pboard couldn't uppercase string.");
        return;
    }
    
    NSString *pboardString = [pboard stringForType:NSPasteboardTypeString];
    NSString *uppserCaseString = [self convertToUpperCase:pboardString];
    if (!uppserCaseString) {
        
        *error = NSLocalizedString(@"Error: couldn't convert text.",
                                   @"pboard couldn't uppercase string.");
        return;
        
    }
    
    [pboard clearContents];
    [pboard writeObjects:[NSArray arrayWithObject:uppserCaseString]];
}


@end
