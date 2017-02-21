//
//  ContentStateView2.m
//  CocoaDrawDemo
//
//  Created by zhaojw on 5/24/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//

#import "ContentStateView2.h"

@implementation ContentStateView2

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    NSGraphicsContext* theContext = [NSGraphicsContext currentContext];

    
    NSLog(@"ContentStateView2 theContext %@ attributes%@",theContext,[theContext attributes]);
    // Drawing code here.
    
     NSRectFill(dirtyRect);
}

@end
