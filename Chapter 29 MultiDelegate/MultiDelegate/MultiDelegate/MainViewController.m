//
//  MainViewController.m
//  MultiDelegate
//
//  Created by zhaojw on 10/3/15.
//  Copyright © 2015 zhaojw. All rights reserved.
//

#import "MainViewController.h"
#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Masonry.h"

@interface MainViewController ()
@property(nonatomic,strong)MasterViewController *masterViewController;
@property(nonatomic,strong)DetailViewController *detailViewController;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
 
    NSSplitViewItem *item1 = [[NSSplitViewItem alloc]init];
    item1.viewController = self.masterViewController;
    item1.canCollapse =YES;
    [item1 setHoldingPriority:250];
    
    NSSplitViewItem *item2 = [[NSSplitViewItem alloc]init];
    item2.viewController = self.detailViewController;
    item2.canCollapse = YES;
    [item2 setHoldingPriority:270];
    
    //水平方向
    self.splitView.vertical = YES;
    
    //增加NSSplitViewItem对象
    [self addSplitViewItem:item1];
    [self addSplitViewItem:item2];
    
    
    //设置第一个视图的宽度最小100,最大200
    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.greaterThanOrEqualTo(@700);
        make.height.greaterThanOrEqualTo(@260);
    }];
    
    //设置第一个视图的宽度最小100,最大200
    [item1.viewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.greaterThanOrEqualTo(@100);
        make.width.lessThanOrEqualTo(@200);
    }];
    
    //设置第二个视图的宽度最小100,最大800
    [item2.viewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.greaterThanOrEqualTo(@100);
        make.width.lessThanOrEqualTo(@600);
    }];

    
    // Do view setup here.
}




- (MasterViewController*)masterViewController{
    if(!_masterViewController){
        _masterViewController = [[MasterViewController alloc]init];
    }
    return _masterViewController;
}
- (DetailViewController*)detailViewController{
    if(!_detailViewController){
        _detailViewController = [[DetailViewController alloc]init];
    }
    return _detailViewController;
}

@end
