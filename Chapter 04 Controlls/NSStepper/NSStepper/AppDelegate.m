//
//  AppDelegate.m
//  NSStepper
//
//  Created by zhaojw on 15/9/2.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;

@property (weak) IBOutlet NSTextField *pageSizeTextField;
@property (weak) IBOutlet NSStepper   *pageSizeStepper;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    [self.pageSizeTextField setIntValue:0];
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (IBAction)stepperAction:(id)sender
{
    int theValue = [sender intValue];
  
    [self.pageSizeTextField setIntValue:theValue];
    
}


- (void)controlTextDidChange:(NSNotification *)notification {
   
    NSTextField *textField = [notification object];
    
    [self.pageSizeStepper setIntValue: [textField intValue] ];
   

}


@end
