//
//  XXXRunLoopInputSource.h
//  NSQueueDemo
//
//  Created by zhaojw on 1/25/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXXRunLoopInputSource : NSObject

{
    CFRunLoopSourceRef _runLoopSource;
    NSMutableArray* _commands;
}

- (void)addToCurrentRunLoop;
- (void)invalidate;
// Handler method
- (void)sourceFired;
// Client interface for registering commands to process
- (void)addCommand:(NSInteger)command withData:(id)data;
- (void)fireAllCommandsOnRunLoop:(CFRunLoopRef)runloop;

@end




@interface XXXRunLoopContext : NSObject
{
    CFRunLoopRef                  _runLoop;
    XXXRunLoopInputSource*        _runLoopInputSource;
}
@property (readonly) CFRunLoopRef runLoop;
@property (readonly) XXXRunLoopInputSource* source;
- (instancetype)initWithSource:(XXXRunLoopInputSource *)runLoopInputSource runLoop:(CFRunLoopRef)runLoop;
@end

