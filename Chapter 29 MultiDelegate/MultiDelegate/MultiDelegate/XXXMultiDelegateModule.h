//
//  XXXMultiDelegateModule.h
//  MultiDelegate
//
//  Created by zhaojw on 10/5/15.
//  Copyright © 2015 zhaojw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXXMultiDelegateModule : NSObject
{

    dispatch_queue_t moduleQueue;
    
    void *moduleQueueTag;
    
    id multicastDelegate;
}

@property (readonly) dispatch_queue_t moduleQueue;
@property (readonly) void *moduleQueueTag;



- (id)init;
- (id)initWithDispatchQueue:(dispatch_queue_t)queue;

- (void)addDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue;
- (void)removeDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue;

- (void)removeDelegate:(id)delegate;

- (NSString *)moduleName;

@end
