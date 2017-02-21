//
//  AppDelegate.m
//  NSURLNetworkDemo
//
//  Created by zhaojw on 1/28/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//

#import "AppDelegate.h"
#import "Aspects.h"

#import <Foundation/NSFileHandle.h>

#define   kServerBasePrdUrl           @"http://www.iosxhelper.com/SAPI"
#define   kServerBaseTestUrl          @"http://127.0.0.1/iosxhelper/SAPI"

NSString  *kServerBaseUrl = kServerBaseTestUrl;

@interface AppDelegate ()<NSURLSessionDelegate,NSURLSessionDataDelegate,NSURLSessionDownloadDelegate>

@property (weak) IBOutlet NSWindow *window;

@property (nonatomic,strong ) NSMutableData              *data;
@property (nonatomic,strong ) NSString                   *tempPath;
@property (nonatomic,assign) NSInteger totalLength;//文件的总大小
@property (nonatomic,assign) NSInteger currentLength;//已接收文件数据的大小
@property (nonatomic,strong ) NSData                           *resumeData;
@property (nonatomic,strong ) NSURLSessionDownloadTask         *downTask;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    NSURLDownload     *down;
    
    NSURLSession      *dgdf;
    
    NSURLConnection   *cn;
    
    
    NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:2 * 1024 * 1024 diskCapacity:10 * 1024 * 1024 diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];
    
     NSLog(@"URLCache  1 %@",URLCache);
    
    //[self urlSessionNoDelegateTest];
    
    
    //[self uploadPostTest];
    
    
    //[self urlConnectionTest];
    
    //[self startURLDownloadTest];
    
    
    //[self urlSessionDelegateTest];
    
    
     //[self urlSessionDownloadTest];
    
    //[self urlSessionUploadTest];
    
   // [self formUpload];
    
     [self sendAudio];
    
    //[self upload:nil];
    
   // [self formUpload2];
    
  NSFileHandle *handle = [NSFileHandle fileHandleForWritingAtPath:@""];
    
    
    
   
    [NSFileHandle   aspect_hookSelector:@selector(seekToFileOffset:) withOptions:0 usingBlock:^(id info, unsigned long long sender) {
        
       
        
        
        NSLog(@"Button was pressed by: %@", sender);
        
    } error:NULL];
    
    
    [NSFileHandle   aspect_hookSelector:@selector(fileHandleForWritingAtPath:) withOptions:0 usingBlock:^(id info, NSString *path) {
        
        
        
        
        NSLog(@"Button was pressed by: %@", path);
        
    } error:NULL];
    
    
    [NSFileHandle  aspect_hookSelector:@selector(writeData:) withOptions:0 usingBlock:^(id info, NSData *sender) {
        
        
        
        
        NSLog(@"Button was pressed by: %@", sender);
        
    } error:NULL];
    
    
    
}

- (IBAction)startDown:(id)sender {
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration
                                                      defaultSessionConfiguration];
    
    NSURLSession *session  = [NSURLSession sessionWithConfiguration:
                              defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL *url = [NSURL URLWithString:
                  @"http://devstreaming.apple.com/videos/wwdc/2015/105ncyldc6ofunvsgtan/105/105_hd_introducing_watchkit_for_watchos_2.mp4?dl=1"];
    
    url = [NSURL URLWithString:@"http://devstreaming.apple.com/videos/wwdc/2015/1026npwuy2crj2xyuq11/102/102_platforms_state_of_the_union.pdf?dl=1"];
    
    NSURLSessionDownloadTask *task =  [session downloadTaskWithURL:url];
    
    self.downTask = task;
    
    [task resume];

    
}

- (IBAction)stopDown:(id)sender {
    
    [self.downTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        
        if(resumeData){
            self.resumeData = resumeData;
        }
    
    }];
    
}

- (IBAction)resumeDown:(id)sender {
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration
                                                      defaultSessionConfiguration];
    
    
    NSURLSession *session  = [NSURLSession sessionWithConfiguration:
                              defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    
    self.downTask= [session downloadTaskWithResumeData:self.resumeData];
 
    [self.downTask resume];
    
}

-(void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
    
    [self.downTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        
        if(resumeData){
            self.resumeData = resumeData;
        }
        
    }];
    
}

#define   kServerBaseUrl          @"http://127.0.0.1/iosxhelper/SAPI"

- (void)urlSessionNoDelegateTest {
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration
                                                      defaultSessionConfiguration];
    NSURLSession *session  = [NSURLSession sessionWithConfiguration:
                                                                 defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSLog(@"URLCache2 %@",defaultConfigObject.URLCache);
    
    
    
    NSURLCache *URLCache2 = [[NSURLCache alloc] initWithMemoryCapacity:2 * 1024 * 1024 diskCapacity:10 * 1024 * 1024 diskPath:nil];
    
    defaultConfigObject.URLCache = URLCache2;
    
     NSLog(@"URLCache3 %@",defaultConfigObject.URLCache);
    
    NSLog(@"URLCache4 %@",[NSURLCache sharedURLCache]);
    
    
    NSURL *url = [NSURL
                  URLWithString:[NSString stringWithFormat:@"%@%@",kServerBaseUrl,@"/VersionCheck"]];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url
                                                         cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                     timeoutInterval:60.0];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    
    
     NSString *post  = [[NSString alloc] initWithFormat:@"versionNo=%@&platform=%@&channel=%@&appName=%@",@"1.0",@"Mac",@"appstore",@"DBAppX"];
    
   
    
    
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = postData;
    
    
    NSURLSessionTask *task =  [session dataTaskWithRequest:request
          completionHandler:^(NSData *data, NSURLResponse *response,
                    NSError *error) {
              NSString *responseStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
              NSLog(@"data =%@ =%@",responseStr,session.delegate);
              
              
              
          }
    ];
    [task resume];
}

- (void)uploadPostTest {
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration
                                                      defaultSessionConfiguration];
    NSURLSession *session  = [NSURLSession sessionWithConfiguration:
                              defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    NSURL *url = [NSURL
                  URLWithString:[NSString stringWithFormat:@"%@%@",kServerBaseUrl,@"/VersionCheck"]];
   
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    request.HTTPMethod = @"POST";
    
    //NSError *error;
    NSString *post  = [[NSString alloc] initWithFormat:@"versionNo=%@&platform=%@&channel=%@&appName=%@",@"1.0",@"Mac",@"appstore",@"DBAppX"];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
    if (1) {
        NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request
                                                                   fromData:postData completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
                                                                       
         NSString *responseStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
         NSLog(@"data =%@",responseStr);
                                                                       
         [session finishTasksAndInvalidate];
                                                                       
        }];
        [uploadTask resume];
    }
    
}


- (void)urlSessionDelegateTest {
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration
                                                      defaultSessionConfiguration];
    
    NSURLSession *session  = [NSURLSession sessionWithConfiguration:
                              defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL
                                                                      URLWithString:[NSString stringWithFormat:@"%@%@",kServerBaseUrl,@"/VersionCheck"]]
                                                         cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                     timeoutInterval:60.0];
    request.HTTPMethod = @"POST";
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    
    
    NSString *post  = [[NSString alloc] initWithFormat:@"versionNo=%@&platform=%@&channel=%@&appName=%@",@"1.0",@"Mac",@"appstore",@"DBAppX"];
    
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
    
    request.HTTPBody = postData;
    
    NSURLSessionTask *task =  [session dataTaskWithRequest:request];
    
    [task resume];
    
    

    
    
    
    [session getTasksWithCompletionHandler:^(NSArray *dataTasks, NSArray *uploadTasks, NSArray *downloadTasks) {
        for (NSURLSessionDataTask *task in dataTasks) {
            NSLog(@"taskDescription %@  %ld",task.taskDescription,task.taskIdentifier);
        }
       
    }];
    
}

//
//    NSURL *url = [NSURL URLWithString:
//                  @"https://developer.apple.com/library/ios/documentation/Cocoa/Reference/"
//                  "Foundation/ObjC_classic/FoundationObjC.pdf"];
- (void)urlSessionDownloadTest {
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration
                                                      defaultSessionConfiguration];
    
    NSURLSession *session  = [NSURLSession sessionWithConfiguration:
                              defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    

    NSURL *url = [NSURL URLWithString:
                  @"http://devstreaming.apple.com/videos/wwdc/2015/105ncyldc6ofunvsgtan/105/105_hd_introducing_watchkit_for_watchos_2.mp4?dl=1"];
    
    NSURLSessionDownloadTask *task =  [session downloadTaskWithURL:url];
    
    self.downTask = task;
    
    [task resume];
    
    
}


#pragma mark-  NSURLSessionDataDelegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {
    
    if(!self.data){
        self.data = [NSMutableData data];
    }
    
    [self.data appendData:data];
    
}

-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error {
    
    
    NSString *responseStr = [[NSString alloc]initWithData:self.data encoding:NSUTF8StringEncoding];
    
    NSLog(@"data =%@ taskIdentifier=%ld error %@",responseStr,task.taskIdentifier,error);
    
    
    if (error.userInfo && [error.userInfo objectForKey:NSURLSessionDownloadTaskResumeData]) {
        
        
        // If you restart app,it will call this method with resumeData
   
            self.resumeData = [error.userInfo objectForKey:NSURLSessionDownloadTaskResumeData];
        
    }
    
    
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



- (void)urlSessionUploadTest {
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration
                                                      defaultSessionConfiguration];
    
    NSURLSession *session  = [NSURLSession sessionWithConfiguration:
                              defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    
    
    NSURL *URL = [NSURL URLWithString:@"http://127.0.0.1/upload.html"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    
    
    request.HTTPMethod = @"POST";
    //[request addValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"openMacIcon.png" forHTTPHeaderField:@"fileName"];
    [request addValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    
    
    NSString *downloadDir = [[NSHomeDirectory()
                              stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"openMacIcon.png"];
    
    
    //要保存的路径
    NSURL *fileURL = [NSURL fileURLWithPath:downloadDir];
    
    // Create upload task
    NSURLSessionUploadTask *task = [session uploadTaskWithRequest:request fromFile:fileURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(!error) {
            // handle success
        } else {
            // handle error
            NSLog(@"error %@",error);
        }
    }];
    
    // Run the task
    [task resume];
    
    
}


-(IBAction)sendAudio
{
    // Define the Paths
    NSURL *uploadURL = [NSURL URLWithString:@"http://127.0.0.1/fileUpload.php"];
    
   
    // Create the Request
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:uploadURL];
    [request setHTTPMethod:@"POST"];
    
    
    NSString *downloadDir = [[NSHomeDirectory()
                              stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"AppBkIcon.png"];
    
    
    //要上传的路径
    NSURL *fileURL = [NSURL fileURLWithPath:downloadDir];
    
    
    uint64_t bytesTotalForThisFile = [[[NSFileManager defaultManager] attributesOfItemAtPath:fileURL.path error:NULL] fileSize];
    
    [request setValue:[NSString stringWithFormat:@"%llu", bytesTotalForThisFile] forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/octet-stream" forHTTPHeaderField:@"Content-Type"];
    
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration
                                                      defaultSessionConfiguration];
    
    
    NSURLSession *session  = [NSURLSession sessionWithConfiguration:
                              defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];

    
    NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request fromFile:fileURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(!error) {
            // handle success
        } else {
            // handle error
            NSLog(@"error %@",error);
        }
    }];
    
    [uploadTask resume];
    
}
//##


- (void)URLSession:(NSURLSession *)session
              task:(NSURLSessionTask *)task
   didSendBodyData:(int64_t)bytesSent
    totalBytesSent:(int64_t)totalBytesSent
totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend
{
    
    NSLog(@"Session %@ upload task %@ wrote an additional %lld bytes (total %lld bytes) out of an expected %lld bytes.\n",
          session, task, bytesSent, totalBytesSent,
          totalBytesExpectedToSend);
    
}



- (void)formUpload2 {
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
    
    
    
    
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/upload_file.php"];
    NSString *fileName = @"openMacIcon.png";
    NSString *boundary = @"sdfsfsfsdfxxxxxxxxdfgdfgdfg567567567";
    
    NSMutableData *dataSend = [[NSMutableData alloc] init];
    [dataSend appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [dataSend appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [dataSend appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file_path\"; filename=\"%@\"\r\n", fileName] dataUsingEncoding:NSUTF8StringEncoding]];
    [dataSend appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary] forHTTPHeaderField:@"Content-Type"];
    //[request setValue:[@"authtok=" stringByAppendingString:[broker getNasAuthtok]] forHTTPHeaderField:@"Cookie"];
    [request setHTTPBody:dataSend];
    
    
    NSString *uploadPath= [[NSHomeDirectory()
                              stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"openMacIcon.png"];
    NSURL *uploadfileURL = [[NSURL alloc] initFileURLWithPath:uploadPath];
    
    NSURLSessionUploadTask *sessionUploadTask = [session uploadTaskWithRequest:request fromFile:uploadfileURL];
    [sessionUploadTask resume];
}

- (void)formUpload {
    NSString *boundary = [self generateBoundaryString];
    
    
    NSDictionary *params = @{@"userName"     : @"rob",
                             @"userEmail"    : @"rob@email.com",
                             @"userPassword" : @"password"};
    
    // configure the request
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/upload.html"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    // set content type
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // create body
    
   // NSString *fileName = @"openMacIcon.png";
    
    NSString *path= [[NSHomeDirectory()
                            stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"openMacIcon.png"];
    
    NSData *httpBody = [self createBodyWithBoundary:boundary parameters:params paths:@[path] fieldName:@"file_path"];
    
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
    
    NSURLSessionTask *task = [session uploadTaskWithRequest:request fromData:httpBody completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"error = %@", error);
            return;
        }
        
        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"result = %@", result);
    }];
    [task resume];
    
}

- (NSString *)generateBoundaryString
{
    return [NSString stringWithFormat:@"Boundary-%@", [[NSUUID UUID] UUIDString]];

    
}

- (NSData *)createBodyWithBoundary:(NSString *)boundary
                        parameters:(NSDictionary *)parameters
                             paths:(NSArray *)paths
                         fieldName:(NSString *)fieldName
{
    NSMutableData *httpBody = [NSMutableData data];
    
    // add params (all params are strings)
    
    [parameters enumerateKeysAndObjectsUsingBlock:^(NSString *parameterKey, NSString *parameterValue, BOOL *stop) {
        [httpBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", parameterKey] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:[[NSString stringWithFormat:@"%@\r\n", parameterValue] dataUsingEncoding:NSUTF8StringEncoding]];
    }];
    
    // add image data
    
    for (NSString *path in paths) {
        NSString *filename  = [path lastPathComponent];
        NSData   *data      = [NSData dataWithContentsOfFile:path];
        NSString *mimetype  = @"image/png";
        
        [httpBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", fieldName, filename] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n\r\n", mimetype] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:data];
        [httpBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        [httpBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"target_path"] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:[[NSString stringWithFormat:@"http://127.0.0.1/upload_file.php"] dataUsingEncoding:NSUTF8StringEncoding]];
        
    }
    
    
    [httpBody appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    return httpBody;
}
- (IBAction)upload:(id)sender
{
  
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
    
    NSString *urlString = @"http://127.0.0.1/upload_file.php";
    NSURL *url = [NSURL URLWithString:urlString];

    NSString *filePath = [[NSHomeDirectory()
                      stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"openMacIcon.png"];

    NSString *fileName = [filePath lastPathComponent];
    NSData   *fileData      = [NSData dataWithContentsOfFile:filePath];
    

    NSString *boundary = @"-boundary";
    NSMutableData *dataSend = [[NSMutableData alloc] init];
    
    [dataSend appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
   
    [dataSend appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@\"\r\n", fileName] dataUsingEncoding:NSUTF8StringEncoding]];
  
    [dataSend appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
   
    [dataSend appendData:fileData];
    
    [dataSend appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
   
    [dataSend appendData:[[NSString stringWithFormat:@"--%@--\r\n\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:dataSend];
    [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary] forHTTPHeaderField:@"Content-Type"];
    
    
    NSURLSessionUploadTask *sessionUploadTask = [session uploadTaskWithRequest:request fromData:dataSend];
    [sessionUploadTask resume];
   
   
}

-(NSCachedURLResponse *)connection:(NSURLConnection *)connection
                 willCacheResponse:(NSCachedURLResponse *)cachedResponse {
    

    NSCachedURLResponse *returnCachedResponse = cachedResponse;
    NSDictionary *newUserInfo;
    newUserInfo = [NSDictionary dictionaryWithObject:[NSDate date]
                                              forKey:@"Cached Date"];
    
    
    #if ALLOW_CACHING
    
    returnCachedResponse = [[NSCachedURLResponse alloc]
                         initWithResponse:[cachedResponse response]
                         data:[cachedResponse data]
                         userInfo:newUserInfo
                         storagePolicy:[cachedResponse storagePolicy]];
    
    #else
    
    returnCachedResponse = nil;
    
    #endif
    
    return returnCachedResponse;
}


- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
 willCacheResponse:(NSCachedURLResponse *)proposedResponse
 completionHandler:(void (^)(NSCachedURLResponse * __nullable cachedResponse))completionHandler {
    

    NSCachedURLResponse *returnCachedResponse = proposedResponse;
    NSDictionary *newUserInfo;
    newUserInfo = [NSDictionary dictionaryWithObject:[NSDate date]
                                              forKey:@"Cached Date"];
#if ALLOW_CACHING
    
    returnCachedResponse = [[NSCachedURLResponse alloc]
                            initWithResponse:[proposedResponse response]
                            data:[proposedResponse data]
                            userInfo:newUserInfo
                            storagePolicy:[proposedResponse storagePolicy]];
    
#else
    
    returnCachedResponse = nil;
    
#endif
    
    if(completionHandler){
         completionHandler(returnCachedResponse);
    }
   
    
}

- (void)cookieTest {
    
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [storage cookies])
    {
        [storage deleteCookie:cookie];
    }
    
}


- (void)urlConnectionTest {
    
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://127.0.0.1/iosxhelper/SAPI/VersionCheck"]
                                                         cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                     timeoutInterval:60.0];
    
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error) {
        NSLog(@"request failed: %@", error);
        return ;
    }
    
//    NSString *synResponse = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    NSLog(@"synResponse: %@", synResponse);
//   
//    
//    
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue new]  completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        
//        if (connectionError) {
//            NSLog(@"request failed: %@", error);
//            return ;
//        }
//        
//        NSString *asynResponse = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(@"asynResponse: %@", asynResponse);
//        
//    }];
    
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request  delegate:self];
    
    if (connection == nil) {
        return;
    }
  
    
}
#pragma mark-- NSURLConnectionDelegate

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    if(!self.data){
        self.data = [NSMutableData data];
    }
    [self.data appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {

   NSString *response = [[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding];
    
   NSLog(@"connectionDidFinishLoading recieve data  %@",response);
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"connectionDidFinishLoading recieve response  %@",response);
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    if(error){
        NSLog(@"connectionFailWithError %@",error);
    }
}


-(void)startURLDownloadTest {
    
    NSURL *url = [NSURL URLWithString:@"http://devstreaming.apple.com/videos/wwdc/2015/105ncyldc6ofunvsgtan/105/105_introducing_watchkit_for_watchos_2.pdf?dl=1"];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    NSURLDownload *down = [[NSURLDownload alloc]initWithRequest:request delegate:self];
    
    NSString *filePath = [[NSHomeDirectory()
                              stringByAppendingPathComponent:@"Downloads"] stringByAppendingPathComponent:@"105_introducing_watchkit_for_watchos_2.pdf"];
    
    [down setDestination:filePath allowOverwrite:YES];
}


#pragma mark -- NSURLDownloadDelegate

-(void)download:(NSURLDownload *)download didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"download didReceiveResponse %@ ",response);
    //获取文件总大小
    self.totalLength = response.expectedContentLength;
}


-(void)download:(NSURLDownload *)download didReceiveDataOfLength:(NSUInteger)length {
    //计算已经下载的大小
    self.currentLength += length;
    NSLog(@"download didReceiveDataOfLength %ld currentLength %ld ",length,self.currentLength);
}


-(void)downloadDidFinish:(NSURLDownload *)download {
    NSLog(@"download Did Finish !");
}

-(void)download:(NSURLDownload *)download didFailWithError:(NSError *)error {
    if(error){
        NSLog(@"didFailWithError %@",error);
    }
}

@end
