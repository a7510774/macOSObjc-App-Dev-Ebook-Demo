//
//  DisableVerticalScrollView.m
//  NSScrollViewDemo
//
//  Created by iDevFans on 16/10/22.
//  Copyright © 2016年 zhaojw. All rights reserved.
//

#import "DisableVerticalScrollView.h"

@implementation DisableVerticalScrollView
- (void)scrollWheel:(NSEvent *)event {
    
    self.borderType
    float dy = fabs(event.deltaY);
    if ((event.deltaX == 0.0) && (dy >= 0.01 )) {
        return;
    }
    if ((event.deltaX == 0.0) && (dy == 0.0))  {
        return;
    }
    else {
        [super scrollWheel:event];
    }
}
@end
