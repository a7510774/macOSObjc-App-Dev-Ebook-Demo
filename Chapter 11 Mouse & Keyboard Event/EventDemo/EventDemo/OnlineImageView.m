//
//  OnlineImageView.m
//  EventDemo
//
//  Created by zhaojw on 15/10/15.
//  Copyright © 2015年 zhaojw. All rights reserved.
//

#import "OnlineImageView.h"

@interface OnlineImageView ()
{
    BOOL   draged;
    CGRect centerBox;
}
@end
@implementation OnlineImageView

- (void)awakeFromNib
{
    [super awakeFromNib];
    CGRect frame = self.bounds;
    centerBox = CGRectInset(frame,10,10);
}

- (void)mouseDown:(NSEvent *)theEvent {
    
    NSPoint eventLocation = [theEvent locationInWindow];
    
    NSPoint point = [self convertPoint:eventLocation fromView:nil];
    //判断当前鼠标位置是否在中心点范围内
    if (NSPointInRect(point, centerBox)) {
          draged = YES;
    }
}

- (void)mouseDragged:(NSEvent *)theEvent {
  
   if (draged) {
       
        NSPoint eventLocation = [theEvent locationInWindow];
       
        CGRect positionBox = CGRectMake(eventLocation.x, eventLocation.y, self.frame.size.width, self.frame.size.height);
       
       // self.frame = positionBox;
       
       
       [self setFrameOrigin:eventLocation];
    }
}



- (void)mouseUp:(NSEvent *)theEvent {
    
    draged = NO;
    
}

@end
