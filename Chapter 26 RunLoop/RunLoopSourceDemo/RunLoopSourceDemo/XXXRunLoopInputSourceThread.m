//
//  XXXRunLoopInputSourceThread.m
//  RunLoopSourceDemo
//
//  Created by zhaojw on 1/25/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//

#import "XXXRunLoopInputSourceThread.h"
#import "XXXRunLoopInputSource.h"

@interface XXXRunLoopInputSourceThread ()<XXXRunLoopInputSourceDelegate>
@property(nonatomic,strong)XXXRunLoopInputSource *source;
@end


@implementation XXXRunLoopInputSourceThread

- (void)main
{
    @autoreleasepool {
        
        NSLog(@"XXXRunLoopInputSourceThread Enter");
        //获取线程的runloop
        NSRunLoop *currentRunLoop = [NSRunLoop currentRunLoop];
        self.source = [[XXXRunLoopInputSource alloc] init];
        self.source.delegate = self;
        //增建source并将其加入到runloop
        [self.source addToCurrentRunLoop];
        while (!self.cancelled) {
             NSLog(@"Enter Run Loop");
            [self doOtherWork];
            [currentRunLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
            NSLog(@"Exit Run Loop");
        }
        
        NSLog(@"XXXRunLoopInputSourceThread Exit");
    }
}

- (void)doOtherWork
{
    NSLog(@"Begin Do OtherWork");
    NSLog(@"-------------------");
    NSLog(@"End Do OtherWork");
}

#pragma mark-  XXXRunLoopInputSourceDelegate

- (void)source:(XXXRunLoopInputSource*)source command:(NSInteger)command {
    NSLog(@"command =%ld ",command);
}

@end
