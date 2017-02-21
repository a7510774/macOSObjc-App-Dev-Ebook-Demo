//
//  DragSourceView.m
//  DragDropDemo
//
//  Created by zhaojw on 15/10/21.
//  Copyright © 2015年 zhaojw. All rights reserved.
//


#import "DragSourceView.h"
#import "DragImageItem.h"

@interface DragSourceView () <NSPasteboardItemDataProvider>
@end

@implementation DragSourceView 

- (void)mouseDown:(NSEvent *)theEvent {
    NSMutableArray *draggingItems    = [NSMutableArray array];
    //拖放数据定义
    NSPasteboardItem *pasteboardItem = [NSPasteboardItem new];
    //设置数据的Provider
    [pasteboardItem setDataProvider:self forTypes:@[kImagePboardType]];

    //拖放item
    NSDraggingItem *draggingItem = [[NSDraggingItem alloc] initWithPasteboardWriter:pasteboardItem];
    draggingItem.draggingFrame = NSMakeRect(0, 0, 16, 16);
    
    //拖放可视化图象设置
    draggingItem.imageComponentsProvider = ^{
        NSDraggingImageComponent *component = [NSDraggingImageComponent draggingImageComponentWithKey:NSDraggingImageComponentIconKey];
      
        component.frame = NSMakeRect(0, 0, 16, 16);
        component.contents = [NSImage imageWithSize:NSMakeSize(32, 32) flipped:NO drawingHandler:^(NSRect rect) {
            [self.image drawInRect:rect];
            return YES;
        }];
        return @[component];
    };
    [draggingItems addObject:draggingItem];

    //开始启动拖放sesson
    [self beginDraggingSessionWithItems:draggingItems event:theEvent source:self.dragSourceDelegate];
    
}

#pragma mark - NSPasteboardItemDataProvider

- (void)pasteboard:(nullable NSPasteboard *)pasteboard item:(NSPasteboardItem *)item provideDataForType:(NSString *)type {
    NSData *data = [self.image TIFFRepresentation];
    [item setData:data forType:type];
}

@end
