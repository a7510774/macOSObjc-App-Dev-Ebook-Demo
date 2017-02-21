//
//  AppDelegate.m
//  NSQueueDemo
//
//  Created by zhaojw on 1/11/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//

#import "AppDelegate.h"
#import <Foundation/Foundation.h>
#import "HTTPImageOperation.h"
#import "RunLoopThread.h"
#import "PortWorker.h"
#import "WorkThread.h"
#define kCheckinMessage 100
#import "HTTPConfig.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "NSConditionTest.h"
#import "NSConditionLockTest.h"

static NSString *CustomRunLoopMode = @"CustomRunLoopMode";

@interface AppDelegate ()
{
    NSThread *th;
    BOOL exitThread;
    WorkThread *wt;
     CFRunLoopObserverRef observer;
    
    HTTPConfig *httpConfig;
    
    NSMutableArray *threads;
    
    
    NSConditionTest *conditionTest;
    
    NSConditionLockTest  *conditionLockTest;
    
    
    NSRunLoop    *q789;
    
    NSMutableArray *sources;
    
}
@property (weak) IBOutlet NSImageView *leftImageView;
@property (weak) IBOutlet NSImageView *rightImageView;

@property (weak) IBOutlet NSWindow *window;

@property (strong,nonatomic)  RunLoopThread *thread;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    
    
    
   NSLog(@"currentThread %@", [NSThread currentThread]);
    
    NSString *aPath = [[NSBundle mainBundle]pathForResource:@"AppWWDCDown" ofType:@"sqlite"];
   
    FMDatabaseQueue *dbqueue = [FMDatabaseQueue databaseQueueWithPath:aPath];
  
    
    
    [dbqueue inDatabase:^(FMDatabase *db) {
        
        FMResultSet *rs = [db executeQuery:@"select * from Track"];
        while ([rs next]) {
            NSLog(@"%@",[rs resultDictionary]);
        }
    }];
    
    
    NSThread *t = [NSThread currentThread];
    
    NSDictionary *tattribute = [t threadDictionary];
    
    
    conditionTest = [[NSConditionTest alloc]init];
    
//    [conditionTest doWork];
//    [conditionTest clearCondition];
//    [conditionTest doWork];
    
    
    conditionLockTest = [[NSConditionLockTest alloc]init];
  //  [conditionLockTest doWork];
    //[self startThread];
    
//    dispatch_queue_t queue = dispatch_queue_create("com.yourdomain.TestQueue", NULL);
//    
//    dispatch_async(queue, ^{
//        NSLog(@"Do some tasks!");
//    });
//    
//    NSLog(@"The tasks may or may not have run");
//    
//    
//    dispatch_sync(queue, ^{
//        NSLog(@"Do some work 1 here");
//    });
//    
//    dispatch_sync(queue, ^{
//        NSLog(@"Do some work 2 here");
//    });
//    
//    NSLog(@"All  works have completed.\n");
    
    
//    [self semaphore];
//    
//    
//    [self group];
//    
//    [self dispatchAfter];
//    
//    [self dispatchBarrier];
    
   // [self blockQueue];
//    
//    [self invocationOperationTest];
    
//    [self addDependcy];
    
      //[self queuePriority];
    
      //[self opreationQueue];
    
    //  [self detachThreadTest];
    
   
  //  [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(run2) userInfo:@"ya了个hoo" repeats:YES];
    
//    
//    self.thread = [[RunLoopThread alloc]init];
//    [self.thread start];
    
    
   // [self startThread22];
    
    
   // wt = [[WorkThread alloc]init];
    //[wt start];
 
    //httpConfig = [HTTPConfig sharedInstance];
    
    
    CFRunLoopObserverContext context = {0,(__bridge void*)self,NULL,NULL};
    observer = CFRunLoopObserverCreate(kCFAllocatorDefault,
                                       kCFRunLoopAllActivities,
                                       YES,
                                       0,
                                       &runLoopObserverCallBack,
                                       &context);
    CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopCommonModes);
    
    //[self test_NSConditionLock_action];
    
    return;
    
    for(int i=0;i<40;i++){
        NSThread *t = [[NSThread alloc]init];
        t.name = [NSString stringWithFormat:@"t %d",i];
        [threads addObject:t];
    }
    
     for(int i=0;i<40;i++){
         NSThread *t  = threads[i];
         [self performSelector:@selector(testHttpConfig) onThread:t withObject:nil waitUntilDone:NO ];
         [t start];
     }
    
    
     dispatch_queue_t cuqueue = dispatch_queue_create("com.yourdomain.TestQueue22", DISPATCH_QUEUE_CONCURRENT);
    
   
   
    
//    for(int i=0;i<200;i++){
//        
//        dispatch_sync(cuqueue, ^{
//            [self testHttpConfig:i];
//            
//        });
//    }

    
  //  [self testQ];
    
    
  
    
}


- (void)testHttpConfig:(int)i {
    
    NSLog(@"testHttpConfig start");
    
    NSString *domain = [httpConfig domain];
    NSLog(@"read domain %@",domain);
    //NSInteger i =  rand();
    
    [httpConfig setDomain:[NSString stringWithFormat:@"domain_%d",i]];
    NSLog(@"set domain %@",[httpConfig domain]);
}

- (void)test_NSConditionLock_action{
    printf("\n\n");
    NSLog(@"test_NSConditionLock_action\n");
    NSConditionLock* lock = [[NSConditionLock alloc]initWithCondition:1];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [lock lockWhenCondition:1];
        NSLog(@"condition_ lock1");
        [lock unlock];
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [lock lockWhenCondition:2];
        NSLog(@"condition_ lock2");
        [lock unlock];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for(int i = -1; i<=2; i++){
            [lock lock];
            NSLog(@"condition_:%i",i);
            [lock unlockWithCondition:i];
        }
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [lock lockWhenCondition:2];
        NSLog(@"condition_ lock3");
        [lock unlock];
        
    });
    
}


static void runLoopObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info)
{
    
    
    NSRunLoop *loop = [NSRunLoop currentRunLoop];
    
    NSLog(@"mode %@ activity %ld",[loop currentMode],activity);
    
}


- (void)startThread22
{
    th = [[NSThread alloc] initWithTarget:self selector:@selector(testMethod) object:nil];
    [th start];
}

- (void)testMethod {
    
    NSLog(@"Thread Entered");
    
    NSMachPort* dummyPort = [[NSMachPort alloc] init];
    [[NSRunLoop currentRunLoop] addPort:dummyPort forMode:NSDefaultRunLoopMode];
    
    while(!exitThread) {
        NSLog(@"Thread did some work");
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    [[NSRunLoop currentRunLoop]
     removePort:dummyPort
     forMode:NSDefaultRunLoopMode];

    
    NSLog(@"Thread Exited");
   
}

- (IBAction)doDomeWorkOnBackgroundThread:(id)sender {
    [self performSelector:@selector(dummyMethod) onThread:th withObject:nil waitUntilDone:NO];
}

- (IBAction)exitThread:(id)sender {
    [self performSelector:@selector(exitBackgroundThread) onThread:th withObject:nil waitUntilDone:NO];
}

- (void)exitBackgroundThread {
    exitThread = YES;
}

- (void)dummyMethod {
     NSLog(@"Thread dummyMethod!");
}


- (void)machPort {
    
}
- (void)launchThread
{
    NSPort* myPort = [NSMachPort port];
    if (myPort)
    {
        // This class handles incoming port messages.
        [myPort setDelegate:self];
        // Install the port as an input source on the current run loop.
        [[NSRunLoop currentRunLoop] addPort:myPort forMode:NSDefaultRunLoopMode];
        // Detach the thread. Let the worker release the port.
        [NSThread detachNewThreadSelector:@selector(LaunchThreadWithPort:) toTarget:[PortWorker class] withObject:myPort];
    }
}


- (void)handlePortMessage:(NSPortMessage *)portMessage
{
    unsigned int message = [portMessage msgid];
    NSPort* distantPort = nil;
    if (message == kCheckinMessage)
    {
        // Get the worker thread’s communications port.
        distantPort = [portMessage sendPort];
        // Retain and save the worker port for later use.
        //[self storeDistantPort:distantPort];
    }
    else {
        // Handle other messages.
    }
}

- (void)run2{
    
    NSLog(@"timer2");
    
}

- (void)semaphore {
    
   
    dispatch_semaphore_t fd_sema = dispatch_semaphore_create(10);

    dispatch_semaphore_wait(fd_sema, DISPATCH_TIME_FOREVER);
   
    int fd = open("/Users/test/file.data", O_RDONLY);

    close(fd);
    
    dispatch_semaphore_signal(fd_sema);
    
}
- (void)group {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, queue, ^{
         NSLog(@"Do some work 1 here");
    });
    
    dispatch_group_async(group, queue, ^{
         NSLog(@"Do some work 2 here");
    });
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@"group complete");
    });
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    
    NSLog(@"Do some other works!");
   
    
}

- (void)dispatchAfter {
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), queue, ^{
        NSLog(@"after 0.5s timeout , Do some other works!");
    });
    
}

- (void)dispatchBarrier {
    
    dispatch_queue_t queue = dispatch_queue_create("com.yourdomain.TestQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"Do some work 1 here");
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:1];
         NSLog(@"Do some work 2 here");
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"Do some work 3 here");
    });
    dispatch_barrier_async(queue, ^{
        [NSThread sleepForTimeInterval:1];
         NSLog(@"Do some work 4 here");
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"Do some work 5 here");
    });
    
}

- (void)blockQueue {
    NSOperationQueue *aQueue = [[NSOperationQueue alloc] init];
    NSBlockOperation * opt = [[NSBlockOperation alloc] init];
    
    [opt addExecutionBlock:^{
        NSLog(@"Run in block 1 ");
    }];
    [opt addExecutionBlock:^{
        NSLog(@"Run in block 2 " );
    }];
    [opt addExecutionBlock:^{
        NSLog(@"Run in block 3 " );
    }];
    [opt addExecutionBlock:^{
        NSLog(@"Run in block 4 " );
    }];
    [[NSOperationQueue currentQueue]addOperation:opt];
    //[aQueue addOperation:opt];
    
    opt.completionBlock = ^{
        NSLog(@"Run completion " );
    };
    
}

- (void)invocationOperationTest {
   
    NSOperationQueue *aQueue = [[NSOperationQueue alloc] init];
    NSString *data = @"invocation paras";
    NSInvocationOperation* theOp = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(doWork:) object:data];
    [aQueue addOperation:theOp];
}


- (void)doWork:(NSString*)data {
    NSLog(@"doWork show data %@ ",data );
}

- (void)addDependcy {
    
    NSOperationQueue *aQueue = [[NSOperationQueue alloc] init];
    

    
    NSBlockOperation * opt1 = [[NSBlockOperation alloc] init];
    
   
    
    [opt1 addExecutionBlock:^{
        NSLog(@"Run in block 1 ");
    }];
    
    NSBlockOperation * opt2 = [[NSBlockOperation alloc] init];
    
    [opt2 addExecutionBlock:^{
        NSLog(@"Run in block 2 ");
    }];
    
    [opt2 addDependency:opt1];
    
    [aQueue addOperation:opt1];
    [aQueue addOperation:opt2];
    
    
}

- (void)queuePriority {
    
    NSOperationQueue *aQueue = [[NSOperationQueue alloc] init];
    
    NSBlockOperation * opt1 = [[NSBlockOperation alloc] init];
    
    [opt1 addExecutionBlock:^{
        NSLog(@"Run in block 1 ");
    }];
    
    NSBlockOperation * opt2 = [[NSBlockOperation alloc] init];
    
    [opt2 addExecutionBlock:^{
       NSLog(@"Run in block 2 ");
    }];
    
    
    NSBlockOperation * opt3 = [[NSBlockOperation alloc] init];
    opt3.queuePriority = NSOperationQueuePriorityVeryHigh;
    
    [opt3 addExecutionBlock:^{
        NSLog(@"Run in block 3 ");
    }];
    
    
    [aQueue addOperations:@[opt1,opt2,opt3]  waitUntilFinished:NO];
  

}

- (void)opreationQueue {
    
    NSURL *url1 = [NSURL URLWithString:@"http://www.jobbole.com/wp-content/uploads/2016/01/75c6c64ae288896908d2c0dcd16f8d65.jpg"];
    
    HTTPImageOperation *op1 = [[HTTPImageOperation alloc]initWithImageURL:url1];
    
    op1.downCompletionBlock = ^(NSImage *image){
        self.leftImageView.image = image;
    };
    
    NSURL *url2 = [NSURL URLWithString:@"http://ww1.sinaimg.cn/mw690/bfdcef89gw1exedm1rzkpj20j602d757.jpg"];
    
    HTTPImageOperation *op2 = [[HTTPImageOperation alloc]initWithImageURL:url2];
    
    op2.downCompletionBlock = ^(NSImage *image){
        self.rightImageView.image = image;
    };
    
    
    [[NSOperationQueue mainQueue] addOperation:op1];
    [[NSOperationQueue mainQueue] addOperation:op2];
}

- (void)detachThreadTest {
    
    //[NSThread detachNewThreadSelector:@selector(launchMain) toTarget:self withObject:nil];
    
    //[self performSelectorInBackground:@selector(launchMain) withObject:nil];
    
    [self performSelector:@selector(launchMain) withObject:nil];
}

- (void)launchMain {
    
    NSLog(@"is main %d", [NSThread currentThread].isMainThread );
    
}

- (void)threadMainRoutine
{
    BOOL moreWorkToDo = YES;
    BOOL exitNow = NO;
    NSRunLoop* runLoop = [NSRunLoop currentRunLoop];
    // Add the exitNow BOOL to the thread dictionary.
    NSMutableDictionary* threadDict = [[NSThread currentThread] threadDictionary];
    [threadDict setValue:[NSNumber numberWithBool:exitNow]
                  forKey:@"ThreadShouldExitNow"];
    
  
    //[self myInstallCustomInputSource];
    while (moreWorkToDo && !exitNow)
    {
        // Do one chunk of a larger body of work here.
        // Change the value of the moreWorkToDo Boolean when done.
        // Run the run loop but timeout immediately if the input source isn't
    
        [runLoop runUntilDate:[NSDate date]];
        // Check to see if an input source handler changed the exitNow value.
        exitNow = [[threadDict valueForKey:@"ThreadShouldExitNow"] boolValue];
    }
}


//- (void)suspendQueue {
//    if (queue) {
//        dispatch_suspend(queue);
//    }
//}
//
//- (void)resumeQueue {
//    if (queue) {
//        dispatch_resume(queue);
//    }
//}

- (void)dispatchBarrier2 {
    
    dispatch_queue_t queue = dispatch_queue_create("com.yourdomain.TestQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        NSLog(@"Do some work 1 here");
    });
    dispatch_async(queue, ^{
        NSLog(@"Do some work 2 here");
    });
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"Do some work 4 here");
    });
    
}


- (void)startThread2 {
  //  NSThread *thread = [[NSThread alloc] init];
  //  [thread start];
    
    NSThread *runLoopThread = [[NSThread alloc] initWithTarget:self selector:@selector(doTaskOnSubThread) object:nil];
    [runLoopThread start];
    
   // [self performSelector:@selector(doTaskOnSubThread) onThread:thread withObject:nil waitUntilDone:NO];
    
}

- (void)startThread {
    
    NSThread *thread = [[NSThread alloc] init];
    [thread start];
    
 
    [self performSelector:@selector(doTaskOnSubThread) onThread:thread withObject:nil waitUntilDone:NO modes:@[NSDefaultRunLoopMode]];
    
    
    while (YES) {
        
        NSLog(@"Begin RunLoop");
        
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        
        NSLog(@"End RunLoop");
    }
    
    
}

- (void)doTaskOnSubThread
{
    NSLog(@"======= do task on sub thread");
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
