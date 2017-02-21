//
//  AppDelegate.m
//  NSScrollViewDemo
//
//  Created by zhaojw on 15/11/15.
//  Copyright © 2015年 zhaojw. All rights reserved.
//

#import "AppDelegate.h"
@interface AppDelegate ()
@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTableView *tableView;
@property (nonatomic,strong) NSArray *datas;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    
    CGRect rect = CGRectMake(10, 10, 200, 200) ;
    
    NSScrollView *scrollView =  [[NSScrollView alloc]initWithFrame:rect];
    
    NSImage *image =  [NSImage imageNamed:@"screen.png"];
    
    NSImageView *imageView = [[NSImageView alloc]initWithFrame:scrollView.bounds];
    
    [imageView setFrameSize:image.size];
    
    imageView.image = image;
    
    scrollView.hasVerticalScroller = YES;
    
    scrollView.hasHorizontalScroller = YES;
    
    scrollView.documentView = imageView;
    
    
    [self.window.contentView addSubview:scrollView];
    
    
    NSClipView *contentView  = scrollView.contentView;
    NSPoint newScrollOrigin;
    
    if(self.window.contentView.isFlipped){
        newScrollOrigin = NSMakePoint(0.0,0.0);
    }
    else{
        newScrollOrigin = NSMakePoint(0.0,imageView.frame.size.height-contentView.frame.size.height);
    }
    [contentView scrollPoint:newScrollOrigin];
    //self.window.contentView = scrollView;
    
    
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.datas = @[
                   
                   @{@"name":@"john",@"address":@"USA"},
                   @{@"name":@"mary",@"address":@"China"},
                   @{@"name":@"park",@"address":@"Japan"},
                   @{@"name":@"Daba",@"address":@"Russia"},
                   
                   ];
    
    
    
    [self.tableView reloadData];
    
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    
    //获取row数据
    NSDictionary *data = self.datas[row];
    
    //表格列的标识
    NSString *identifier = tableColumn.identifier;
    
    //单元格数据
    NSString *value = data[identifier];
    
    //根据表格列的标识,创建单元视图
    NSView *view = [tableView makeViewWithIdentifier:identifier owner:self];
    
    NSTextField *textField;
    
    
    NSArray *subviews = [view subviews];
    textField = subviews[0];
    
    if(value){
        //更新单元格的文本
        textField.stringValue = value;
    }
    
    
    
    return view;
}


#pragma mark-  NSTableViewDataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    //返回表格共有多少行数据
    return [self.datas count];
}


@end
