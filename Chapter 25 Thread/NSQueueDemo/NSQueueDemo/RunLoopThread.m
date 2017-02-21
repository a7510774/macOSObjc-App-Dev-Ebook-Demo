//
//  RunLoopThread.m
//  NSQueueDemo
//
//  Created by zhaojw on 1/19/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//

#import "RunLoopThread.h"

@implementation RunLoopThread


static void runLoopObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info)
{
    NSLog(@"activity %ld",activity);
}

- (void)main
{
    // The application uses garbage collection, so no autorelease pool is needed.
    NSRunLoop* myRunLoop = [NSRunLoop currentRunLoop];
    // Create a run loop observer and attach it to the run loop.
    CFRunLoopObserverContext context = {0, (__bridge void *)(self), NULL, NULL, NULL}; CFRunLoopObserverRef observer = CFRunLoopObserverCreate(kCFAllocatorDefault,
                                                                                                                            kCFRunLoopAllActivities, YES, 0, &runLoopObserverCallBack, &context);
    if (observer)
    {
        CFRunLoopRef    cfLoop = [myRunLoop getCFRunLoop];
        CFRunLoopAddObserver(cfLoop, observer, kCFRunLoopDefaultMode);
    }
    // Create and schedule the timer.
     NSTimer *timer = [NSTimer timerWithTimeInterval:0.2 target:self selector:@selector(doFireTimer) userInfo:@"ya了个hoo" repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
       NSInteger    loopCount = 10;
    do
    {
        // Run the run loop 10 times to let the timer fire.
        [myRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
        loopCount--;
    }
    while (loopCount);
}

- (void)doFireTimer{
    NSLog(@"doFireTimer");
}
@end
