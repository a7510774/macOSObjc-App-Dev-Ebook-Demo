//
//  HTTPImageOperation.h
//  NSQueueDemo
//
//  Created by zhaojw on 1/17/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
@interface HTTPImageOperation : NSOperation
- (instancetype)initWithImageURL:(NSURL*)url;
@property (nonatomic, copy) void (^downCompletionBlock)(NSImage *image);
@end
