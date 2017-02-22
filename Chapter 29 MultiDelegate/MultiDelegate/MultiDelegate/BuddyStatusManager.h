//
//  BuddyStatusManager.h
//  MultiDelegate
//
//  Created by zhaojw on 10/4/15.
//  Copyright © 2015 zhaojw. All rights reserved.
//

#import "BuddyStatusMulticastDelegate.h"
#import <Foundation/Foundation.h>
@interface BuddyStatusManager : NSObject
+ (instancetype)sharedInstance;

@property(nonatomic, readonly) BuddyStatusMulticastDelegate *statusDelegate;
@end
