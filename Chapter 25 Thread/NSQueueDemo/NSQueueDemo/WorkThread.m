//
//  WorkThread.m
//  NSQueueDemo
//
//  Created by zhaojw on 1/21/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "WorkThread.h"

@interface WorkThread ()
@property(nonatomic,strong)NSURL *url;
@end

@implementation WorkThread
- (instancetype)initWithImageURL:(NSURL*)url {
    self = [super init];
    if(self){
        _url = url;
    }
    return self;
}
- (void)main {
    NSLog(@"WorkThread main");
    @autoreleasepool {
        NSImage *image = [[NSImage alloc]initWithContentsOfURL:_url];
        //Do some other image process work 
    }
}


@end
