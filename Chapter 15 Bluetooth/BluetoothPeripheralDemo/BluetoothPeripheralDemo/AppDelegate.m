//
//  AppDelegate.m
//  BluetoothPeripheralDemo
//
//  Created by zhaojw on 15/10/24.
//  Copyright © 2015年 http://macdev.io All rights reserved.
//

#import "AppDelegate.h"
#import <CoreBluetooth/CoreBluetooth.h>

#define  kServiceUUID           @"84941CC5-EA0D-4CAE-BB06-1F849CCF8495"

#define  kCharacteristicUUID    @"2BCD"

@interface AppDelegate () <CBPeripheralManagerDelegate>

@property (weak) IBOutlet NSWindow *window;

@property(nonatomic,strong)CBPeripheralManager *peripheralManager;

@property(nonatomic,strong)CBMutableService *service;

@property(nonatomic,strong)CBMutableCharacteristic *characteristic;

@property(nonatomic,strong)CBUUID *serviceUUID;

@property(nonatomic,strong)CBUUID *characteristicUUID;

@property(nonatomic,assign)BOOL notified;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    self.notified = NO;
    NSLog(@"peripheralManager init state %ld",self.peripheralManager.state);
}

- (IBAction)notifyValueAction:(id)sender {
    NSString *value = self.valueTextField.stringValue;
    if(value) {
        
        NSData *updatedValue = [value dataUsingEncoding:NSUTF8StringEncoding];
        BOOL didSendValue = [self.peripheralManager updateValue:updatedValue
                                           forCharacteristic:self.characteristic onSubscribedCentrals:nil];
        
        if(didSendValue){
            NSLog(@"notify ok!");
        }
    }
    
}

- (void)publishService {
    [self.peripheralManager removeService:self.service];
    [self.peripheralManager addService:self.service];
}

- (void)advertiseService {
    [self.peripheralManager startAdvertising:@{
                                               CBAdvertisementDataServiceUUIDsKey:@[self.service.UUID],
                                               CBAdvertisementDataLocalNameKey:@"RadioChannel"
                                               }];
    

}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

#pragma mark-- CBPeripheralManagerDelegate

//Peripheral State Update Delegate Callback
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
    
    NSString *state;
    
    switch ([peripheral state])
    {
        case CBCentralManagerStateUnsupported:
            state = @"The platform/hardware doesn't support Bluetooth Low Energy.";
            break;
        case CBCentralManagerStateUnauthorized:
            state = @"The app is not authorized to use Bluetooth Low Energy.";
            break;
        case CBCentralManagerStatePoweredOff:
            state = @"Bluetooth is currently powered off.";
            break;
        case CBCentralManagerStatePoweredOn:
            state = @"Bluetooth is currently powered on .";
        {
            [self publishService];
          
        }
             break;
        case CBCentralManagerStateUnknown:
        default:
           state = @"Bluetooth State Unknown";
    }
    
    NSLog(@"Central manager state: %@", state);
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
        request.value = [self.characteristic.value
        
                         subdataWithRange:NSMakeRange(request.offset,
                                      self.characteristic.value.length - request.offset)];
        [peripheral respondToRequest:request withResult:CBATTErrorSuccess];
    }
    
}


- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveWriteRequests:(NSArray<CBATTRequest *> *)requests {
    
    CBATTRequest *request = requests[0];
    if ([request.characteristic.UUID isEqual:self.characteristic.UUID]) {
        NSLog(@"didReceiveWriteRequests %@ ", peripheral);
        self.characteristic.value = request.value;
        [peripheral respondToRequest:request withResult:CBATTErrorSuccess];
    }
}


- (void)peripheralManager:(CBPeripheralManager *)peripheral
                  central:(CBCentral *)central
didSubscribeToCharacteristic:(CBCharacteristic *)characteristic {
    
    NSString *value = @"Update Data";
    
    NSData *updatedValue = [value dataUsingEncoding:NSUTF8StringEncoding];
    
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
        
        if(self.notified){
               _characteristic = [[CBMutableCharacteristic alloc] initWithType:self.characteristicUUID
                                                            properties:CBCharacteristicPropertyNotify
                                                                 value:nil permissions:CBAttributePermissionsWriteable];
        
        }
        else {
            
            NSString *value = @"Start Data";
            
            NSData *valueData = [value dataUsingEncoding:NSUTF8StringEncoding];
            
            _characteristic = [[CBMutableCharacteristic alloc] initWithType:self.characteristicUUID
                                                                 properties:CBCharacteristicPropertyRead
                                                                      value:valueData permissions:CBAttributePermissionsReadable];
            
            
        
            
        }
       
    }
    return _characteristic;
}

- (CBUUID*)serviceUUID {
    if(!_serviceUUID) {
      _serviceUUID =
        
        [CBUUID UUIDWithString:kServiceUUID];
    }
    return _serviceUUID;
}

- (CBUUID*)characteristicUUID {
    if(!_characteristicUUID) {
        _characteristicUUID =  [CBUUID UUIDWithString:kCharacteristicUUID];
    }
    return _characteristicUUID;
}

@end
