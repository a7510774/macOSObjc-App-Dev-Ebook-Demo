//
//  AppDelegate.m
//  NSTableViewEditCell
//
//  Created by zhaojw on 15/8/29.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()<NSTableViewDataSource>

@property (weak) IBOutlet NSTableView *tableView;

@property (weak) IBOutlet NSWindow *window;


@property(nonatomic,strong)NSMutableArray *datas;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
   
    
    
    //初始化数据
    NSArray *rowsData = @[
                   
                   @{@"name":@"john",@"address":@"USA"},
                   @{@"name":@"mary",@"address":@"China"},
                   @{@"name":@"park",@"address":@"Japan"},
                   @{@"name":@"Daba",@"address":@"Russia"},
                   
                   ];
    
    self.datas = [NSMutableArray arrayWithArray:rowsData];
    
    //self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //更新表格
    [self.tableView reloadData];
    
}


- (IBAction)addTableRowButtonClicked:(id)sender {

    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    
    data[@"name"]=@"";
    
    data[@"address"]=@"";
    
    //增加数据到datas数据区
    [self.datas addObject:data];
    
    //刷新表数据
    [self.tableView reloadData];
    
    //定位光标到新添加的行
    [self.tableView editColumn:0 row:([self.datas count] - 1) withEvent:nil select:YES];
}


- (IBAction)removeTableRowButtonClicked1:(id)sender {

    //表格当前选择的行
    NSInteger  row = self.tableView.selectedRow;
    
    //如果row小于0表示没有选择行
    if(row<0){
        return;
    }
    //从数据区删除选择的行的数据
    [self.datas removeObjectAtIndex:row];
    
    [self.tableView reloadData];
    
}

- (IBAction)removeTableRowButtonClicked:(id)sender {
    //表格当前选择的行
    NSIndexSet  *rowIndexes = self.tableView.selectedRowIndexes;
    
    //如果row小于0表示没有选择行
    if(!rowIndexes){
        return;
    }
    
    
    [self.tableView beginUpdates];
    [self.tableView removeRowsAtIndexes:rowIndexes withAnimation:NSTableViewAnimationSlideUp];
    [self.tableView endUpdates];
    
    
    //从数据区删除选择的行的数据
    [self.datas removeObjectsAtIndexes:rowIndexes];
    
    //[self.tableView reloadData];
    
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
    NSDictionary *data = self.datas[row];

    //将row数据转化为可修改的字典对象
    NSMutableDictionary *editData = [NSMutableDictionary dictionaryWithDictionary:data];
    
    //表格列的标识
    NSString *key = tableColumn.identifier;
    
    //更新字典key对应的值为用户编辑的内容
    editData[key] = object;
    
    //更新row数据区
    self.datas[row] = [editData copy];
}


@end
