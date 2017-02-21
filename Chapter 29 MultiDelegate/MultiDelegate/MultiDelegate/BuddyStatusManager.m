//
//  BuddyStatusManager.m
//  MultiDelegate
//
//  Created by zhaojw on 10/4/15.
//  Copyright © 2015 zhaojw. All rights reserved.
//

#import "BuddyStatusManager.h"
#import "BuddyStatusMulticastDelegate.h"

@interface BuddyStatusManager()
@property(nonatomic,readwrite)BuddyStatusMulticastDelegate *statusDelegate;
@end

@implementation BuddyStatusManager
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static BuddyStatusManager *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[BuddyStatusManager alloc] init];
    });
    return sharedInstance;
}

- (BuddyStatusMulticastDelegate*)statusDelegate
{
    if(!_statusDelegate){
        _statusDelegate = [[BuddyStatusMulticastDelegate alloc]init];
    }
    return _statusDelegate;
}
@end
