//
//  AppDelegate.m
//  NSComboBox
//
//  Created by zhaojw on 15/9/1.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;

@property (weak) IBOutlet NSComboBox *dynamicComboBox;

@property (weak) IBOutlet NSComboBox *dataSourceComboBox;

@property(nonatomic,strong)NSArray *datas;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    self.datas = @[
                   @"小学",
                   @"初中",
                   @"高中",
                   
                   ];
    
    
    [self.dataSourceComboBox reloadData];
    
    [self dynamicComboBoxConfig];
   
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (void)dynamicComboBoxConfig {
    NSArray *items = @[@"1",@"2",@"3"];
    //删除默认的初始数据
    [self.dynamicComboBox removeAllItems];
    //增加数据items
    [self.dynamicComboBox addItemsWithObjectValues:items];
    //设置第一行数据为当前选中的数据
    [self.dynamicComboBox selectItemAtIndex:0];
}




- (IBAction)selectionChaned:(id)sender {

    NSComboBox *comboBox = sender;
   
    NSInteger selectedIndex = comboBox.indexOfSelectedItem;
   
    NSString *selectedContent = comboBox.stringValue;

    NSLog(@"selectedContent %@ at index %ld",selectedContent,selectedIndex);
}

#pragma mark- NSComboBoxDataSource

- (NSInteger)numberOfItemsInComboBox:(NSComboBox *)aComboBox {
    
    return [self.datas count];
}

- (id)comboBox:(NSComboBox *)aComboBox objectValueForItemAtIndex:(NSInteger)index {
    
    return self.datas[index];
}


#pragma mark- NSComboBoxDelegate

- (void)comboBoxSelectionDidChange:(NSNotification *)notification {
    
    
    NSComboBox *comboBox = notification.object;
    NSInteger selectedIndex = comboBox.indexOfSelectedItem;

    NSLog(@"comboBoxSelectionDidChange selected item %@",self.datas[selectedIndex]);
}
- (void)comboBoxSelectionIsChanging:(NSNotification *)notification {
    
    NSComboBox *comboBox = notification.object;
    NSInteger selectedIndex = comboBox.indexOfSelectedItem;
    
    NSLog(@"comboBoxSelectionIsChanging selected item %@",self.datas[selectedIndex]);
}


@end
