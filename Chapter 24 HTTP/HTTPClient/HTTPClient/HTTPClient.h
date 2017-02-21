//
//  HTTPClient.h
//  HTTPClient
//
//  Created by zhaojw on 2/22/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface HTTPClient : NSObject

- (void)GET:(NSString *)URLString
    parameters:(id)parameters
    success:(void (^)(id responseData))success
    failure:(void (^)(NSError * error))failure;

- (void)POST:(NSString *)URLString
    parameters:(id)parameters
    success:(void (^)(id responseData))success
    failure:(void (^)(NSError * error))failure;

@end
