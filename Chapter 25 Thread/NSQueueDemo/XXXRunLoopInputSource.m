//
//  XXXRunLoopInputSource.m
//  NSQueueDemo
//
//  Created by zhaojw on 1/25/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//

#import "AppDelegate.h"
#import "XXXRunLoopInputSource.h"

void RunLoopSourceScheduleRoutine (void *info, CFRunLoopRef rl, CFStringRef mode)
{
    XXXRunLoopInputSource* obj = (__bridge XXXRunLoopInputSource *)info;
    AppDelegate*   del = [AppDelegate sharedAppDelegate];
    XXXRunLoopContext* theContext = [[XXXRunLoopContext alloc] initWithSource:obj
                                                                      runLoop:rl];
    [del performSelectorOnMainThread:@selector(registerSource:)
                          withObject:theContext waitUntilDone:NO];
}

void RunLoopSourcePerformRoutine (void *info)
{
    XXXRunLoopInputSource*  obj = (__bridge XXXRunLoopInputSource*)info;
    [obj sourceFired];
}


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
        CFRunLoopSourceContext
        context = {0, (__bridge void *)(self), NULL, NULL, NULL, NULL, NULL,
            &RunLoopSourceScheduleRoutine,
            RunLoopSourceCancelRoutine,
            RunLoopSourcePerformRoutine};
        _runLoopSource = CFRunLoopSourceCreate(NULL, 0, &context);
        _commands = [[NSMutableArray alloc] init];
    }
   
    return self;
}

- (void)addToCurrentRunLoop {
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    CFRunLoopAddSource(runLoop, _runLoopSource, kCFRunLoopDefaultMode);
}
- (void)invalidate {
    
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    CFRunLoopRemoveSource(runLoop, _runLoopSource, kCFRunLoopDefaultMode);
}
// Handler method
- (void)sourceFired {
    
    
}
// Client interface for registering commands to process
- (void)addCommand:(NSInteger)command withData:(id)data {
    
    
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
        _runLoopInputSource = runLoopInputSource;
        _runLoop = runLoop;
    }
    return self;
}

@end


