//
//  NSConditionLockTest.m
//  NSQueueDemo
//
//  Created by zhaojw on 1/24/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//

#import "NSConditionLockTest.h"

@interface NSConditionLockTest ()
@property(nonatomic,strong)NSMutableArray *queue;
@property(nonatomic,strong)NSConditionLock *condition;
@end

@implementation NSConditionLockTest
- (void)doWork1 {

    NSLog(@"doWork1 Begin");
    
    while(true)
    {
        sleep(1);
        [self.condition lock];
        NSLog(@"doWork1 ");
        [self.queue addObject:@"A1"];
        [self.queue addObject:@"A2"];
        [self.condition unlockWithCondition:2];
    }
    NSLog(@"doWork1 End");
}

- (void)doWork2 {
    NSLog(@"doWork2 Begin");
    while(true)
    {
        sleep(1);
        [self.condition lockWhenCondition:2];
        NSLog(@"doWork2 ");
        [self.queue removeAllObjects];
        [self.condition unlock];
    }
    NSLog(@"doWork2 End");
}

- (void)doWork {
    [self performSelectorInBackground:@selector(doWork1) withObject:nil ];
    [self performSelector:@selector(doWork2) withObject:nil afterDelay:0.1];
}

- (NSMutableArray *)queue {
    if(!_queue){
        _queue = [[NSMutableArray alloc]init];
    }
    return _queue;
}

- (NSConditionLock*)condition {
    if(!_condition) {
        _condition = [[NSConditionLock alloc]init];
    }
    return _condition;
}
@end
