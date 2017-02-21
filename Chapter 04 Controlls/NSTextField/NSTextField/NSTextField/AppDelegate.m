//
//  AppDelegate.m
//  NSTextField
//
//  Created by iDevFans on 16/10/25.
//  Copyright © 2016年 macdev. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()<NSTextFieldDelegate>

@property (weak) IBOutlet NSWindow *window;

@property (weak) IBOutlet NSTextField *usrNameField;

@property (weak) IBOutlet NSSecureTextField *passwordField;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (IBAction)okButtonClicked:(id)sender {
    
    NSString *userName = self.usrNameField.stringValue;
    NSString *password = self.passwordField.stringValue;
    
    NSLog(@"username:%@ password:%@",userName,password);
}


#pragma mark-- NSTextField
- (void)controlTextDidBeginEditing:(NSNotification *)obj {
    id text = obj.object;
    
    if(text==self.usrNameField){
        
        NSLog(@"controlTextDidBeginEditing usrNameField %@",self.usrNameField.stringValue);
    }
    
    if(text==self.passwordField){
        
        NSLog(@"controlTextDidBeginEditing passwordField %@",self.passwordField.stringValue);
    }
    
}

- (void)controlTextDidEndEditing:(NSNotification *)obj {
    id text = obj.object;
    if(text==self.usrNameField){
        
        NSLog(@"controlTextDidEndEditing usrNameField %@",self.usrNameField.stringValue);
    }
}


- (void)controlTextDidChange:(NSNotification *)obj {
    id text = obj.object;
    if(text==self.usrNameField){
        
        NSLog(@"controlTextDidChange usrNameField %@",self.usrNameField.stringValue);
    }
}

@end

