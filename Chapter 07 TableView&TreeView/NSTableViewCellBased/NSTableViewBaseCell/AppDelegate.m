//
//  AppDelegate.m
//  NSTableViewBaseCell
//
//  Created by zhaojw on 15/8/29.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()<NSTableViewDelegate,NSTableViewDataSource>

- (IBAction)tableView:(id)sender;

@property (weak) IBOutlet NSWindow *window;

@property (weak) IBOutlet NSTableView *tableView;

@property(nonatomic,strong)NSArray *datas;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    //初始化数据
    self.datas = @[
                   
                   @{@"name":@"john",@"address":@"USA",@"gender":@"male",@"married":@(1)},
                   @{@"name":@"mary",@"address":@"China",@"gender":@"female",@"married":@(0)},
                   @{@"name":@"park",@"address":@"Japan",@"gender":@"male",@"married":@(0)},
                   @{@"name":@"Daba",@"address":@"Russia",@"gender":@"female",@"married":@(1)},
                   
                   ];
    
    
    //self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //更新表格
    [self.tableView reloadData];
    
}


#pragma mark- TableViewDataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView;
{
    //返回表格共有多少行数据
    return [self.datas count];
}


- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row;
{
    NSDictionary *data = self.datas[row];
    
    //表格列的标识
    NSString *key = tableColumn.identifier;
    
    //单元格数据
    NSString *value = data[key];
    
    
    return value;

    
}


- (void)tableView:(NSTableView *)tableView setObjectValue:(id)object forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row;

{
    
}
@end
