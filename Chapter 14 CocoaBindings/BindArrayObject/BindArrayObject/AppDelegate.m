//
//  AppDelegate.m
//  BindArrayObject
//
//  Created by iDevFans on 2016/11/4.
//  Copyright © 2016年 macdev. All rights reserved.
//

#import "AppDelegate.h"
#import "Employee.h"
@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;

@property(nonatomic,strong)NSMutableArray *employees;

@property(strong) IBOutlet NSArrayController *arrayController;


@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    NSDictionary *options = @{ NSAllowsEditingMultipleValuesSelectionBindingOption:@YES };
    [self.arrayController bind:@"contentArray"
                      toObject:self
                   withKeyPath:@"employees"
                       options:options];
    
    [self configData];
}


- (void)configData {
    
    Employee *e1 = [[Employee alloc]init];
    e1.id = 1;
    e1.name = @"mark";
    e1.age = 10;
    e1.address = @"beijing";
    
    
    Employee *e2 = [[Employee alloc]init];
    e2.id = 2;
    e2.name = @"john";
    e2.age = 20;
    e2.address = @"hongkong";
  
    self.employees =  [NSMutableArray arrayWithArray:@[e1,e2]];

}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
