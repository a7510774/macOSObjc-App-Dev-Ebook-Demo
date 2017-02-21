
//
//  XXXPeripheralService.m
//  OpenMacX
//
//  Created by zhaojw on 12/17/15.
//  Copyright © 2015 zhaojw. All rights reserved.
//

#import "XXXPeripheralService.h"
#import <CoreBluetooth/CoreBluetooth.h>
@interface XXXPeripheralService ()<CBPeripheralManagerDelegate>

@property(nonatomic,copy)   NSString                 *serviceID;
@property(nonatomic,copy)   NSString                 *characteristicID;
@property(nonatomic,strong) CBUUID                   *serviceUUID;
@property(nonatomic,strong) CBUUID                   *characteristicUUID;

@property(nonatomic,strong) CBPeripheralManager      *peripheralManager;
@property(nonatomic,strong) CBMutableService         *service;
@property(nonatomic,strong) CBMutableCharacteristic  *characteristic;

@end

@implementation XXXPeripheralService
- (instancetype)initWithServiceID:(NSString*)serviceID characteristicID:(NSString*)characteristicID {
    self=[super init];
    if(self){
        _serviceID         = serviceID;
        _characteristicID  = characteristicID;
    }
    return self;
}

#pragma mark- Service Interface
- (void)startService {
    NSLog(@"XXXPeripheralService Init State %ld",self.peripheralManager.state);
}

- (void)stopService {
    [self disableService];
}

- (void)nofifySubscribeData:(NSData*)data {
    
    BOOL didSendValue = [self.peripheralManager updateValue:data
                                          forCharacteristic:self.characteristic onSubscribedCentrals:nil];
    if(didSendValue){
        NSLog(@"notify ok!");
    }
}

- (void)disableService {
    [self.peripheralManager stopAdvertising];
    [self.peripheralManager removeService:self.service];
    _service = nil;
    _characteristic = nil;
}

- (void)publishService {
    if(self.peripheralManager.isAdvertising){
        [self disableService];
    }
    [self.peripheralManager addService:self.service];
}

- (void)advertiseService {
    [self.peripheralManager startAdvertising:@{
                                               CBAdvertisementDataServiceUUIDsKey:@[self.service.UUID],
                                               CBAdvertisementDataLocalNameKey:self.peripheralIdentifier
                                               }];
    
}
#pragma mark-- CBPeripheralManagerDelegate
//Peripheral State Update Delegate Callback
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
    NSString *status;
    CBPeripheralManagerState state = [peripheral state];
 
    switch (state)
    {
        case CBPeripheralManagerStateUnknown:
            status = @"Bluetooth State Unknown!";
            break;
        case CBPeripheralManagerStateResetting:
            status = @"Bluetooth State Resetting!";
            break;
        case CBPeripheralManagerStateUnsupported:
            status = @"The platform/hardware doesn't support Bluetooth Low Energy.";
            break;
        case CBPeripheralManagerStateUnauthorized:
            status = @"The app is not authorized to use Bluetooth Low Energy.";
            break;
        case CBPeripheralManagerStatePoweredOff:
            status = @"Bluetooth is currently powered off.";
            [self disableService];
            break;
        case CBPeripheralManagerStatePoweredOn:
            status = @"Bluetooth is currently powered on .";
        {
            [self publishService];
        }
            break;
        
        default:
            status = @"Bluetooth State error!";
    }
 
    NSLog(@"Central manager status: %@", status);
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(nullable NSError *)error {
    
    if(error) {
        NSLog(@"didAddService %@ ",error);
        return;
    }
    [self advertiseService];
}

- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(nullable NSError *)error {
    
    if(error) {
        NSLog(@"advertising %@ ",error);
        return;
    }
    NSLog(@"peripheralManager %@ did advertising !", peripheral);
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral
    didReceiveReadRequest:(CBATTRequest *)request {
    if ([request.characteristic.UUID isEqual:self.characteristic.UUID]) {
        NSLog(@"didReceiveReadRequest %@ ", peripheral);
        
        if (request.offset > self.characteristic.value.length) {
            [peripheral respondToRequest:request
                              withResult:CBATTErrorInvalidOffset];
            return;
        }
        NSRange range = NSMakeRange(request.offset,self.characteristic.value.length - request.offset);
        request.value = [self.characteristic.value subdataWithRange:range];
        [peripheral respondToRequest:request withResult:CBATTErrorSuccess];
    }
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveWriteRequests:(NSArray<CBATTRequest *> *)requests {
    CBATTRequest *request = requests[0];
    if ([request.characteristic.UUID isEqual:self.characteristic.UUID]) {
        NSLog(@"didReceiveWriteRequests %@ ", peripheral);
        self.characteristic.value = request.value;
        [peripheral respondToRequest:request withResult:CBATTErrorSuccess];
        if(self.delegate && [self.delegate respondsToSelector:@selector(peripheralService:didRecieveWriteData:)]) {
            [self.delegate peripheralService:self didRecieveWriteData:request.value];
        }
    }
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral
                  central:(CBCentral *)central
                  didSubscribeToCharacteristic:(CBCharacteristic *)characteristic {
    
    NSString *value = @"Update Data";
    NSData *updatedValue;
    if(self.delegate && [self.delegate respondsToSelector:@selector(peripheralServiceSubscribeData:)]){
        updatedValue = [self.delegate peripheralServiceSubscribeData:self];
    }
    if(!updatedValue) {
        updatedValue = [value dataUsingEncoding:NSUTF8StringEncoding];
    }
   
    BOOL didSendValue = [peripheral updateValue:updatedValue
                              forCharacteristic:self.characteristic onSubscribedCentrals:nil];
    if(didSendValue){
        NSLog(@"didSubscribeToCharacteristic value %@ ",value);
    }
}

#pragma mark--  vars

- (CBPeripheralManager*)peripheralManager {
    if(!_peripheralManager) {
        _peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
    }
    return _peripheralManager;
}
- (CBMutableService*)service {
    if(!_service) {
        _service = [[CBMutableService alloc]initWithType:self.serviceUUID primary:YES];
        _service.characteristics = @[self.characteristic];
    
    }
    return _service;
}
- (CBMutableCharacteristic*)characteristic {
    if(!_characteristic){
       
        _characteristic = [[CBMutableCharacteristic alloc] initWithType:self.characteristicUUID
                                                             properties:CBCharacteristicPropertyWrite|CBCharacteristicPropertyNotify
                                                                  value:nil permissions:CBAttributePermissionsWriteable];
    }
    return _characteristic;
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
