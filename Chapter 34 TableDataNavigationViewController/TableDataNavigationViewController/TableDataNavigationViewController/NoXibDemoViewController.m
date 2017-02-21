//
//  NoXibDemoViewController.m
//  TableDataNavigationViewController
//
//  Created by MacDev on 16/6/13.
//  Copyright © 2016年 http://www.macdev.io All rights reserved.
//

#import "NoXibDemoViewController.h"
#import "DataPageManager.h"
#import "DataNavigationView.h"
#import "DemoViewDataDelegate.h"
#import "TableColumnItem.h"
#import "NSTableView+Category.h"
@interface NoXibDemoViewController ()
@property(nonatomic,strong)NSMutableArray *datas;
@property(nonatomic,strong)DemoViewDataDelegate  *dataDelegate;
@end

@implementation NoXibDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    [self tableViewColumnConfig];
    
    //make test datas
    [self makeTestDatas];
    
    //计算分页数据
    self.pageManager.pageSize = 10;
    [self.pageManager computePageNumbers];
    //导航到第一页
    [self.pageManager goFirstPage];
    //更新导航面板分页提示信息
    [self updatePageInfo];
}




#pragma mark ***** PaginatorDelegate *****

- (void)paginator:(id)paginator requestDataWithPage:(NSInteger)page pageSize:(NSInteger)pageSize {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        NSArray *datas =  [self findByPage:page pageSize:pageSize];
        [self.dataDelegate setData:datas];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [self updatePageInfo];
        });
    });
}

- (NSInteger)totalNumberOfData:(id)paginator {
    return  [self.datas count];
}


/*
 一个基本的数组分页算法
 */
- (NSArray*)findByPage:(NSInteger)index pageSize:(NSInteger)pageSize{
    
    NSInteger  count = [self.datas count];
    
    if(count<=0){
        return [NSArray array];
    }
    
    NSInteger  fromIndex = index * pageSize;
    NSInteger  toIndex   = fromIndex + pageSize;
    
    NSInteger  validPageSize = pageSize;
    
    if(toIndex>count){
        validPageSize = count - fromIndex ;
    }
    
    NSArray *subDatas = [self.datas subarrayWithRange:NSMakeRange(fromIndex, validPageSize)];
    
    return subDatas;
}


- (void)tableViewColumnConfig {
    NSArray *items =[self tableColumnItems];
    if(items){
        [self.tableView xx_updateColumnsWithItems:items];
    }
}

- (void)tableDelegateConfig {
    self.tableView.delegate   = self.dataDelegate;
    self.tableView.dataSource = self.dataDelegate;
    self.dataDelegate.owner = self.tableView;
}


- (void)makeTestDatas {
    
    NSImage *image = [NSImage imageNamed:NSImageNameComputer];
    NSImage *folderImage = [NSImage imageNamed:NSImageNameFolder];
    NSImage *advancedImage = [NSImage imageNamed:NSImageNameAdvanced];
    NSImage *unavailableImage = [NSImage imageNamed:NSImageNameStatusUnavailable];
    
    NSDictionary *row1 = @{ @"field":@"name",@"type":@"text",@"size":@"10",@"primary":@(1) , @"image":image};
    
    NSDictionary *row2 = @{ @"field":@"address",@"type":@"text",@"size":@"14",@"primary":@(0),@"image":folderImage };
    
    NSDictionary *row3 = @{ @"field":@"age",@"type":@"int",@"size":@"8",@"primary":@(0),@"image":advancedImage };
    
    NSDictionary *row4 = @{ @"field":@"phone",@"type":@"text",@"size":@"6",@"primary":@(0),@"image":image};
    
    NSDictionary *row5 = @{ @"field":@"city",@"type":@"text",@"size":@"12",@"primary":@(0), @"image":unavailableImage};
    
    NSDictionary *row6 = @{ @"field":@"phone2",@"type":@"text",@"size":@"10",@"primary":@(0) ,@"image":image};
    
    NSDictionary *row7 = @{ @"field":@"city2",@"type":@"text",@"size":@"20",@"primary":@(0), @"image":advancedImage};
    
    NSDictionary *row8 = @{ @"field":@"name2",@"type":@"text",@"size":@"13",@"primary":@(0) ,@"image":folderImage};
    
    NSDictionary *row9 = @{ @"field":@"address2",@"type":@"text",@"size":@"15",@"primary":@(0),@"image":unavailableImage };
    
    NSDictionary *row10 = @{ @"field":@"age",@"type":@"int",@"size":@"8",@"primary":@(0),@"image":advancedImage };
    NSDictionary *row11 = @{ @"field":@"phone",@"type":@"text",@"size":@"10",@"primary":@(0),@"image":advancedImage};
    
    NSDictionary *row12 = @{ @"field":@"city",@"type":@"text",@"size":@"16",@"primary":@(0) ,@"image":folderImage};
    
    NSDictionary *row13 = @{ @"field":@"phone",@"type":@"text",@"size":@"10",@"primary":@(0) };
    NSDictionary *row14 = @{ @"field":@"city",@"type":@"text",@"size":@"30",@"primary":@(0),@"image":image };
    
    NSArray *datas = @[row1,row2,row3,row4,row5,row6,row7,row8,row9,row10,row11,row12,row13,row14];
    
    self.datas = [NSMutableArray array];
    for(NSDictionary *data in datas) {
        NSMutableDictionary *dataTemp =  [NSMutableDictionary dictionaryWithDictionary:data];
        [self.datas addObject:dataTemp];
    }
    
}



- (NSArray*)tableColumnItems {
    
    TableColumnItem *field = [[TableColumnItem alloc]init];
    field.title      = @"Field";
    field.identifier = @"field";
    field.width      = 100;
    field.minWidth   = 100;
    field.maxWidth   = 120;
    field.editable   = YES;
    field.headerAlignment = NSLeftTextAlignment;
    field.cellType = TableColumnCellTypeTextField;
    
    TableColumnItem *type = [[TableColumnItem alloc]init];
    type.title      = @"Type";
    type.identifier = @"type";
    type.width      = 120;
    type.minWidth   = 120;
    type.maxWidth   = 160;
    type.editable   = YES;
    type.headerAlignment = NSLeftTextAlignment;
    type.cellType = TableColumnCellTypeComboBox;
    type.items = @[@"int",@"varchar",@"bool"];
    
    
    TableColumnItem *length = [[TableColumnItem alloc]init];
    length.title      = @"Size";
    length.identifier = @"size";
    length.width      = 120;
    length.minWidth   = 120;
    length.maxWidth   = 120;
    length.editable   = YES;
    length.headerAlignment = NSLeftTextAlignment;
    length.cellType = TableColumnCellTypeTextField;
    
    
    TableColumnItem *primary = [[TableColumnItem alloc]init];
    primary.title      = @"Primary";
    primary.identifier = @"primary";
    primary.width      = 80;
    primary.minWidth   = 80;
    primary.maxWidth   = 120;
    primary.editable   = YES;
    primary.headerAlignment = NSLeftTextAlignment;
    primary.cellType = TableColumnCellTypeCheckBox;
    
    
    TableColumnItem *image = [[TableColumnItem alloc]init];
    image.title      = @"Image";
    image.identifier = @"image";
    image.width      = 80;
    image.minWidth   = 80;
    image.maxWidth   = 120;
    image.cellType = TableColumnCellTypeImageView;
    
    
    return @[field,type,length,primary,image];
}



#pragma mark- ivars

- (DemoViewDataDelegate*)dataDelegate {
    if(!_dataDelegate) {
        _dataDelegate = [[DemoViewDataDelegate alloc]init];
        _dataDelegate.owner = self.tableView;
    }
    return _dataDelegate;
}

@end
