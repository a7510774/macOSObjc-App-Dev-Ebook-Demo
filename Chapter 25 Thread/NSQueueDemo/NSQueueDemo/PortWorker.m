//
//  PortWorker.m
//  NSQueueDemo
//
//  Created by zhaojw on 1/20/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//

#import "PortWorker.h"

@implementation PortWorker

+(void)LaunchThreadWithPort:(id)inData
{
    NSPort* distantPort = (NSPort*)inData;
    PortWorker*  workerObj = [[self alloc] init];
    [workerObj sendCheckinMessage:distantPort];
   
    // Let the run loop process things.
    do
    {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate distantFuture]];
    }
     while (1);
    //while (![workerObj shouldExit]);
    
}


- (void)sendCheckinMessage:(NSPort*)outPort
{
    // Retain and save the remote port for future use.
    //[self setRemotePort:outPort];
    // Create and configure the worker thread port.
    NSPort* myPort = [NSMachPort port];
    [myPort setDelegate:self];
    [[NSRunLoop currentRunLoop] addPort:myPort forMode:NSDefaultRunLoopMode];
    // Create the check-in message.
    NSPortMessage* messageObj = [[NSPortMessage alloc] initWithSendPort:outPort
                                                            receivePort:myPort components:nil];
    if (messageObj)
    {
        // Finish configuring the message and send it immediately.
       // [messageObj setMsgId:setMsgid:kCheckinMessage];
        [messageObj sendBeforeDate:[NSDate date]];
    }
}

@end
