//
//  NSConditionTest.m
//  RunLoopDemo
//
//  Created by zhaojw on 1/24/16.
//  Copyright © 2016 Chun Tips. All rights reserved.
//

#import "NSConditionTest.h"
@interface NSConditionTest ()
@property(nonatomic,assign)BOOL completed;
@property(nonatomic,strong)NSCondition *condition;
@end

@implementation NSConditionTest

- (void)clearCondition{
    self.completed = NO;
}
- (void)doWork1{
    NSLog(@"doWork1 Begin");
    [self.condition lock];
    while (!self.completed) {
        [self.condition wait];
    }
    NSLog(@"doWork1 End");
    [self.condition unlock];
}

- (void)doWork2{
    NSLog(@"doWork2 Begin");
    //do some work
    [self.condition lock];
    self.completed = YES;
    [self.condition signal];
    [self.condition unlock];
    NSLog(@"doWork2 End");
}

- (void)doWork {
    [self performSelectorInBackground:@selector(doWork1) withObject:nil ];
    [self performSelector:@selector(doWork2) withObject:nil afterDelay:0.1];
}

- (NSCondition*)condition {
    if(!_condition){
        _condition = [[NSCondition alloc]init];
    }
    return _condition;
}
@end
