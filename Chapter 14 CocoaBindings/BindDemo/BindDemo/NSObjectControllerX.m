//
//  NSObjectControllerX.m
//  BindDemo
//
//  Created by zhaojw on 10/6/15.
//  Copyright © 2015 zhaojw. All rights reserved.
//

#import "NSObjectControllerX.h"

@implementation NSObjectControllerX

- (void)observeValueForKeyPath2:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    NSLog(@"change %@",change);
}
- (void)addObserver2:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;
{
    NSLog(@"change observer %@ forKeyPath %@",observer,keyPath);
}

- (void)discardEditing
{
    NSLog(@"sdfsfs");
}
- (BOOL)commitEditing
{
    return YES;
}
@end
