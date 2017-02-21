//
//  AppDelegate.m
//  NSPanel
//
//  Created by zhaojw on 15/8/27.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
@property (weak) IBOutlet NSPanel *loginPanel;

@property (weak) IBOutlet NSTextField *userNameField;
@property (weak) IBOutlet NSTextField *passwordField;

@property (strong)NSFont *font;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    _font = [NSFont boldSystemFontOfSize:12];
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (IBAction)loginButtonClicked:(id)sender
{
    
    
    [ self.window beginSheet:self.loginPanel completionHandler:^(NSModalResponse returnCode) {
        
        NSString *userName = self.userNameField.stringValue;
        NSString *password = self.passwordField.stringValue;
        
        NSLog(@"userName %@",userName);
        NSLog(@"password %@",password);
        
    }];
    
    
    
}


- (IBAction)oKButtonClicked:(id)sender {

    [self.window endSheet:self.loginPanel];
}


- (IBAction)colorButtonClicked:(id)sender {

    NSColorPanel *colorpanel = [NSColorPanel sharedColorPanel];
    [colorpanel setAction:@selector(changeColor:)];
    [colorpanel setTarget:self];
    [colorpanel orderFront:nil];
}

- (void)changeColor:(id)sender {
    NSColorPanel *colorPanel = sender ;
    NSColor* color = colorPanel.color;
    NSLog(@"color %@",color);
}



- (IBAction)fontButtonClicked:(id)sender {
    
    NSFontManager *fontManager = [NSFontManager sharedFontManager];
    [fontManager setTarget:self];
    [fontManager orderFrontFontPanel:self];
}

- (void)changeFont:(id)sender {
    
    self.font = [sender convertFont:self.font];
    
    NSLog(@"sender %@ font %@",sender,self.font);
    
}

@end
