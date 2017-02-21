//
//  TabViewController.m
//  NSTabViewControllerDemo
//
//  Created by zhaojw on 15/9/15.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import "TabViewController.h"
#import "HomeViewController.h"
@interface TabViewController ()

@property (weak) IBOutlet NSTabView *tabCustomView;


@end

@implementation TabViewController

- (void)loadView
{
    [super loadView];
}

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    //Do view setup here.
    HomeViewController *homevc = [[HomeViewController alloc]init];
    homevc.title = @"homevc";
    HomeViewController *homevc2 = [[HomeViewController alloc]init];
    homevc2.title = @"homev2";
 
    [self addChildViewController:homevc];
    [self addChildViewController:homevc2];
    self.selectedTabViewItemIndex = 0;
    
}


- (void)tabView:(NSTabView *)tabView willSelectTabViewItem:(NSTabViewItem *)tabViewItem
{
    [super tabView:tabView willSelectTabViewItem:tabViewItem];
    NSLog(@"willSelectTabViewItem %@",tabViewItem.label);
}
- (void)tabView:(NSTabView *)tabView didSelectTabViewItem:(NSTabViewItem *)tabViewItem
{
    [super tabView:tabView didSelectTabViewItem:tabViewItem];
    NSLog(@"didSelectTabViewItem %@",tabViewItem.label);
}

@end
