//
//  AppDelegate.m
//  RunLoopSourceDemo
//
//  Created by zhaojw on 1/25/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//

#import "AppDelegate.h"
#import "XXXRunLoopInputSourceThread.h"
@interface AppDelegate (){
    
}
@property(nonatomic,strong)NSMutableArray *sources;
@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    [self startInputSourceRunLoopThread];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (void)startInputSourceRunLoopThread
{
    XXXRunLoopInputSourceThread *thread = [[XXXRunLoopInputSourceThread alloc] init];
    [thread start];
}


- (IBAction)fireInputSource:(id)sender {
    [self simulateInputSourceEvent];
}

+ (AppDelegate*)sharedAppDelegate {
    
    return [NSApplication sharedApplication].delegate;
}
@end


@implementation AppDelegate (RunLoop)

- (void)registerSource:(XXXRunLoopContext *)sourceContext
{
    if (!self.sources) {
        self.sources = [NSMutableArray array];
    }
    [self.sources addObject:sourceContext];
}

- (void)removeSource:(XXXRunLoopContext *)sourceContext
{
    [self.sources enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        XXXRunLoopContext *context = obj;
        if ([context isEqual:sourceContext]) {
            [self.sources removeObject:context];
            *stop = YES;
        }
    }];
}

- (void)simulateInputSourceEvent
{
    XXXRunLoopContext *runLoopContext = [self.sources objectAtIndex:0];
    XXXRunLoopInputSource *inputSource = runLoopContext.source;
    NSInteger command = random() % 100;
    [inputSource addCommand:command withData:nil];
    [inputSource fireAllCommandsOnRunLoop:runLoopContext.runLoop];
}

@end

