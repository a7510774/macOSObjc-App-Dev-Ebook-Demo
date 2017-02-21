//
//  DataNavigationViewController.m
//  DataNavigationView
//
//  Created by zhaojw on 16/6/3.
//  Copyright © 2016年 http://www.macdev.io All rights reserved.
//

#import "DataNavigationViewController.h"
#import "DataNavigationView.h"
#import "Masonry.h"

@interface DataNavigationViewController ()
@property(nonatomic,strong)DataNavigationView *dataNavigationView;
@end

@implementation DataNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupAutolayout];
    // Do view setup here.
}

- (void)loadView {
    [super loadView];
    //将导航面板视图添加到父视图
    [self.view addSubview:self.dataNavigationView];
    
    //关联导航面板按钮事件
    [self.dataNavigationView setTarget:self withSelector:@selector(toolButtonClicked:)];
    //配置导航面板的按钮
    [self.dataNavigationView setUpNavigationViewWithItems:[self dataNavigationItemsConfig]];
}

- (void)setupAutolayout {
    //设置导航数据面板约束
    [self.dataNavigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.top.equalTo(self.view.mas_bottom).with.offset(-32);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
    }];
}


- (NSArray*)dataNavigationItemsConfig {
    
    DataNavigationButtonItem *insertItem  = [[DataNavigationButtonItem alloc]init];
    insertItem.tooltips = @"insert a row into current table";
    insertItem.image = NSImageNameAddTemplate;
    insertItem.tag = DataNavigationViewAddActionType;
    
    DataNavigationButtonItem *deleteItem  = [[DataNavigationButtonItem alloc]init];
    deleteItem.tooltips = @"delete seleted rows form current table";
    deleteItem.image = NSImageNameRemoveTemplate;
    deleteItem.tag = DataNavigationViewRemoveActionType;
    
    
    
    DataNavigationButtonItem *refreshItem  = [[DataNavigationButtonItem alloc]init];
    refreshItem.image = NSImageNameRefreshTemplate;
    refreshItem.tooltips = @"reload table data";
    refreshItem.tag = DataNavigationViewRefreshActionType;
    
    
    DataNavigationFlexibleItem *flexibleItem = [[DataNavigationFlexibleItem alloc]init];
    
    
    DataNavigationButtonItem *firstItem  = [[DataNavigationButtonItem alloc]init];
    firstItem.image = kToolbarFirstImageName;
    firstItem.tooltips = @"go first page";
    firstItem.tag = DataNavigationViewFirstPageActionType;
    
    DataNavigationButtonItem *preItem  = [[DataNavigationButtonItem alloc]init];
    preItem.image = kToolbarPreImageName;
    preItem.tooltips = @"go pre page";
    preItem.tag = DataNavigationViewPrePageActionType;
    
    DataNavigationTextItem *pageLable  = [[DataNavigationTextItem alloc]init];
    pageLable.identifier = @"pages";
    pageLable.title      = @"0/0";
    pageLable.alignment  = NSCenterTextAlignment;
    
    
    DataNavigationButtonItem *nextItem  = [[DataNavigationButtonItem alloc]init];
    nextItem.image = kToolbarNextImageName;
    nextItem.tooltips = @"go next page";
    nextItem.tag = DataNavigationViewNextPageActionType;
    
    DataNavigationButtonItem *lastItem  = [[DataNavigationButtonItem alloc]init];
    lastItem.image = kToolbarLastImageName;
    lastItem.tooltips = @"go last page";
    lastItem.tag = DataNavigationViewLastPageActionType;
    
    return @[insertItem,deleteItem,refreshItem,flexibleItem,firstItem,preItem,pageLable,nextItem,lastItem];
}

#pragma mark- Action

- (IBAction)toolButtonClicked:(id)sender {
    NSButton *button = sender;
    NSLog(@"button.tag %ld",button.tag);
}

#pragma mark- ivars

- (DataNavigationView *)dataNavigationView {
    if(!_dataNavigationView){
        _dataNavigationView = [[DataNavigationView alloc]init];
    }
    return _dataNavigationView;
}


@end
