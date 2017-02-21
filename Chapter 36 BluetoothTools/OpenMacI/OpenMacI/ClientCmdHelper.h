//
//  ClientCmdHelper.h
//  OpenMacI
//
//  Created by zhaojw on 12/18/15.
//  Copyright © 2015 MacDev.io. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ClientCmdType) {
    ClientCmdSleepType = 0,
    ClientCmdWakeupType,
    ClientCmdRestartType,
    ClientCmdShutdownType,
};

typedef NS_ENUM(NSInteger, StatusType) {
    StatusSleepType = 0,
    StatusWakeupType,
    StatusShutdownType,
    
};

@interface ClientCmdHelper : NSObject
+ (NSData*)sleepCmdData;
+ (NSData*)wakeupCmdData;
+ (NSData*)restartCmdData;
+ (NSData*)shutdownCmdData;
@end
