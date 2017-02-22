//
//  BuddyStatusMulticastDelegate.m
//  MultiDelegate
//
//  Created by zhaojw on 10/4/15.
//  Copyright © 2015 zhaojw. All rights reserved.
//

#import "BuddyStatusMulticastDelegate.h"

@implementation BuddyStatusMulticastDelegate

- (void)buddyOfflineRequest:(Buddy *)buddy {
  [multicastDelegate buddyStatus:self didReceiveBuddyOfflineRequest:buddy];
}

- (void)buddyOnlineRequest:(Buddy *)buddy {
  [multicastDelegate buddyStatus:self didReceiveBuddyOnlineRequest:buddy];
}

@end
