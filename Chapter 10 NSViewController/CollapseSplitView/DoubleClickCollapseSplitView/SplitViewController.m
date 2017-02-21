//
//  SplitViewController.m
//  DoubleClickCollapseSplitView
//
//  Created by iDevFans on 2016/11/3.
//  Copyright © 2016年 macdev. All rights reserved.
//

#import "SplitViewController.h"

extern NSString *kOpenCloseViewNotification;

@interface SplitViewController ()
@property(nonatomic,assign)BOOL isLeftCollapsed;
@end

@implementation SplitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserverForName:kOpenCloseViewNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [self toggleLeftView:self];
    }];
}

-(IBAction)toggleLeftView:(id)sender {
    if(self.isLeftCollapsed) {
        //打开左边视图
        [self expandLeftView];
    }
    else {
        //关闭左边视图
        [self collapsedLeftView];
    }
    //开关变量取反
    self.isLeftCollapsed = ~self.isLeftCollapsed;
}

- (void)expandLeftView {
    
    NSView *leftView = self.splitView.subviews[0];
    NSView *rightView = self.splitView.subviews[1];
    leftView.hidden = NO;
   
    CGFloat dividerThickness = self.splitView.dividerThickness;
    
    NSRect leftFrame = leftView.frame;
    NSRect rightFrame = rightView.frame;
    
    //右边视图frame 恢复到之前的大小(rightView.size = splitView.size - leftView.size)
    rightFrame.size.width = rightFrame.size.width - leftFrame.size.width - dividerThickness;
    
    rightView.frame = rightFrame;
    //重新刷新显示
    [self.splitView display];
}

- (void)collapsedLeftView {
    NSView *leftView = self.splitView.subviews[0];
    NSView *rightView = self.splitView.subviews[1];
    //隐藏左边视图
    leftView.hidden = YES;
    NSRect frame = rightView.frame;
    frame.size = self.splitView.frame.size;
    //右边视图frame 占据整个 splitview 的大小
    rightView.frame = frame;
    //重新刷新显示
    [self.splitView display];
}

#pragma mark NSSplitViewDelegate

- (BOOL)splitView:(NSSplitView *)splitView canCollapseSubview:(NSView *)subview {
    NSView* leftView = [[splitView subviews] objectAtIndex:0];
    //允许左边视图关闭
    return [super splitView:splitView canCollapseSubview:leftView];
}

@end
