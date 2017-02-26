//
//  HTTPClient.m
//  HTTPClient
//
//  Created by zhaojw on 2/22/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//

#import "HTTPClient.h"

typedef void (^HTTPSessionDataTaskCompletionBlock)(
    NSURLResponse *__unused response, id responseObject, NSError *error);
@interface HTTPClient () <NSURLSessionDataDelegate>
@property(nonatomic, strong) NSURLSessionConfiguration *sessionConfiguration;
@property(nonatomic, strong) NSOperationQueue *operationQueue;
@property(nonatomic, strong) NSURLSession *session;
@property(nonatomic, strong) NSMutableDictionary *taskDelegates;
@property(nonatomic, strong) NSLock *lock;
@end

@interface HTTPClientSessionDelegate : NSObject <NSURLSessionDataDelegate>
@property(nonatomic, copy)
    HTTPSessionDataTaskCompletionBlock taskCompletionHandler;
@property(nonatomic, strong) NSMutableData *mutableData;
@end

@implementation HTTPClientSessionDelegate

#pragma mark-- NSURLSessionTaskDelegate

- (void)URLSession:(NSURLSession *)session
                    task:(NSURLSessionTask *)task
    didCompleteWithError:(nullable NSError *)error {
  NSData *data = nil;
  if (self.mutableData) {
    data = [self.mutableData copy];
    self.mutableData = nil;
  }
  if (self.taskCompletionHandler) {
    self.taskCompletionHandler(task.response, data, error);
  }
}
#pragma mark-- NSURLSessionDataDelegate

- (void)URLSession:(NSURLSession *)session
              dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveResponse:(NSURLResponse *)response
     completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))
                           completionHandler {
  completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {
  if (!self.mutableData) {
    self.mutableData = [NSMutableData data];
  }
  [self.mutableData appendData:data];
}

- (void)URLSession:(NSURLSession *)session
             dataTask:(NSURLSessionDataTask *)dataTask
    willCacheResponse:(NSCachedURLResponse *)proposedResponse
    completionHandler:(void (^)(NSCachedURLResponse *__nullable cachedResponse))
                          completionHandler {

  if (completionHandler) {
    completionHandler(proposedResponse);
  }
}
@end

@implementation HTTPClient

- (instancetype)init {
  self = [super init];
  if (self) {
    _sessionConfiguration =
        [NSURLSessionConfiguration defaultSessionConfiguration];
    _operationQueue = [[NSOperationQueue alloc] init];
    _operationQueue.maxConcurrentOperationCount = 1;
    _session = [NSURLSession sessionWithConfiguration:_sessionConfiguration
                                             delegate:self
                                        delegateQueue:_operationQueue];
    _taskDelegates = [NSMutableDictionary dictionary];
    _lock = [[NSLock alloc] init];
  }
  return self;
}

- (void)GET:(NSString *)URLString
    parameters:(id)parameters
       success:(void (^)(id responseData))success
       failure:(void (^)(NSError *error))failure {

  NSMutableURLRequest *request =
      [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString]];
  NSURLSessionDataTask *task =
      [self dataTaskWithRequest:request success:success failure:failure];
  [task resume];
}

- (void)POST:(NSString *)URLString
    parameters:(id)parameters
       success:(void (^)(id responseData))success
       failure:(void (^)(NSError *error))failure {

  NSMutableURLRequest *request =
      [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString]];
  request.HTTPMethod = @"POST";

  NSString *postStr;
  NSData *postData;
  if ([parameters isKindOfClass:[NSString class]]) {
    postStr = parameters;
  }
  if ([parameters isKindOfClass:[NSDictionary class]]) {

    NSDictionary *keyValues = parameters;
    NSMutableString *tempStr = [NSMutableString string];
    __block int index = 0;
    [keyValues
        enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL *stop) {
          if (index > 0) {
            [tempStr appendString:@"&"];
          }
          NSString *kv = [NSString stringWithFormat:@"%@=%@", key, obj];
          [tempStr appendString:kv];
          index++;
        }];
    postStr = tempStr;
  }

  postData = [postStr dataUsingEncoding:NSUTF8StringEncoding];
  [request setValue:@"application/x-www-form-urlencoded"
      forHTTPHeaderField:@"content-type"];
  request.HTTPBody = postData;

  NSURLSessionDataTask *task =
      [self dataTaskWithRequest:request success:success failure:failure];
  [task resume];
}

- (NSURLSessionDataTask *)dataTaskWithRequest:(NSMutableURLRequest *)request
                                      success:(void (^)(id responseData))success
                                      failure:
                                          (void (^)(NSError *error))failure {

  __block NSURLSessionDataTask *dataTask =
      [self.session dataTaskWithRequest:request];
  HTTPSessionDataTaskCompletionBlock completionHandler =
      ^(NSURLResponse *__unused response, id responseObject, NSError *error) {
        if (error) {
          if (failure) {
            failure(error);
          }
        } else {
          if (success) {
            success(responseObject);
          }
        }
      };
  [self addDataTaskCompletionBlock:completionHandler forTask:dataTask];
  return dataTask;
}

- (void)addDataTaskCompletionBlock:
            (HTTPSessionDataTaskCompletionBlock)completionHandler
                           forTask:(NSURLSessionDataTask *)task {

  HTTPClientSessionDelegate *sessionDelegate =
      [[HTTPClientSessionDelegate alloc] init];
  sessionDelegate.taskCompletionHandler = completionHandler;

  NSUInteger identifier = task.taskIdentifier;
  [self.lock lock];
  self.taskDelegates[@(identifier)] = sessionDelegate;
  [self.lock unlock];
}

#pragma mark-- NSURLSessionTaskDelegate

- (void)URLSession:(NSURLSession *)session
                    task:(NSURLSessionTask *)task
    didCompleteWithError:(nullable NSError *)error {

  HTTPClientSessionDelegate *delegate =
      self.taskDelegates[@(task.taskIdentifier)];
  if (delegate) {
    [delegate URLSession:session task:task didCompleteWithError:error];
  }
}

#pragma mark-- NSURLSessionDataDelegate

- (void)URLSession:(NSURLSession *)session
              dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveResponse:(NSURLResponse *)response
     completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))
                           completionHandler {

  HTTPClientSessionDelegate *delegate =
      self.taskDelegates[@(dataTask.taskIdentifier)];
  if (delegate) {
    [delegate URLSession:session
                  dataTask:dataTask
        didReceiveResponse:response
         completionHandler:completionHandler];
  }
}

- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {

  HTTPClientSessionDelegate *delegate =
      self.taskDelegates[@(dataTask.taskIdentifier)];
  if (delegate) {
    [delegate URLSession:session dataTask:dataTask didReceiveData:data];
  }
}

- (void)URLSession:(NSURLSession *)session
             dataTask:(NSURLSessionDataTask *)dataTask
    willCacheResponse:(NSCachedURLResponse *)proposedResponse
    completionHandler:(void (^)(NSCachedURLResponse *__nullable cachedResponse))
                          completionHandler {

  HTTPClientSessionDelegate *delegate =
      self.taskDelegates[@(dataTask.taskIdentifier)];
  if (delegate) {
    [delegate URLSession:session
                 dataTask:dataTask
        willCacheResponse:proposedResponse
        completionHandler:completionHandler];
  }
}

@end
