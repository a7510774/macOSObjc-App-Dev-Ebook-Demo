//
//  CircleNoFillView.m
//  NSView
//
//  Created by iDevFans on 16/6/21.
//  Copyright © 2016年 http://www.macdev.io. All rights reserved.
//

#import "CircleNoFillView.h"

@implementation CircleNoFillView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    [[NSColor blueColor] setStroke];
    
    NSBezierPath* thePath = [NSBezierPath bezierPathWithOvalInRect:dirtyRect];
    [thePath stroke];
    // Drawing code here.
}



@end
