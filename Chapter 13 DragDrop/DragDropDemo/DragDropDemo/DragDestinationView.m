//
//  DragDestinationView.m
//  DragDropDemo
//
//  Created by zhaojw on 15/10/21.
//  Copyright © 2015年 zhaojw. All rights reserved.
//

#import "DragDestinationView.h"
#import "DragImageItem.h"
#import "DrawImageItem.h"
@interface DragDestinationView ()
//存储小球的模型数组
@property(nonatomic,strong)NSMutableArray *imageItems;
@end

@implementation DragDestinationView
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    for(NSInteger i=0;i<[self.imageItems count];i++) {
        DrawImageItem *imageItem = self.imageItems[i];
        CGRect frame = CGRectMake(imageItem.location.x, imageItem.location.y, 16, 16);
        if(imageItem.image){
            [imageItem.image drawInRect:frame];
        }
    }
}

- (void)awakeFromNib {
    //注册拖放的类型
    [self registerForDraggedTypes:@[kImagePboardType,NSURLPboardType]];
    _imageItems = [NSMutableArray array];
}

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender {
    //开始拖放，返回拖放类型
    return NSDragOperationGeneric;
}

- (void)draggingExited:(nullable id <NSDraggingInfo>)sender {
    //退出拖放
}

- (void)concludeDragOperation:(id <NSDraggingInfo>)sender{
    //托放完成
     NSLog(@"concludeDragOperation");
}

- (BOOL)prepareForDragOperation:(id <NSDraggingInfo>)sender {
    //允许接收拖放
    return YES;
}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender {

    NSPasteboard *pboard = [sender draggingPasteboard];
    NSLog(@"pasteboard  %@ types %@",sender,[pboard types]);
    NSArray *items = [sender.draggingPasteboard readObjectsForClasses:@[[DragImageItem class]] options:nil];
    
    DragImageItem *imageItem ;
    if([items count]>0){
        imageItem = items[0];
        //获取拖放数据
        NSData *data = imageItem.data;
        NSImage *img = [[NSImage alloc] initWithData:data];
        
        //创建绘制的图像模型类
        DrawImageItem *drawImageItem = [[DrawImageItem alloc]init];
        drawImageItem.image = img;
       
        NSPoint point = [self convertPoint:sender.draggingLocation fromView:nil];
        drawImageItem.location =  point;
        
        NSLog(@"draggingLocation %@",NSStringFromPoint(point));
        
        //存储图象模型
        [self.imageItems addObject:drawImageItem];
        //触发视图重绘
        [self setNeedsDisplay:YES];
  
    }
    return YES;
}

- (BOOL)isFlipped {
    return YES;
}
@end
