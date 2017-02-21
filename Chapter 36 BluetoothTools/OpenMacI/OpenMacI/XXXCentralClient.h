//
//  XXXCentralClient.h
//  OpenMacI
//
//  Created by zhaojw on 12/18/15.
//  Copyright © 2015 MacDev.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@class XXXCentralClient;
@protocol XXXCentralClientDelegate <NSObject>
@optional
//搜索服务完成,获取到广播数据
- (void)centralClient:(XXXCentralClient*)centralClient didRecieveAdvertisementData:(NSDictionary*)advertisementData;
//接收到订阅数据
- (void)centralClient:(XXXCentralClient*)centralClient didRecieveSubscribeData:(NSData*)subscribData;
//Central开始跟对端Peripheral建立连接
- (void)didStartConnect:(XXXCentralClient*)centralClient;
//连接完成
- (void)didCompleteConnect:(XXXCentralClient*)centralClient;
@end

@interface XXXCentralClient : NSObject
@property(weak)id <XXXCentralClientDelegate> delegate;
- (instancetype)initWithServiceID:(NSString*)serviceID characterisitcID:(NSString*)characterisitcID;
- (void)pingService;//ping 服务,防止蓝牙连接断开
- (void)start;//启动
- (void)writeData:(NSData*)data;//发送指令到对端的写操作
@end
