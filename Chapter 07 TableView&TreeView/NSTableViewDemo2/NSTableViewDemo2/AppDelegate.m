//
//  AppDelegate.m
//  NSTableViewDemo2
//
//  Created by zhaojw on 15/10/31.
//  Copyright © 2015年 zhaojw. All rights reserved.
//

#import "AppDelegate.h"
#import "Masonry.h"

@interface AppDelegate ()<NSTableViewDataSource,NSTableViewDelegate,NSMenuDelegate>

@property (weak) IBOutlet NSWindow *window;

@property (nonatomic,strong) NSTableView *tableView;

@property (nonatomic,strong) NSScrollView *tableViewScrollView;

@property (nonatomic,strong) NSView *view;


@property (nonatomic,strong) NSArray *datas;

@property (weak) IBOutlet NSMenu *tableMenu;


@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    
    self.view = self.window.contentView ;
    
    
    [self createtableView];
    
    
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



- (void)createtableView {
    
    //创建表格
    _tableView = [[NSTableView alloc] init];
    [_tableView setAutoresizesSubviews:YES];
    [_tableView setFocusRingType:NSFocusRingTypeNone];
    
    
    //创建表格列单元
    NSTableColumn *column1=[[NSTableColumn alloc]initWithIdentifier:@"name"];
    column1.title = @"name";
    [self.tableView addTableColumn:column1];
    
    NSTableColumn *column2=[[NSTableColumn alloc]initWithIdentifier:@"address"];
    column2.title = @"address";
    [self.tableView addTableColumn:column2];
    
    
    //表格样式配置
    _tableView.gridStyleMask =  NSTableViewSolidHorizontalGridLineMask | NSTableViewSolidVerticalGridLineMask;
    _tableView.usesAlternatingRowBackgroundColors = YES;
    
    
    self.tableView.usesAlternatingRowBackgroundColors = YES;
    
 
    self.tableView.doubleAction = @selector(doubleAction:);
    
    
    //设置代理和数据源
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
    [_tableView setSelectionHighlightStyle:
     NSTableViewSelectionHighlightStyleSourceList];
    
    
    //创建滚动条
    _tableViewScrollView = [[NSScrollView alloc] init];
    [_tableViewScrollView setHasVerticalScroller:NO];
    [_tableViewScrollView setHasHorizontalScroller:NO];
    [_tableViewScrollView setFocusRingType:NSFocusRingTypeNone];
    [_tableViewScrollView setAutohidesScrollers:YES];
    [_tableViewScrollView setBorderType:NSBezelBorder];
    [_tableViewScrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    
    //设置滚动条的内容视图为tableView
    [self.tableViewScrollView setDocumentView:self.tableView];

    //增加到父视图
    [self.view addSubview:self.tableViewScrollView];
    
    //使用Masonry做Autolayot布局设置
    [self.tableViewScrollView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-24);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        
    }];
    
    
    self.tableView.menu = self.tableMenu;
    
  
  
}

- (IBAction)doubleAction:(id)sender {
    
    NSLog(@"doubleAction");
}

- (void)sort {
    
    for (NSTableColumn *tableColumn in self.tableView.tableColumns ) {
        
        
        NSSortDescriptor *sortStates = [NSSortDescriptor sortDescriptorWithKey:tableColumn.identifier
                                                                     ascending:NO
                                                                    comparator:^(id obj1, id obj2) {
                                                                        
                                                                        if (obj1 < obj2) {
                                                                            return  NSOrderedAscending;
                                                                            
                                                                        }
                                                                        if (obj1 > obj2) {
                                                                            
                                                                            return NSOrderedDescending;
                                                                            
                                                                        }
                                                                        
                                                                        return NSOrderedSame;
                                                                    }];
        
        
        [tableColumn setSortDescriptorPrototype:sortStates];
        
    }
}
#pragma mark-  NSTableViewDelegate


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
    
    //如果不存在,创建新的textField
    if(!view){
        
        textField =  [[NSTextField alloc]init];
        
        [textField setBezeled:NO];
        [textField setDrawsBackground:NO];
        [textField setEditable:NO];

        textField.identifier = identifier;
        
        view = textField ;
        
       
    }
    else{
        
        textField = (NSTextField*)view;

    }
    
    ;
    
    ;
    
   
    
    
//    if(!view){
//        
//        NSTableCellView  *cell = [[NSTableCellView alloc]init];
//        
//        cell.identifier = identifier;
//        
//        view = cell;
//        
//    }
//    else{
//        
//        
//    }
//    
//    
//    NSArray *subviews = [view subviews];
//    
//    NSTableCellView *cell = view;
    
 //   textField = cell.textField;
    
    
    //textField= subviews[0];
    
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
