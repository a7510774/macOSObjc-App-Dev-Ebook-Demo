//
//  AppDelegate.m
//  BindDemo
//
//  Created by zhaojw on 15/9/25.
//  Copyright © 2015年 zhaojw. All rights reserved.
//

#import "AppDelegate.h"
#import "Emploee.h"
#import "NSObject+Description.h"
@interface AppDelegate ()
@property (weak) IBOutlet NSWindow *window;
@property(nonatomic,strong)Emploee *emploee;
@property (strong) IBOutlet NSObjectController *objectController;
@property(nonatomic,strong)NSArray *arrary;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    Emploee *em = [[Emploee alloc]init];
    
    em.id = 123213123;
    
    em.name = @"John";
    
    em.address = @"China Beijing";
    
    em.age = 25;
    
   self.emploee  = em;
    
    NSDictionary *options = @{ NSAllowsEditingMultipleValuesSelectionBindingOption:@YES };
    
    NSObjectController *g;
    NSArrayController *hhh;
    
//   [self.objectController bind:@"contentObject"
//                      toObject:self
//                   withKeyPath:@"emploee"
//                       options:options];
    
    
   
    [self.objectController setContent:self.emploee];
  

    NSArray *ss = @[
                    
                    @{@"key":@"1"},
                     @{@"key":@"2"},
                     @{@"key1":@"1"},
                    
                    ];
    
    self.arrary = ss;
    
    
    
    NSArray *dd = [self.arrary mutableArrayValueForKey:@"key"];
    
    NSString *hh;
    
    NSArray *dd1 = [self.arrary valueForKey:@"key"];
    
    
     NSString *hh1;
    
}


- (void)objectDidBeginEditing:(id)editor
{
    NSLog(@"sdfsfs");
}
- (void)objectDidEndEditing:(id)editor
{
    NSLog(@"sdfsfs");
}

- (void)discardEditing
{
     NSLog(@"sdfsfs");
}
- (BOOL)commitEditing
{
    return YES;
}
- (BOOL)commitEditingAndReturnError:(NSError **)error
{
    return NO;
}
- (IBAction)okAction:(id)sender
{
    
    NSLog(@"emploee = %@",[self.emploee objectAsDictionary]);
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
