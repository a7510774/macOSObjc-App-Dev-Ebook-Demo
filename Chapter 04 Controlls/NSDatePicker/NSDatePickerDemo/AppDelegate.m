//
//  AppDelegate.m
//  NSDatePickerDemo
//
//  Created by zhaojw on 15/10/28.
//  Copyright © 2015年 zhaojw. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
@property (weak) IBOutlet NSDatePicker *datePicker;

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (IBAction)valuedChangedAction:(id)sender {
    NSDatePicker *datePicker = sender;
    NSLog(@"valued Changed dateValue %@",datePicker.dateValue);
}

- (void)datePickerCell:(NSDatePickerCell *)aDatePickerCell validateProposedDateValue:(NSDate * __nonnull *__nonnull)proposedDateValue timeInterval:(nullable NSTimeInterval *)proposedTimeInterval {
    
    NSLog(@"proposedDateValue %@",*proposedDateValue);
    NSDate *date = *proposedDateValue;
    NSDate *newDate = [date dateByAddingTimeInterval:200000];
    self.datePicker.dateValue = newDate;//*(proposedTimeInterval);
    
}


@end
