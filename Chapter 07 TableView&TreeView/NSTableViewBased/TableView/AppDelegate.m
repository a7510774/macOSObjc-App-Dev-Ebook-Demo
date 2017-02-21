//
//  AppDelegate.m
//  TableView
//
//  Created by zhaojw on 15/8/27.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()<NSTableViewDelegate,NSTableViewDataSource>

@property (weak) IBOutlet NSWindow *window;

@property (weak) IBOutlet NSTableView *tableView;


@property(nonatomic,strong)NSArray *datas;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    //初始化数据
    [self.tableView enclosingScrollView].hasVerticalScroller = YES;
    [self.tableView enclosingScrollView].hasHorizontalScroller = YES;
    [self.tableView enclosingScrollView].autohidesScrollers= NO;
    self.datas = @[
                   
                   @{@"name":@"john",@"address":@"USA",@"gender":@"male",@"married":@(1)},
                   @{@"name":@"mary",@"address":@"China",@"gender":@"female",@"married":@(0)},
                   @{@"name":@"park",@"address":@"Japan",@"gender":@"male",@"married":@(0)},
                   @{@"name":@"Daba",@"address":@"Russia",@"gender":@"female",@"married":@(1)},
                   
                   
                   ];
    
    //更新表格
    [self.tableView reloadData];
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


#pragma mark- TableViewDelegate

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    
    //获取row数据
    NSDictionary *data = self.datas[row];
    
    //表格列的标识
    NSString *key = tableColumn.identifier;
    
    //单元格数据
    id value = data[key];
    
    //根据表格列的标识,创建单元视图
    NSView *view = [tableView makeViewWithIdentifier:key owner:self];
    
    
    NSArray *subviews = [view subviews];
    
    if([subviews count]>0){
        
        
        if([key isEqualToString:@"name"] || [key isEqualToString:@"address"]){
            //获取文本控件
            NSTextField *textField = subviews[0];
            if(value){
                //更新单元格的文本
                textField.stringValue = value;
            }
        }
        
        if([key isEqualToString:@"gender"] ){
            //获取文本控件
            NSComboBox *comboField = subviews[0];
            if(value){
                //更新单元格的文本
                comboField.stringValue = value;
            }
        }
        
        if([key isEqualToString:@"married"] ){
            //获取文本控件
            NSButton *checkBoxField = subviews[0];
            if(value){
                //更新单元格的文本
                checkBoxField.state = [value boolValue];
            }
        }
        
    }
    
    return view;
}


#pragma mark- TableViewDataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView;
{
    //返回表格共有多少行数据
    return [self.datas count];
}


@end
