//
//  XXXCentralClient.m
//  OpenMacI
//
//  Created by zhaojw on 12/18/15.
//  Copyright © 2015 MacDev.io. All rights reserved.
//

#import "XXXCentralClient.h"

@interface XXXCentralClient () <CBCentralManagerDelegate,CBPeripheralDelegate>
@property(nonatomic,copy)   NSString             *serviceID;
@property(nonatomic,copy)   NSString             *characteristicID;

@property(nonatomic,strong) CBUUID               *serviceUUID;
@property(nonatomic,strong) CBUUID               *characteristicUUID;

@property(nonatomic,strong) CBCentralManager     *centralManager;
@property(nonatomic,strong) CBPeripheral         *peripheral;

@property(nonatomic,strong) CBCentral            *central;
@property(nonatomic,strong) CBService            *service;
@property(nonatomic,strong) CBCharacteristic     *characteristic;
@end

@implementation XXXCentralClient
- (instancetype)initWithServiceID:(NSString*)serviceID characterisitcID:(NSString*)characterisitcID {
    self = [super init];
    if(self){
        _serviceID = serviceID;
        _characteristicID = characterisitcID;
    }
    return self;
}
#pragma mark--  Interface

- (void)start {
    NSLog(@"centralManager init state %d",(int)self.centralManager.state);
}

- (void)pingService {
    [self searchService];
}

- (void)writeData:(NSData*)data {
    if (!self.service){
        NSLog(@"writeData No connected services for peripheralat all!");
        return;
    }
    [self.peripheral writeValue:data forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
}

#pragma mark-- Service Helper

- (void)searchService {
    //[self.centralManager stopScan];
    NSDictionary *options = @{ CBCentralManagerScanOptionAllowDuplicatesKey : @YES };
   [self.centralManager scanForPeripheralsWithServices:@[self.serviceUUID] options:options];
}

#pragma mark--CBCentralManagerDelegate

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    
    NSString *state;
    switch (central.state) {
        case CBCentralManagerStateUnknown:
            state = @"CBCentralManager State Unknown";
            break;
        case CBCentralManagerStateResetting:
            state = @"CBCentralManager State Resetting";
            break;
        case CBCentralManagerStateUnsupported:
            state = @"CBCentralManager State Unsupported";
            break;
        case CBCentralManagerStateUnauthorized:
            state = @"CBCentralManager State Unauthorized";
            break;
        case CBCentralManagerStatePoweredOff:
            state = @"CBCentralManager State PoweredOff";
            break;
        case CBCentralManagerStatePoweredOn:
        {
            state = @"CBCentralManager State PoweredOn ";
            [self searchService];
        }
            break;
            
        default:
            state = @"CBCentralManager State Error ";
            break;
    }
    
     NSLog(@"Central manager state: %@", state);
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *, id> *)advertisementData RSSI:(NSNumber *)RSSI {
    
    [central stopScan];
    if(self.delegate && [self.delegate respondsToSelector:@selector(centralClient:didRecieveAdvertisementData:)]){
        [self.delegate centralClient:self didRecieveAdvertisementData:advertisementData];
    }
    self.peripheral = peripheral;
    NSDictionary *op = @{CBConnectPeripheralOptionNotifyOnDisconnectionKey:@(YES)
                         
                         };
    [central connectPeripheral:peripheral options:op];
    if(self.delegate && [self.delegate respondsToSelector:@selector(didStartConnect:)]){
        [self.delegate didStartConnect:self ];
    }
    
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"Connect peripheral %@ success!",peripheral);
    peripheral.delegate = self;
    [peripheral discoverServices:@[self.serviceUUID]];
}


- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {
    NSLog(@"didFailToConnectPeripheral %@ error %@",peripheral,error);
    [self searchService];
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {
    
    NSLog(@"didDisconnectPeripheral peripheral %@ error %@ ",peripheral,error);
    [self searchService];
}

#pragma mark--CBPeripheralDelegate

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(nullable NSError *)error {
    
    if(error){
        return;
    }
    NSLog(@"didDiscoverServices %@",peripheral.services);
    for (CBService *service in peripheral.services) {
        [peripheral discoverCharacteristics:@[self.characteristicUUID] forService:service];
        self.service = service;
        break;
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(nullable NSError *)error {
    if(error){
        return;
    }
    NSLog(@"didDiscoverCharacteristicsForService %@",service.characteristics);
    for (CBCharacteristic *characteristic in service.characteristics) {
       // [peripheral readValueForCharacteristic:characteristic];
        self.characteristic = characteristic;
        [peripheral setNotifyValue:YES forCharacteristic:characteristic];
        break;
    }
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(didCompleteConnect:)]){
        [self.delegate didCompleteConnect:self ];
    }
    
}

-(void)peripheral:(CBPeripheral *)peripheral
didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic
            error:(NSError *)error {
    NSData *data = characteristic.value;
    NSString *printable = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"didUpdateValueForCharacteristic%@  value = %@",characteristic,printable);
    if(self.delegate && [self.delegate respondsToSelector:@selector(centralClient:didRecieveSubscribeData:)]){
        [self.delegate centralClient:self didRecieveSubscribeData:data];
    }
}


- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
      NSLog(@"didWriteValueForCharacteristic%@  error = %@",characteristic,error);
}

- (void)peripheral:(CBPeripheral *)peripheral
didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic
             error:(NSError *)error {
    if (error) {
        NSLog(@"didUpdateNotificationStateForCharacteristic Error: %@",
              [error localizedDescription]);
        return;
    }
    NSData *data = characteristic.value;
    NSString *value = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"notification value for data %@", value);
    if(self.delegate && [self.delegate respondsToSelector:@selector(centralClient:didRecieveSubscribeData:)]){
        [self.delegate centralClient:self didRecieveSubscribeData:data];
    }
}

#pragma mark-- ivars
- (CBCentralManager *)centralManager {
    if(!_centralManager) {
        _centralManager = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
    }
    return _centralManager;
}
- (CBUUID*)serviceUUID {
    if(!_serviceUUID) {
        _serviceUUID = [CBUUID UUIDWithString:self.serviceID];
    }
    return _serviceUUID;
}
- (CBUUID*)characteristicUUID {
    if(!_characteristicUUID) {
        _characteristicUUID =  [CBUUID UUIDWithString:self.characteristicID];
    }
    return _characteristicUUID;
}
@end
