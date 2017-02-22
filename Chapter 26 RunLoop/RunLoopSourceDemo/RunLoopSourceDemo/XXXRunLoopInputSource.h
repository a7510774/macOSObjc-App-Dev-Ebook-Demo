//
//  XXXRunLoopInputSource.h
//  NSQueueDemo
//
//  Created by zhaojw on 1/25/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XXXRunLoopInputSource;
@protocol XXXRunLoopInputSourceDelegate <NSObject>
@optional
- (void)source:(XXXRunLoopInputSource*)source command:(NSInteger)command;
@end

@interface XXXRunLoopInputSource : NSObject
{
    CFRunLoopSourceRef _runLoopSource;
    NSMutableArray*    _commands;
}

@property(weak) id <XXXRunLoopInputSourceDelegate> delegate;

//增加source到runloop
- (void)addToCurrentRunLoop;
//删除source
- (void)invalidate;
//接收到source事件
- (void)sourceFired;
//提供给外部的command操作接口
- (void)addCommand:(NSInteger)command withData:(id)data;
//command唤醒runloop
- (void)fireAllCommandsOnRunLoop:(CFRunLoopRef)runloop;
@end

//source 和 runloop关联的上下文对象
@interface XXXRunLoopContext : NSObject

@property (nonatomic,assign) CFRunLoopRef runLoop;
@property (nonatomic,strong) XXXRunLoopInputSource* source;
- (instancetype)initWithSource:(XXXRunLoopInputSource *)runLoopInputSource runLoop:(CFRunLoopRef)runLoop;
@end

