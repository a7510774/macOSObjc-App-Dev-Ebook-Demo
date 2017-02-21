//
//  AppDelegate.m
//  NSURLNetworkDemoForIOS
//
//  Created by zhaojw on 2/20/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
@property(nonatomic,strong)NSMutableDictionary   *completionHandlerDictionary;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self createBackgroundURLSession];
    
    return YES;
}


- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier
  completionHandler:(void (^)())completionHandler {

    
    if(!self.completionHandlerDictionary){
        self.completionHandlerDictionary = [NSMutableDictionary dictionary];
    }
    self.completionHandlerDictionary[identifier] = completionHandler;
}


-(void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session {

    NSLog(@"Background URL session %@ finished events.\n", session);
    NSString *identifier = session.configuration.identifier;
    void (^handler)()   = [self.completionHandlerDictionary objectForKey: identifier];
    if (handler) {
        [self.completionHandlerDictionary removeObjectForKey: identifier];
        NSLog(@"Calling completion handler.\n");
        handler();
    }
    
}

- (void)createBackgroundURLSession {
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration
                                                      backgroundSessionConfigurationWithIdentifier:@"backgroundDownID"];
    
    __weak id safeSelf = self;
    NSURLSession *session  = [NSURLSession sessionWithConfiguration:
                              defaultConfigObject delegate: safeSelf delegateQueue: [NSOperationQueue mainQueue]];
    NSURL *url = [NSURL URLWithString:
                  @"https://www.gitbook.com/download/pdf/book/frontendmasters/front-end-handbook"];
    NSURLSessionDownloadTask *task =  [session downloadTaskWithURL:url];
    
    [task resume];
}


#pragma mark- NSURLSessionDownloadDelegate

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location {
    
    NSError *err = nil;
    //获取原始的文件名
    NSString *fileName = [[downloadTask.originalRequest.URL absoluteString]lastPathComponent];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *downloadDir = [[NSHomeDirectory()
                              stringByAppendingPathComponent:@"Downloads"] stringByAppendingPathComponent:fileName];
    //要保存的路径
    NSURL *downloadURL = [NSURL fileURLWithPath:downloadDir];
    //从下载的临时路径移动到期望的路径
    if ([fileManager moveItemAtURL:location
                             toURL:downloadURL
                             error: &err]) {
    } else {
        NSLog(@"err %@ ",err);
    }
}



- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    
    NSLog(@"Session %@ download task %@ wrote an additional %lld bytes (total %lld bytes) out of an expected %lld bytes.\n",
          session, downloadTask, bytesWritten, totalBytesWritten,
          totalBytesExpectedToWrite);
}



- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes {
    
    NSLog(@"Session %@ download task %@ resumed at offset %lld bytes out of an expected %lld bytes.\n",
          session, downloadTask, fileOffset, expectedTotalBytes);
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
