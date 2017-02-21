//
//  DragDestinationWindow.m
//  DragDropDemo
//
//  Created by zhaojw on 15/10/22.
//  Copyright © 2015年 zhaojw. All rights reserved.
//

#import "DragDestinationWindow.h"
#import "DragImageItem.h"
@implementation DragDestinationWindow


- (void)awakeFromNib
{
    [self registerForDraggedTypes:@[kImagePboardType,NSURLPboardType]];
    
}

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender
{
    NSLog(@"window draggingEntered");
    return NSDragOperationGeneric;
}

- (void)draggingExited:(nullable id <NSDraggingInfo>)sender {
    
    NSLog(@"window draggingExited");
}
- (void)concludeDragOperation:(id <NSDraggingInfo>)sender{
    NSLog(@"concludeDragOperation");
}

- (BOOL)prepareForDragOperation:(id <NSDraggingInfo>)sender
{
    return YES;
}


- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender
{
    
    return YES;
}
@end
