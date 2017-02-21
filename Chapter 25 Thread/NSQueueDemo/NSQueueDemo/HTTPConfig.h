//
//  HTTPConfig.h
//  NSQueueDemo
//
//  Created by zhaojw on 1/22/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPConfig : NSObject
+ (instancetype)sharedInstance;
- (NSString*)domain;
- (void)setDomain:(NSString*)domain;
-(NSString *)interface;
-(void)setInterface:(NSString *)value;
@end
