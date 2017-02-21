//
//  AppDelegate.m
//  BluetoothCentralDemo
//
//  Created by zhaojw on 15/10/24.
//  Copyright © 2015年 zhaojw. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreBluetooth/CoreBluetooth.h>

#define  kServiceUUID    @"84941CC5-EA0D-4CAE-BB06-1F849CCF8495"

#define  kCharacteristicUUID    @"2BCD"

@interface AppDelegate ()<CBCentralManagerDelegate>

@property (weak) IBOutlet NSWindow *window;

@property (nonatomic,strong) CBCentralManager *centralManager;



@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
       NSLog(@"peripheralManager init state %ld",self.centralManager.state);
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
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
           // [self clearDevices];
            
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
           // [self clearDevices];
            
            state = @"CBCentralManagerStateResetting";
            break;
        }
    }

    
     NSLog(@"Central manager state: %@", state);
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *, id> *)advertisementData RSSI:(NSNumber *)RSSI {
    
   
    NSLog(@"discoverPeripheral %@",peripheral);
    
    
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
    
     NSLog(@"didConnectPeripheral %@",peripheral);
}
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {
    
     NSLog(@"didDisconnectPeripheral %@",peripheral);
}



#pragma mark-- ivars

- (CBCentralManager *)centralManager {
    
    if(!_centralManager) {
        
        _centralManager = [[CBCentralManager alloc]initWithDelegate:self queue:nil ];
        
    }
    
    return _centralManager;
}

@end
