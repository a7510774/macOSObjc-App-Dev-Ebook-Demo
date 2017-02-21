//
//  WorkThread.h
//  NSQueueDemo
//
//  Created by zhaojw on 1/21/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorkThread : NSThread
- (instancetype)initWithImageURL:(NSURL*)url;
@end
