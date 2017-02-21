//
//  DragOutlineView.m
//  DragDropDemo
//
//  Created by zhaojw on 15/10/21.
//  Copyright © 2015年 zhaojw. All rights reserved.
//

#import "DragOutlineView.h"

NSString*  kDragOutlineViewTypeName = @"kDragOutlineViewTypeName";

@implementation DragOutlineView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}
- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self registerForDraggedTypes:@[kDragOutlineViewTypeName]];
    
    [self setDraggingSourceOperationMask:NSDragOperationEvery forLocal:YES];

}
@end
