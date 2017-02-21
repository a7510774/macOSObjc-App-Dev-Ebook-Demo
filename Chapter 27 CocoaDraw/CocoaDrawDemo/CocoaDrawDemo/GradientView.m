//
//  GradientView.m
//  CocoaDrawDemo
//
//  Created by zhaojw on 2/29/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//

#import "GradientView.h"

@implementation GradientView



-(void)drawRect:(NSRect)rect {
  
    
    
    NSRect        bounds = [self bounds];
    NSBezierPath*    clipShape = [NSBezierPath bezierPath];
    [clipShape appendBezierPathWithRect:bounds];
    
    NSGradient* aGradient = [[NSGradient alloc]
                              initWithColorsAndLocations:[NSColor redColor], (CGFloat)0.0,
                              [NSColor greenColor], (CGFloat)0.5,
                              [NSColor yellowColor], (CGFloat)0.75,
                              [NSColor blueColor], (CGFloat)1.0,
                              nil];
    //[aGradient drawInBezierPath:clipShape angle:90];
    //NSPoint centerPoint = NSMakePoint(1, -1);
    
    //[aGradient drawInBezierPath:clipShape relativeCenterPosition :centerPoint];
    
  
    
//    NSPoint centerPoint = NSMakePoint(NSMidX(bounds), NSMidY(bounds));
//    NSPoint otherPoint = NSMakePoint(centerPoint.x + 20.0, centerPoint.y +20.0);
//    
    NSPoint centerPoint = NSMakePoint(0, 0);
    NSPoint otherPoint = NSMakePoint(0, 60);
  
    [aGradient drawFromPoint:centerPoint toPoint:otherPoint options:NSGradientDrawsBeforeStartingLocation];
    
    //NSGradientDrawsBeforeStartingLocation
    //NSGradientDrawsAfterEndingLocation
}


-(void)drawRect22:(NSRect)rect {


    NSRect bounds = [self bounds];
    NSGradient* aGradient = [[NSGradient alloc]
                              initWithStartingColor:[NSColor blueColor] endingColor:[NSColor greenColor]];
    NSPoint centerPoint = NSMakePoint(NSMidX(bounds), NSMidY(bounds));
    NSPoint otherPoint = NSMakePoint(centerPoint.x + 10.0, centerPoint.y +10.0);
    [aGradient drawFromCenter:otherPoint radius:5
                     toCenter:centerPoint radius:50.0
                      options:0];
}

@end
