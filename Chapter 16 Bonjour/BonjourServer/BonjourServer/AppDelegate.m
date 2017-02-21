//
//  AppDelegate.m
//  BonjourServer
//
//  Created by zhaojw on 15/9/9.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import "AppDelegate.h"

#define kDomain @"local."
#define kServiceType @"_ProbeHttpService._tcp."

@interface AppDelegate ()<NSNetServiceDelegate>

@property (weak) IBOutlet NSWindow *window;
@property(nonatomic,strong)NSNetService *netService;
@property(nonatomic,strong) NSThread *netServiceThread;
@property(nonatomic,assign)BOOL onMainThread;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    self.netService = [[NSNetService alloc] initWithDomain:kDomain type:kServiceType  name:@"dfgdgdg" port:8888];
    
    self.netService.delegate = self;
    
    NSData *txtRecordData = [self txtRecordData];
    
    if(self.onMainThread){
        [self.netService scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        
        [self.netService publish];
        
        if (txtRecordData)
        {
            [self.netService setTXTRecordData:txtRecordData];
        }
    
    }
    else{
        self.netServiceThread = [[NSThread alloc] initWithTarget:self
                                                        selector:@selector(startAsync:)
                                                          object:self.netService];
        [self.netServiceThread start];
   }
}

- (NSData*)txtRecordData
{
    NSDictionary  *txtRecordDictionary = @{@"user":@"myme"};
    
    if (txtRecordDictionary)
    {
        return [NSNetService dataFromTXTRecordDictionary:txtRecordDictionary];
    }
    
    return nil;
}

- (void)startAsync:(NSNetService *)netService {
    assert(!self.onMainThread);
    NSLog(@"%d",self.onMainThread);
    @autoreleasepool {
        [[NSRunLoop currentRunLoop] run];
        [self.netService scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        [self.netService publish];
        
        NSData *txtRecordData = [self txtRecordData];
        
        if (txtRecordData)
        {
            [self.netService setTXTRecordData:txtRecordData];
        }
    }
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

#pragma mark--NSNetServiceDelegate

- (void)netServiceWillPublish:(NSNetService *)sender
{
    NSLog(@"netServiceWillPublish OK!");
}

- (void)netServiceDidPublish:(NSNetService *)sender
{
    NSLog(@"netServiceDidPublish OK!");
}

- (void)netService:(NSNetService *)sender didNotPublish:(NSDictionary *)errorDict;
{
    
    NSLog(@"didNotPublish error %@",errorDict);
}

- (BOOL)onMainThread {
    return [[NSThread currentThread] isMainThread];
}

@end
