//
//  CircleView.m
//  NSView
//
//  Created by iDevFans on 16/6/21.
//  Copyright © 2016年 http://www.macdev.io. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    [[NSColor blueColor] setFill];
    
    NSBezierPath* thePath = [NSBezierPath bezierPathWithOvalInRect:dirtyRect];
    [thePath fill];
    

}

@end
