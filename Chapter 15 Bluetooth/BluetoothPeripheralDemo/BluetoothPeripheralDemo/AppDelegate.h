//
//  AppDelegate.h
//  BluetoothPeripheralDemo
//
//  Created by zhaojw on 15/10/24.
//  Copyright © 2015年 http://macdev.io All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (weak) IBOutlet NSTextField *valueTextField;


- (IBAction)notifyValueAction:(id)sender;

@end

