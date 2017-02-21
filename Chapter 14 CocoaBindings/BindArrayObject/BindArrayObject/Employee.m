//
//  Employee.m
//  BindDemo
//
//  Created by zhaojw on 15/9/25.
//  Copyright © 2015年 zhaojw. All rights reserved.
//

#import "Employee.h"

@implementation Employee


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    NSLog(@"change %@",change);
}
- (void)addObserver2:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;
{
    NSLog(@"change observer %@ forKeyPath %@",observer,keyPath);
}


@end
