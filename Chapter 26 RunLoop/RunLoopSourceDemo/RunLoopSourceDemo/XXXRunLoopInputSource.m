//
//  XXXRunLoopInputSource.m
//  NSQueueDemo
//
//  Created by zhaojw on 1/25/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//

#import "AppDelegate.h"
#import "XXXRunLoopInputSource.h"
//注册source的回调
void RunLoopSourceScheduleRoutine (void *info, CFRunLoopRef rl, CFStringRef mode)
{
    XXXRunLoopInputSource* obj = (__bridge XXXRunLoopInputSource *)info;
    AppDelegate*   del = [AppDelegate sharedAppDelegate];
    XXXRunLoopContext* theContext = [[XXXRunLoopContext alloc] initWithSource:obj  runLoop:rl];
    [del performSelectorOnMainThread:@selector(registerSource:)
                          withObject:theContext waitUntilDone:NO];
}
//source唤醒runloop后的回调
void RunLoopSourcePerformRoutine (void *info)
{
    XXXRunLoopInputSource* obj = (__bridge XXXRunLoopInputSource*)info;
    [obj sourceFired];
}

//删除source回调
void RunLoopSourceCancelRoutine (void *info, CFRunLoopRef rl, CFStringRef mode)
{
    XXXRunLoopInputSource* obj = (__bridge XXXRunLoopInputSource*)info;
    AppDelegate* del = [AppDelegate sharedAppDelegate];
    XXXRunLoopContext* theContext = [[XXXRunLoopContext alloc] initWithSource:obj
                                                                      runLoop:rl];
    [del performSelectorOnMainThread:@selector(removeSource:)
                          withObject:theContext waitUntilDone:YES];
}

@implementation XXXRunLoopInputSource

- (id)init
{
    self = [super init];
    if(self) {
        //初始化source上下文，注册3个回调函数
        CFRunLoopSourceContext
        context = {0, (__bridge void *)(self), NULL, NULL, NULL, NULL, NULL,
            &RunLoopSourceScheduleRoutine,
            RunLoopSourceCancelRoutine,
            RunLoopSourcePerformRoutine};
        //创建source
        _runLoopSource = CFRunLoopSourceCreate(NULL, 0, &context);
        _commands = [[NSMutableArray alloc] init];
    }
   
    return self;
}

- (void)addToCurrentRunLoop {
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    //source加入到runloop 并且设置为缺省Mode
    CFRunLoopAddSource(runLoop, _runLoopSource, kCFRunLoopDefaultMode);
}

- (void)invalidate {
    
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    CFRunLoopRemoveSource(runLoop, _runLoopSource, kCFRunLoopDefaultMode);
}

- (void)sourceFired {
    NSLog(@"sourceFired");
    if ([self.delegate respondsToSelector:@selector(source:command:)]) {
        if([_commands count]>0){
            NSInteger command = [_commands[0] integerValue];
            [self.delegate source:self command:command];
            [_commands removeLastObject];
        }
    }
}

- (void)addCommand:(NSInteger)command withData:(id)data {
    [_commands addObject:@(command)];
}

- (void)fireAllCommandsOnRunLoop:(CFRunLoopRef)runloop {
    CFRunLoopSourceSignal(_runLoopSource);
    CFRunLoopWakeUp(runloop);
}
@end

@implementation XXXRunLoopContext

- (instancetype)initWithSource:(XXXRunLoopInputSource *)runLoopInputSource runLoop:(CFRunLoopRef)runLoop
{
    self = [super init];
    if (self) {
        _source = runLoopInputSource;
        _runLoop = runLoop;
    }
    return self;
}

@end


