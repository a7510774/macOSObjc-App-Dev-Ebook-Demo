//
//  CustomView.m
//  AnimationDemo
//
//  Created by zhaojw on 3/29/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//

#import "CustomView.h"
#import "BabyLayer.h"
@implementation CustomView



- (void)drawRect:(NSRect) rect {
    if(!_lineColor){
        _lineColor = [NSColor blackColor];
    }
    [_lineColor set];
    NSFrameRectWithWidth(self.bounds,2);
}
- (void)setLineColor:(NSColor *)lineColor  {
    _lineColor=lineColor;
    [self setNeedsDisplay:YES];
}


+ (id)defaultAnimationForKey:(NSString *)key {
    if([key isEqualToString:@"lineColor"]){
        return[CABasicAnimation animation];
    }
    return[super defaultAnimationForKey:key];
}



- (void)drawRect2:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    // Drawing code here.
}


//-(void)drawLayer:(CALayer *)theLayer inContext:(CGContextRef)theContext {
//    
//    //[super dra
//    
//}


-(void)drawRect3:(NSRect)dirtyRect {
    
    const NSRect *rectsBeingDrawn = NULL;
    NSInteger rectsBeingDrawnCount = 0;
    NSArray *drawObjects = [self allDrawObjects];
    
    [self getRectsBeingDrawn:&rectsBeingDrawn count:&rectsBeingDrawnCount];
    
    for(id drawObject in drawObjects){
        for (NSInteger i = 0; i < rectsBeingDrawnCount; i++) {
            if (NSIntersectsRect([drawObject bounds], dirtyRect)) {
                [drawObject draw];
            }
        }
    }
}

- (NSArray*)allDrawObjects{
    return nil;
}
@end
