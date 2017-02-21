//
//  AppDelegate.m
//  NSUserNotificationDemo
//
//  Created by zhaojw on 11/23/15.
//  Copyright © 2015 zhaojw. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate () <NSUserNotificationCenterDelegate>

@property (weak) IBOutlet NSWindow *window;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    NSUserNotification *remoteNotif =
    [aNotification.userInfo objectForKey:NSApplicationLaunchUserNotificationKey];
    
    if(remoteNotif){
        NSLog(@"remoteNotif %@",remoteNotif);

    }
    
   [self startLocalPushNotification];
    
  
}

- (void)startLocalPushNotification {
    
    NSUserNotification *notification = [[NSUserNotification alloc] init];
    notification.title = @"Message";
    notification.informativeText = @"I have a dream!";
    //消息附加数据
    notification.userInfo = @{@"messageID":@(1000)};
    //通知注册的时间
    notification.deliveryDate = [NSDate dateWithTimeIntervalSinceNow:10];
    //通知重复的间隔,10分钟一次
    notification.deliveryRepeatInterval.second = 30;
    
    //设置通知代理
    [NSUserNotificationCenter defaultUserNotificationCenter].delegate = self;
    //注册本地通知
    [[NSUserNotificationCenter defaultUserNotificationCenter]
     scheduleNotification:notification];
}


- (void)userNotificationCenter:(NSUserNotificationCenter *)center didDeliverNotification:(NSUserNotification *)notification {
    NSLog(@"userNotificationCenter notification %@",notification);
}

- (void)userNotificationCenter:(NSUserNotificationCenter *)center didActivateNotification:(NSUserNotification *)notification {
    //NSLog(@"didActivateNotification notification %@",notification);
    [self.window orderFront:self];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (void)application:(NSApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken  {
    
    NSString* tokenStr = [[NSString stringWithFormat:@"%@",deviceToken]
                           stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    NSLog(@"deviceToken %@",deviceToken);
    
    NSLog(@"deviceToken %@",tokenStr);
    

}




@end
