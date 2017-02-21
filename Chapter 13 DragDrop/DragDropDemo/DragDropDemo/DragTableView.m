//
//  DragTableView.m
//  DragDropDemo
//
//  Created by zhaojw on 15/10/21.
//  Copyright © 2015年 zhaojw. All rights reserved.
//

#import "DragTableView.h"
#import "DragTableViewDataSource.h"

@implementation DragTableView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self registerForDraggedTypes:@[kDragTableViewTypeName]];
    
}
@end
