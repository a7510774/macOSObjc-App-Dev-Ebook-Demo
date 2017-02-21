//
//  ClientCmdHelper.m
//  OpenMacI
//
//  Created by zhaojw on 12/18/15.
//  Copyright © 2015 MacDev.io. All rights reserved.
//

#import "ClientCmdHelper.h"
#import "JSONObjKit.h"


NSString *kCmdTypeKey  = @"cmdType";
NSString *kPasswordKey = @"password";
NSString *kStatusKey   = @"status";
NSString *kUsernameKey = @"userName";

@implementation ClientCmdHelper



+ (NSData*)wakeupCmdData {
    NSMutableDictionary *opMap = [NSMutableDictionary dictionary];
    opMap[kCmdTypeKey]=@(ClientCmdWakeupType);
    opMap[kPasswordKey]=@"1234";
    NSString *cmdStr = [opMap xx_JSONString];
    NSData *cmdData = [cmdStr dataUsingEncoding:NSUTF8StringEncoding];
    return cmdData;
}

+ (NSData*)sleepCmdData {
    NSMutableDictionary *opMap = [NSMutableDictionary dictionary];
    opMap[kCmdTypeKey]=@(ClientCmdSleepType);
    NSString *cmdStr = [opMap xx_JSONString];
    NSData *cmdData = [cmdStr dataUsingEncoding:NSUTF8StringEncoding];
    return cmdData;
}

+ (NSData*)restartCmdData {
    NSMutableDictionary *opMap = [NSMutableDictionary dictionary];
    opMap[kCmdTypeKey]=@(ClientCmdRestartType);
    NSString *cmdStr = [opMap xx_JSONString];
    NSData *cmdData = [cmdStr dataUsingEncoding:NSUTF8StringEncoding];
    return cmdData;
}

+ (NSData*)shutdownCmdData {
    NSMutableDictionary *opMap = [NSMutableDictionary dictionary];
    opMap[kCmdTypeKey]=@(ClientCmdShutdownType);
    NSString *cmdStr = [opMap xx_JSONString];
    NSData *cmdData = [cmdStr dataUsingEncoding:NSUTF8StringEncoding];
    return cmdData;
}


@end
