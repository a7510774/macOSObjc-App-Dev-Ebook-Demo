//
//  BabyLayer.m
//  AnimationDemo
//
//  Created by zhaojw on 3/29/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//

#import "BabyLayer.h"
#import <Cocoa/Cocoa.h>
#import <QuartzCore/QuartzCore.h>
@implementation BabyLayer

- (void)display {
    NSImage *image = [NSImage imageNamed:@"gradintCell"];
    self.contents =image;
}

- (void)drawInContext:(CGContextRef)ctx {
    CGContextSetLineWidth(ctx, 4.0f);
    CGContextSetStrokeColorWithColor(ctx, [NSColor greenColor].CGColor);
    CGContextSetFillColorWithColor(ctx, [NSColor blueColor].CGColor);
    CGContextFillRect(ctx, self.bounds);
}

@end
