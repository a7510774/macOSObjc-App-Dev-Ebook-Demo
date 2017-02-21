//
//  HTTPImageOperation.m
//  NSQueueDemo
//
//  Created by zhaojw on 1/17/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//

#import "HTTPImageOperation.h"

@interface HTTPImageOperation () {
    BOOL        executing;
    BOOL        finished;
}
@property(nonatomic,strong)NSURL *url;
@end

@implementation HTTPImageOperation

- (instancetype)initWithImageURL:(NSURL*)url {
    self = [super init];
    if(self) {
        _url = url;
    }
    return self;
}
//表示是否允许并发执行
- (BOOL)isAsynchronous {
    return YES;
}

- (BOOL)isExecuting {
    return executing;
}

- (BOOL)isFinished {
    return finished;
}

- (void)start {
    if([self isCancelled]){
        [self willChangeValueForKey:@"isFinished"];
        finished = YES;
        [self didChangeValueForKey:@"isFinished"];
        return;
    }

    [self willChangeValueForKey:@"isExecuting"];
    [NSThread detachNewThreadSelector:@selector(main) toTarget:self withObject:nil];
    executing = YES;
    [self didChangeValueForKey:@"isExecuting"];
}

- (void)main {
    @try {
        NSImage *image = [[NSImage alloc]initWithContentsOfURL:self.url];
        if(self.downCompletionBlock){
            self.downCompletionBlock(image);
        }
        [self completeOperation];
    }
    @catch(...) {
       [self completeOperation];
    }
}
- (void)completeOperation {
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    executing = NO;
    finished = YES;
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

@end
