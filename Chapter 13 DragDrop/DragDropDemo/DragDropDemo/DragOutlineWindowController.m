//
//  DragOutlineWindowController.m
//  DragDropDemo
//
//  Created by zhaojw on 15/10/21.
//  Copyright © 2015年 zhaojw. All rights reserved.
//

#import "DragOutlineWindowController.h"
#import "DragOutlineView.h"
@interface DragOutlineWindowController ()<NSOutlineViewDataSource,NSOutlineViewDelegate>

@property(nonatomic,strong)NSMutableArray *nodes;
@property (weak) IBOutlet DragOutlineView *treeView;
@end

@implementation DragOutlineWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    [self.treeView expandItem:nil expandChildren:YES];
}

- (NSString*)windowNibName {
    return @"DragOutlineWindowController";
}

- (NSMutableArray*)nodes {
    
    if(!_nodes){
        
        NSMutableArray *mNodes = [NSMutableArray array];
        
        NSMutableDictionary *group1 = [NSMutableDictionary dictionary];
        group1[@"name"]=@"Group1";
        
        NSMutableDictionary *group2 = [NSMutableDictionary dictionary];
        group2[@"name"]= @"Group2";
        
        
        NSArray *children1 = @[
                              @{@"name":@"member11"},
                              @{@"name":@"member12"}

                              ];
        
        NSArray *children2 = @[
                              @{@"name":@"member21"},
                              @{@"name":@"member22"},
                              @{@"name":@"member23"}

                              ];
        
        group1[@"children"]=[NSMutableArray arrayWithArray: children1];
        
        group2[@"children"]=[NSMutableArray arrayWithArray: children2];
        
        
        [mNodes addObject:group1];
        
        [mNodes addObject:group2];
        
        _nodes = mNodes;
    }
    return _nodes;
}


#pragma mark-- DragOutlineViewDataSource

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(nullable id)item {
    
    if(!item){
        return [self.nodes count];
    }
    NSArray *children = item[@"children"];
    return [children count];
    
}
- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(nullable id)item {
    
    if(!item){
        return  self.nodes[index];
    }
    
    NSMutableArray *children = item[@"children"];

    return  children[index];
    
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item {
    return YES;
}

#pragma mark-- DragOutlineViewDelegate
- (nullable NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(nullable NSTableColumn *)tableColumn item:(id)item  {
    
    NSView *view = [outlineView makeViewWithIdentifier:@"TableID" owner:self];
    
    NSArray *subViews = [view subviews];
    
    NSTextField *field = subViews[0];
    
    NSDictionary *node = item;
    NSString *name  = node[@"name"];
    if(field){
        field.stringValue = name;
    }
    
    return view;
}

#pragma mark-- Drag /Drop

- (BOOL)outlineView:(NSOutlineView *)outlineView writeItems:(NSArray *)items toPasteboard:(NSPasteboard *)pboard{
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:items];
   
    [pboard declareTypes:[NSArray arrayWithObject:kDragOutlineViewTypeName] owner:self];
   
    [pboard setData:data forType:kDragOutlineViewTypeName];
   
    return YES;
    
}

- (NSDragOperation)outlineView:(NSOutlineView *)outlineView validateDrop:(id < NSDraggingInfo >)info proposedItem:(id)item proposedChildIndex:(NSInteger)index {
    // Add code here to validate the drop
    
    NSLog(@"validate Drop");
    
    return NSDragOperationEvery;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView acceptDrop:(id<NSDraggingInfo>)info item:(id)item childIndex:(NSInteger)index {
   
    NSPasteboard* pboard = [info draggingPasteboard];
    
    NSData* data = [pboard dataForType:kDragOutlineViewTypeName];
  
    NSArray* items = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    NSLog(@"outlineView item %@",item);
    
    NSLog(@"drop items %@ index %ld",items,index);
    
    id parentItem;
    
    if(item) {
        
        parentItem = [outlineView parentForItem:item];
        
    }
    else{
        
        parentItem = self.nodes[[self.nodes count]-1];
        
    }
    
    NSMutableArray *children = parentItem[@"children"];
    
    
    [children addObjectsFromArray:items];
    
    [self.treeView reloadData];
    
    
    
    return YES;
}

@end
