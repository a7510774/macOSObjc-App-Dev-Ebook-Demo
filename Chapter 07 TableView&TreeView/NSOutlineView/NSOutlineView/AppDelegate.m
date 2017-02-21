//
//  AppDelegate.m
//  NSOutlineView
//
//  Created by zhaojw on 15/8/29.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import "AppDelegate.h"
#import "TreeNodeModel.h"
#import "OutlineView.h"
@interface AppDelegate ()<NSOutlineViewDataSource,NSOutlineViewDelegate>
@property (weak) IBOutlet OutlineView *treeView;
@property (weak) IBOutlet NSMenu *treeMenu;

@property (weak) IBOutlet NSWindow *window;
@property (nonatomic,strong)  TreeNodeModel *treeModel;
@property (weak) IBOutlet NSTextField *nodeNameField;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    [self treeViewDataConfig];
    [self.treeView expandItem:nil expandChildren:YES];
    id item = [self.treeView itemAtRow:1];
    [self.treeView expandItem:item expandChildren:YES];
    self.treeView.treeMenu = self.treeMenu;
}
- (void) selectFirstTableNode {
    id item = [self.treeView itemAtRow:1];
    if(!item){
        return;
    }
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:1];
    [self.treeView selectRowIndexes:indexSet byExtendingSelection:YES];
}

- (void)treeViewDataConfig {
    //第一级根节点
    TreeNodeModel *rootNode = [[TreeNodeModel alloc]init];
    rootNode.name = @"公司";
    [self.treeModel.childNodes addObject:rootNode];
    
    //2级节点
    TreeNodeModel *level11Node = [[TreeNodeModel alloc]init];
    level11Node.name = @"电商";
    TreeNodeModel *level12Node = [[TreeNodeModel alloc]init];
    level12Node.name = @"游戏";
    TreeNodeModel *level13Node = [[TreeNodeModel alloc]init];
    level13Node.name = @"音乐";
    
    [rootNode.childNodes addObject:level11Node];
    [rootNode.childNodes addObject:level12Node];
    [rootNode.childNodes addObject:level13Node];
    
    //3级节点
    TreeNodeModel *level21Node = [[TreeNodeModel alloc]init];
    level21Node.name = @"研发";
    TreeNodeModel *level22Node = [[TreeNodeModel alloc]init];
    level22Node.name = @"运营";
    
    [level11Node.childNodes addObject:level21Node];
    [level11Node.childNodes addObject:level22Node];
    
    [self.treeView reloadData];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

#pragma mark- NSOutlineViewDataSource

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item {
    if(!item){
        return [self.treeModel.childNodes count];
    }
    else{
        
        TreeNodeModel *nodeModel = item;
        return [nodeModel.childNodes count];
    }
}

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item {
    if(!item){
        return self.treeModel.childNodes[index];
    }
    else{
        
        TreeNodeModel *nodeModel = item;
        return nodeModel.childNodes[index];
    }
}



- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item
{
    if(!item){
        return [self.treeModel.childNodes count]>0 ;
    }
    else{
        
        TreeNodeModel *nodeModel = item;
        return [nodeModel.childNodes count]>0;
    }
    
    
}


#pragma mark- NSOutlineViewDelegate

- (NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(NSTableColumn *)tableColumn item:(id)item ;
{
    NSView *result  =  [outlineView makeViewWithIdentifier:tableColumn.identifier owner:self];
    
    NSArray *subviews = [result subviews];
    
    NSImageView *imageView = subviews[0];
    
    NSTextField *field = subviews[1];
    
    TreeNodeModel *model = item;
    
    field.stringValue = model.name;
    
    if([[model childNodes]count]<=0){
        imageView.image = [NSImage imageNamed:NSImageNameListViewTemplate];
    }
    else {
        imageView.image = [NSImage imageNamed:NSImageNameFolder];
    }
    
    return result;
}

#pragma Action

- (IBAction)addNodeAction:(id)sender {
    NSInteger selectedRow =[self.treeView selectedRow];
    //如果没有节点选中 则返回
    if(selectedRow < 0){
        return;
    }
    
    NSString *nodeName = self.nodeNameField.stringValue;
    if(nodeName.length<=0){
        return;
    }
    TreeNodeModel *item = [self.treeView itemAtRow:selectedRow];
    NSMutableArray *childNodes =[NSMutableArray arrayWithArray:[item childNodes]];
    
    
    TreeNodeModel *addNode = [[TreeNodeModel alloc]init];
    addNode.name = nodeName;
    [childNodes addObject:addNode];
    item.childNodes = childNodes;
    [self.treeView reloadData];
    
}

- (IBAction)removeNodeAction:(id)sender {
    NSInteger selectedRow =[self.treeView selectedRow];
    //如果没有节点选中 则返回
    if(selectedRow < 0){
        return;
    }
    
    id item = [self.treeView itemAtRow:selectedRow];
    TreeNodeModel *parentItem = [self.treeView parentForItem:item];
    if(!parentItem){
        self.treeModel = nil;
        [self.treeView reloadData];
    }
    else{
        
        NSMutableArray *childNodes =[NSMutableArray arrayWithArray:[parentItem childNodes]];
        [childNodes removeObject:item];
        parentItem.childNodes = childNodes;
        [self.treeView reloadData];
    }
}


#pragma mark-   Notification

- (void)outlineViewSelectionDidChange:(NSNotification *)notification
{
    NSOutlineView *treeView = notification.object;
    
    NSInteger row = [treeView selectedRow];
 
    TreeNodeModel *model = (TreeNodeModel*)[treeView itemAtRow:row];
    
    NSLog(@"name =%@",model.name);
    
}


- (TreeNodeModel*)treeModel
{
    if(!_treeModel){
        _treeModel = [[TreeNodeModel alloc]init];
    }
    return _treeModel;
}


@end
