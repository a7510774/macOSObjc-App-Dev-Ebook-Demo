//
//  AppDelegate.m
//  BluetoothCentraliOSDemo
//
//  Created by zhaojw on 15/10/25.
//  Copyright © 2015年 zhaojw. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreBluetooth/CoreBluetooth.h>

#define  kServiceUUID    @"84941CC5-EA0D-4CAE-BB06-1F849CCF8495"

#define  kCharacteristicUUID    @"2BCD"

@interface AppDelegate () <CBCentralManagerDelegate,CBPeripheralDelegate>

@property (nonatomic,strong)CBCentralManager *centralManager;

@property (nonatomic,strong)CBPeripheral  *peripheral;

@property(nonatomic,strong)CBService *service;

@property(nonatomic,strong)CBCharacteristic *characteristic;

@property(nonatomic,assign)BOOL connected;

@property(nonatomic,assign)BOOL notified;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.notified = NO;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    NSLog(@"peripheralManager init state %d",self.centralManager.state);

    if(!self.connected) {
        
        [self scan];
    }
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)scan
{
    [self.centralManager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:kServiceUUID]]
                                                options:@{ CBCentralManagerScanOptionAllowDuplicatesKey : @YES }];
    
    //[self.centralManager scanForPeripheralsWithServices:nil options:nil];
    
     NSLog(@"Scanning started");
}

- (void)retrieveServices
{
    
    [self.centralManager retrieveConnectedPeripheralsWithServices:@[[CBUUID UUIDWithString:kServiceUUID]]];
    
    //[self.centralManager scanForPeripheralsWithServices:nil options:nil];
    
    NSLog(@"retrieveServices started");
}


#pragma mark-- CBCentralManagerDelegate

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    
    NSString *state;
    switch (central.state)
    {
        case CBCentralManagerStatePoweredOff:
        {
            
            state = @"CBCentralManagerStatePoweredOff";
            
            break;
        }
            
        case CBCentralManagerStateUnauthorized:
        {
            /* Tell user the app is not allowed. */
            
            state = @"CBCentralManagerStateUnauthorized";
            break;
        }
            
        case CBCentralManagerStateUnknown:
        {
            /* Bad news, let's wait for another event. */
            state = @"CBCentralManagerStateUnknown";
            break;
        }
            
        case CBCentralManagerStateUnsupported:
        {
            state = @"CBCentralManagerStateUnsupported";
            break;
        }
            
        case CBCentralManagerStatePoweredOn:
        {
            state = @"CBCentralManagerStatePoweredOn";
            
            [self scan];
            
            break;
        }
            
        case CBCentralManagerStateResetting:
        {
        
            state = @"CBCentralManagerStateResetting";
            break;
        }
    }
    
    
    NSLog(@"Central manager state: %@", state);
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *, id> *)advertisementData RSSI:(NSNumber *)RSSI {
    
    
    NSLog(@"discoverPeripheral %@",peripheral);
    
    [central stopScan];
    
    self.peripheral = peripheral;
    
    NSDictionary *op = @{CBConnectPeripheralOptionNotifyOnDisconnectionKey:@(YES)};
    
    [central connectPeripheral:peripheral options:op];
    
}
- (void)centralManager:(CBCentralManager *)central didRetrieveConnectedPeripherals:(NSArray<CBPeripheral *> *)peripherals {
    
     NSLog(@"didRetrieveConnectedPeripherals %@",peripherals);
}

- (void)centralManager:(CBCentralManager *)central didRetrievePeripherals:(NSArray<CBPeripheral *> *)peripherals {
    NSLog(@"didRetrievePeripherals %@",peripherals);
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {
    
    if(error){
        
        NSLog(@"didRetrievePeripherals error %@",error);
        
        return;
    }
    
    NSLog(@"didFailToConnectPeripheral %@",peripheral);
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    
    NSLog(@"peripheral  %@ connected",peripheral);
    
    //discover Services
    
    self.connected = YES;
    
    peripheral.delegate = self;
    
    [peripheral discoverServices:@[[CBUUID UUIDWithString:kServiceUUID]]];
    
    NSLog(@"start discover Services %@ ",kServiceUUID);
    
}
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {
    
    NSLog(@"didDisconnectPeripheral %@",peripheral);
    
    self.connected = NO;
}


#pragma mark-- CBPeripheralDelegate

- (void)peripheralDidUpdateName:(CBPeripheral *)peripheral {
    
    NSLog(@"peripheral state %ld",peripheral.state);
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(nullable NSError *)error {
    
    if(error) {
         NSLog(@"didDiscoverServices error %@",error);
        return;
    }
    
    for (CBService *service in peripheral.services) {
       
        NSLog(@"discovered service %@", service);
        
        NSLog(@"start discovering characteristics for service %@", service);
        
        [peripheral discoverCharacteristics:@[[CBUUID UUIDWithString:kCharacteristicUUID]] forService:service];
    }

}


- (void)peripheral:(CBPeripheral *)peripheral
didDiscoverCharacteristicsForService:(CBService *)service
             error:(NSError *)error {
    for (CBCharacteristic *characteristic in service.characteristics) {
        
        NSLog(@"discovered characteristic %@", characteristic);
        
        
        NSLog(@"Reading value for characteristic %@", characteristic);
        
        if(!self.notified){
            
            [peripheral readValueForCharacteristic:characteristic];
        }
        else {
            
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral
didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic
             error:(NSError *)error {
    
    if(error){
        NSLog(@"didUpdateValueForCharacteristic error %@",error);
        return;
    }
    
    NSData *data = characteristic.value;
    
    NSString *value = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"Reading value for data %@", value);
    
}

- (void)peripheral:(CBPeripheral *)peripheral
didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic
             error:(NSError *)error {
    if (error) {
        NSLog(@"Error changing notification state: %@",
              [error localizedDescription]);
        
        return;
    }
    
    NSData *data = characteristic.value;
    
    NSString *value = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"notification value for data %@", value);
    
    
}



#pragma mark-- ivars

- (CBCentralManager *)centralManager {
    
    if(!_centralManager) {
        
        _centralManager = [[CBCentralManager alloc]initWithDelegate:self queue:nil ];
        
    }
    
    return _centralManager;
}


@end
