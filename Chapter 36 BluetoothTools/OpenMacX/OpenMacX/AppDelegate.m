//
//  AppDelegate.m
//  OpenMacX
//
//  Created by zhaojw on 12/17/15.
//  Copyright © 2015 zhaojw. All rights reserved.
//

#import "AppDelegate.h"
#import "XXXPeripheralService.h"
#import "JSONObjKit.h"
#import "CmdManager.h"
#import "MDRestartShutdownLogout.h"
#define  kServiceUUID           @"84941CC5-EA0D-4CAE-BB06-1F849CCF8495"
#define  kCharacteristicUUID    @"2BCD"

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


NSString *kCmdTypeKey = @"cmdType";
NSString *kPasswordKey = @"password";
NSString *kStatusKey = @"status";
NSString *kUsernameKey = @"userName";

@interface AppDelegate ()<XXXPeripheralServiceDelegate>
@property (weak) IBOutlet    NSWindow *window;
@property (weak) IBOutlet    NSMenu *sysMenu;
@property (strong,nonatomic) NSStatusItem *item;
@property(nonatomic,strong)  XXXPeripheralService *peripheralService;
@property(nonatomic,assign)  BOOL         isSleep;
@property(nonatomic,assign)  StatusType   statusType;
@property(nonatomic,copy)    NSString     *userName;

@property (weak) IBOutlet    NSMenuItem   *startMenu;
@property (weak) IBOutlet    NSMenuItem   *stopMenu;
@property(nonatomic,assign)  BOOL         enableStartMenu;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
   
    [self createStatusBar];
    self.statusType = StatusWakeupType;
    self.userName =  NSUserName();
    [self registerScreenStatusNotify];
    self.enableStartMenu = YES;
   
}

- (void)createStatusBar {
    //获取系统单例NSStatusBar对象
    NSStatusBar *statusBar = [NSStatusBar systemStatusBar];
    //创建固定宽度的NSStatusItem
    NSStatusItem *item = [statusBar statusItemWithLength:NSSquareStatusItemLength];
    item.button.image = [NSImage imageNamed:@"openMacIcon@2x.png"];
    //设置下拉菜单
    item.menu = self.sysMenu;
    //保存到属性变量
    self.item = item;
}

- (void)registerScreenStatusNotify {
    
    [[[NSWorkspace sharedWorkspace]notificationCenter]addObserver:self selector:@selector(recieveSleepNotification:) name:NSWorkspaceScreensDidSleepNotification object:nil];
    
    [[[NSWorkspace sharedWorkspace]notificationCenter]addObserver:self selector:@selector(recieveSleepNotification:) name:NSWorkspaceScreensDidWakeNotification object:nil];
    
    
}

- (void)recieveSleepNotification:(NSNotification*)notification {
    
    if([notification.name isEqualToString:NSWorkspaceScreensDidSleepNotification]){
        self.statusType = StatusSleepType;
    }
    if([notification.name isEqualToString:NSWorkspaceScreensDidWakeNotification]){
        self.statusType = StatusWakeupType;
    }
    NSData *nofifyData = [self.statusInfo xx_JSONData];
    [self.peripheralService nofifySubscribeData:nofifyData];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    NSStatusBar *statusBar = [NSStatusBar systemStatusBar];
    [statusBar removeStatusItem:self.item];
}

#pragma mark--  XXXPeripheralServiceDelegate
- (void)peripheralService:(XXXPeripheralService *)peripheralService didRecieveWriteData:(NSData*)data {
    
    NSString *cmdStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"didReceiveWriteRequests Data String = %@ ", cmdStr);
    
    NSDictionary *cmdDict = [cmdStr xx_objectFromJSONString];
    ClientCmdType cmdType = (ClientCmdType)[cmdDict[kCmdTypeKey] integerValue];
    
    if(cmdType==ClientCmdWakeupType){
        [self wake];
        NSString *password = cmdDict[kPasswordKey];
        BOOL isOK = [self inputPasswordScript:password];
        if(isOK){
             self.statusType = StatusWakeupType;
        }
        NSData *nofifyData = [self.statusInfo xx_JSONData];
        [self.peripheralService nofifySubscribeData:nofifyData];
        return;
    }
    
    if(cmdType==ClientCmdSleepType){
        [self sleep];
        self.statusType = StatusSleepType;
        NSData *nofifyData = [self.statusInfo xx_JSONData];
        [self.peripheralService nofifySubscribeData:nofifyData];
        return;
    }
    
    if(cmdType==ClientCmdRestartType){
        MDSendAppleEventToSystemProcess(kAERestart);
    }
    
    if(cmdType==ClientCmdShutdownType){
        MDSendAppleEventToSystemProcess(kAEShutDown);
    }
}

- (NSData*)peripheralServiceSubscribeData:(XXXPeripheralService *)peripheralService {
    NSData *nofifyData = [self.statusInfo xx_JSONData];
    return nofifyData;
}

- (NSMutableDictionary*)statusInfo {
    NSMutableDictionary *statusInfo = [NSMutableDictionary dictionary];
    statusInfo[kUsernameKey] = self.userName;
    statusInfo[kStatusKey] = @(self.statusType);
    return statusInfo;
}

- (BOOL)inputPasswordScript:(NSString*)password {
    NSString * scriptSource = [[CmdManager sharedInstance]passwordCmdScript];
    if(password){
        scriptSource = [scriptSource stringByReplacingOccurrencesOfString:@"%@" withString:password];
    }
    NSAppleScript *appleScript = [[NSAppleScript alloc] initWithSource:scriptSource];
    NSDictionary *errDict = nil;
    if (![appleScript executeAndReturnError:&errDict]) {
        NSLog(@"execute errDict=%@",[errDict description]);
        return NO;
    }
    else{
        NSLog(@"execute scriptSource =%@   ok!",scriptSource);
        return YES;
    }
}

- (void)wake {
    io_registry_entry_t registryEntry = IORegistryEntryFromPath(kIOMasterPortDefault, "IOService:/IOResources/IODisplayWrangler");
    if (registryEntry) {
        IORegistryEntrySetCFProperty(registryEntry, CFSTR("IORequestIdle"), kCFBooleanFalse);
        IOObjectRelease(registryEntry);
    }
}

- (void)sleep {
    io_registry_entry_t registryEntry = IORegistryEntryFromPath(kIOMasterPortDefault, "IOService:/IOResources/IODisplayWrangler");
    if (registryEntry) {
        IORegistryEntrySetCFProperty(registryEntry, CFSTR("IORequestIdle"), kCFBooleanTrue);
        IOObjectRelease(registryEntry);
    }
}

#pragma mark-- Menu Action

- (IBAction)startAction:(id)sender {
    NSLog(@"startAction");
    [self.peripheralService startService];
    self.enableStartMenu = NO;
}


- (IBAction)stopAction:(id)sender {
    NSLog(@"stopAction");
    [self.peripheralService stopService];
    self.enableStartMenu = YES;
}


- (IBAction)exitAction:(id)sender {
    [[NSApplication sharedApplication]terminate:nil];
}

- (BOOL)validateMenuItem:(NSMenuItem *)menuItem{
    
    SEL action = [menuItem action];
    if (action==@selector(startAction:)) {
        return self.enableStartMenu;
    }
    if (action==@selector(stopAction:)) {
        return !self.enableStartMenu;
    }
    return YES;
}


#pragma mark- ivar

- (XXXPeripheralService*)peripheralService {
    if(!_peripheralService){
        _peripheralService= [[XXXPeripheralService alloc]initWithServiceID:kServiceUUID characteristicID:kCharacteristicUUID];
        _peripheralService.peripheralIdentifier = self.userName;
        _peripheralService.delegate = self;
    }
    return _peripheralService;
}



@end
