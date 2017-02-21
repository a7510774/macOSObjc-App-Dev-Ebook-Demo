//
//  AppDelegate.h
//  NSQueueDemo
//
//  Created by zhaojw on 1/11/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "XXXRunLoopInputSource.h"
@interface AppDelegate : NSObject <NSApplicationDelegate>

+ (AppDelegate*)sharedAppDelegate;

@end



@interface AppDelegate (RunLoop)

- (void)registerSource:(XXXRunLoopContext *)sourceContext;

- (void)removeSource:(XXXRunLoopContext *)sourceContext;

- (void)testInputSourceEvent;


@end
