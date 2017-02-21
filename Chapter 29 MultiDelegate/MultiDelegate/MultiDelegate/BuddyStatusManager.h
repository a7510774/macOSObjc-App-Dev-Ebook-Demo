//
//  BuddyStatusManager.h
//  MultiDelegate
//
//  Created by zhaojw on 10/4/15.
//  Copyright © 2015 zhaojw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BuddyStatusMulticastDelegate.h"
@interface BuddyStatusManager : NSObject
+ (instancetype)sharedInstance;

@property(nonatomic,readonly)BuddyStatusMulticastDelegate *statusDelegate;
@end
