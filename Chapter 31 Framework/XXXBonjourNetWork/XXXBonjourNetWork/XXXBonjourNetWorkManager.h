//
//  XXXBonjourNetWorkManager.h
//  XXXBonjourNetWork
//
//  by zhaojw on 1/4/14.
//  Copyright (c) 2014 http://www.cocoahunt.com. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum _XXXBonjourNetWorkBroadcastType {
    XXXBonjourNetWorkNilType = 0,
    XXXBonjourNetWorkFindService = 1,
    XXXBonjourNetWorkRemoveService = 2,
    XXXBonjourNetWorkResolveAddress = 3,
    XXXBonjourNetWorkNotResolveAddress = 4,
    XXXBonjourNetWorkStop=5
} XXXBonjourNetWorkBroadcastType;

@interface XXXBonjourNetWorkManager : NSObject
- (id)initWithType:(NSString*)type domain:(NSString *)domain;
- (void)start;
- (void)stop;
@end
