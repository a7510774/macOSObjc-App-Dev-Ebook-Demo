//
//  AppDelegate.m
//  NSSearchField
//
//  Created by zhaojw on 15/8/26.
//  Copyright (c) 2015年 http://macdev.io All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSSearchField *searchField;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    [self registerSearchButtonAction];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (void)registerSearchButtonAction {

    NSActionCell *searchButtonCell = [[self.searchField cell] cancelButtonCell];
    
    NSActionCell *cancelButtonCell = [[self.searchField cell] cancelButtonCell];
    
    
    searchButtonCell.target = self;
    
    searchButtonCell.action = @selector(searchButtonClicked:);
    
    cancelButtonCell.target = self;
    
    cancelButtonCell.action = @selector(cancelButtonClicked:);
    
}


- (IBAction)searchButtonClicked:(id)sender {

    NSSearchField *searchField = sender;
    
    NSString *content = searchField.stringValue;
    
    NSLog(@"searchButtonClicked %@",content);
}


- (IBAction)cancelButtonClicked:(id)sender {

       NSLog(@"cancelButtonClicked");
}


- (IBAction)searchAction:(id)sender {
    NSSearchField *searchField = sender;
    
    NSString *content = searchField.stringValue;
    
    NSLog(@"content %@",content);
}
@end
