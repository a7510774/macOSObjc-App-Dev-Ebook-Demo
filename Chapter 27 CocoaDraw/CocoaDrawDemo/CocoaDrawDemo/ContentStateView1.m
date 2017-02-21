//
//  ContentStateView1.m
//  CocoaDrawDemo
//
//  Created by zhaojw on 5/24/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//

#import "ContentStateView1.h"

@implementation ContentStateView1

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
     NSGraphicsContext* theContext = [NSGraphicsContext currentContext];

    NSLog(@"ContentStateView1 theContext %@ attributes%@",theContext,[theContext attributes]);
    // Drawing code here.
    [[NSColor redColor] setStroke];
    [[NSColor redColor] setFill];
  
    
    
    NSShadow* theShadow = [[NSShadow alloc] init];
    [theShadow setShadowOffset:NSMakeSize(5.0, -5.0)];
    [theShadow setShadowBlurRadius:2.0];
    [theShadow setShadowColor:[[NSColor blueColor]
                               colorWithAlphaComponent:0.3]];
    [theShadow set];

      NSRectFill(dirtyRect);
    // Drawing code here.
}




@end
