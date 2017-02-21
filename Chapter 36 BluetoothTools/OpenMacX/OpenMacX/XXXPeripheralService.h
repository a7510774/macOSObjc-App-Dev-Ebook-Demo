//
//  XXXPeripheralService.h
//  OpenMacX
//
//  Created by zhaojw on 12/17/15.
//  Copyright © 2015 zhaojw. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XXXPeripheralService;
@protocol XXXPeripheralServiceDelegate <NSObject>
@optional
- (void)peripheralService:(XXXPeripheralService *)peripheralService didRecieveWriteData:(NSData*)data;
- (NSData*)peripheralServiceSubscribeData:(XXXPeripheralService *)peripheralService;
@end

@interface XXXPeripheralService : NSObject
@property(weak) id<XXXPeripheralServiceDelegate> delegate;
@property(nonatomic,strong)NSString *peripheralIdentifier;
- (instancetype)initWithServiceID:(NSString*)serviceID characteristicID:(NSString*)characteristicID;
- (void)startService;
- (void)stopService;
- (void)nofifySubscribeData:(NSData*)data;
@end

