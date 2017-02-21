//
//  AppDelegate.m
//  NSTableViewCustomCell
//
//  Created by zhaojw on 15/10/31.
//  Copyright © 2015年 zhaojw. All rights reserved.
//

#import "AppDelegate.h"
#import "HoverTableRowView.h"
@interface AppDelegate ()<NSTableViewDelegate,NSTableViewDelegate>

@property (weak) IBOutlet NSWindow *window;

@property (weak) IBOutlet NSTableView *tableView;

@property (nonatomic,strong) NSArray *datas;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    self.datas = @[
                   @{@"name":@"john",@"address":@"USA"},
                   @{@"name":@"mary",@"address":@"China"},
                   @{@"name":@"park",@"address":@"Japan"},
                   @{@"name":@"Daba",@"address":@"Russia"},
                   
                   ];
    
    
    //self.tableView.backgroundColor = [NSColor blackColor];
    
   
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
    
}

- (nullable NSTableRowView *)tableView:(NSTableView *)tableView rowViewForRow2:(NSInteger)row NS_AVAILABLE_MAC(10_7) {
    
    HoverTableRowView *hoverRow =[[HoverTableRowView alloc]init];
    
    CGRect frame = CGRectMake(0, 0, 100, 40);
    
    hoverRow.frame = frame;
    
    return hoverRow;
    
}
- (void)tableView:(NSTableView *)tableView didAddRowView2:(NSTableRowView *)rowView forRow:(NSInteger)row {
    
    if (1) {
        rowView.backgroundColor = [NSColor redColor];
    }
}

@end
