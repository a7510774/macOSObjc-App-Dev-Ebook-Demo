//
//  AppDelegate.m
//  MultiDelegate
//
//  Created by zhaojw on 10/3/15.
//  Copyright © 2015 zhaojw. All rights reserved.
//

#import "AppDelegate.h"
#import "Buddy.h"
#import "BuddyStatusManager.h"
#import "BuddyStatusMulticastDelegate.h"
#import "DBDatabase.h"
#import "MainViewController.h"

#define kDatabaseName @"Chat.sqlite"
@interface AppDelegate ()
@property(weak) IBOutlet NSWindow *window;
@property(nonatomic, strong) NSTimer *timer;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  // Insert code here to initialize your application

  if (![[DBDatabase sharedInstance] openDBWithDBName:kDatabaseName]) {
    NSLog(@"Open Db %@ Failed!", kDatabaseName);
  }

  self.window.contentViewController = [[MainViewController alloc] init];

  self.timer = [NSTimer scheduledTimerWithTimeInterval:2
                                                target:self
                                              selector:@selector(buddyTest)
                                              userInfo:nil
                                               repeats:YES];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
  // Insert code here to tear down your application
}

- (void)buddyTest {

  NSInteger ID = random() % 2 + 1;

  NSInteger status = random() % 10;

  Buddy *buddy = [[Buddy alloc] init];

  buddy.ID = ID;

  buddy.status = NO;

  if (status > 5) {
    buddy.status = YES;
  }

  if (!buddy.status) {
    [[BuddyStatusManager sharedInstance].statusDelegate
        buddyOfflineRequest:buddy];
  } else {

    [[BuddyStatusManager sharedInstance].statusDelegate
        buddyOfflineRequest:buddy];
  }

  NSLog(@"ID %ld status %hhd ", ID, buddy.status);
}

@end
