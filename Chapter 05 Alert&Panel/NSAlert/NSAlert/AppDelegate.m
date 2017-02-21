//
//  AppDelegate.m
//  NSAlert
//
//  Created by zhaojw on 15/8/26.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;

@property (weak) IBOutlet NSTextField *useNamerField;
@property (weak) IBOutlet NSTextField *passwordField;
@property (weak) IBOutlet NSTextField *confirmPasswordField;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    
    NSColorPanel *dfg;
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (IBAction)registerButtonClicked:(id)sender
{
    
    NSString *password = self.passwordField.stringValue;
    
    if([password length]<6)
    {
        
        NSAlert *alert = [[NSAlert alloc] init];
       
        //增加一个按钮
        [alert addButtonWithTitle:@"Ok"];
        
        [alert addButtonWithTitle:@"Cancel"];
        
        
        [alert addButtonWithTitle:@"F3"];
        
        //提示的标题
        [alert setMessageText:@"Alert"];
        
        //提示的详细内容
        [alert setInformativeText:@"password length must be more than 6 "];
        //设置告警风格
        [alert setAlertStyle:NSCriticalAlertStyle];
        
        //开始显示告警
        [alert beginSheetModalForWindow:self.window
                      completionHandler:^(NSModalResponse returnCode){
                          
                          NSLog(@"returnCode %ld",returnCode);
                          //用户点击告警上面的按钮后的回调
                          
                      }
         ];
        
        return;
    }
    
    
}
@end
