//
//  HTTPConfig.m
//  NSQueueDemo
//
//  Created by zhaojw on 1/22/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//

#import "HTTPConfig.h"

static const void * const kHTTPQueueSpecificKey = &kHTTPQueueSpecificKey;

@interface HTTPConfig ()
{
    
    NSString *_domain;
    NSString *interface;
    
    dispatch_queue_t serverQueue;
    
}
@end
@implementation HTTPConfig

- (instancetype)init {
    self = [super init];
    if(self) {
        serverQueue = dispatch_queue_create("com.uu.queue", NULL);
        dispatch_queue_set_specific(serverQueue, kHTTPQueueSpecificKey, (__bridge void *)self, NULL);
    }
    return self;
}

+ (instancetype)sharedInstance {
    static HTTPConfig *instance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        instance = [[self alloc] init];
        
    });
    return instance;
}


- (NSString*)domain {
    return _domain;
}

- (void)setDomain:(NSString*)domain {
    _domain = domain;
}

-(NSString *)interface {
    id currentObj = (__bridge id)dispatch_get_specific(kHTTPQueueSpecificKey);
    if(currentObj){
        return interface;
    }
    //定义临时变量 增加引用计数 防止对象被释放
    __block NSString *result;
    dispatch_sync(serverQueue, ^{
        result = interface;
    });
    return result;
}

-(void)setInterface:(NSString *)value {
    NSString *valueCopy = [value copy];
    dispatch_async(serverQueue, ^{
        interface = valueCopy;
    });
}



@end
