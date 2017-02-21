//
//  FileDragView.m
//  DragDropDemo
//
//  Created by zhaojw on 15/10/21.
//  Copyright © 2015年 zhaojw. All rights reserved.
//

#import "FileDragView.h"

@implementation FileDragView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self registerForDraggedTypes:@[NSFilenamesPboardType]];
    
}

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender {
    
    NSLog(@"drag operation entered");
    
    NSDragOperation sourceDragMask = [sender draggingSourceOperationMask];
    
    NSPasteboard *pboard = [sender draggingPasteboard];
    
    if ( [[pboard types] containsObject:NSFilenamesPboardType] ) {
        
        if (sourceDragMask & NSDragOperationLink) {
            return NSDragOperationLink;
        } else if (sourceDragMask & NSDragOperationCopy) {
            return NSDragOperationCopy;
        }
    }
    return NSDragOperationNone;
}


- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender
{
    NSPasteboard *pboard = [sender draggingPasteboard];
    
    NSLog(@"drop now");
    
    if ( [[pboard types] containsObject:NSFilenamesPboardType] ) {
        
        NSArray *files = [pboard propertyListForType:NSFilenamesPboardType];
        
        NSInteger numberOfFiles = [files count];
        
        if(numberOfFiles>0)
        {
            NSString *filePath = [files objectAtIndex:0];
            
            //if(self.delegate){
               // [self.delegate didFinishDragWithFile:filePath];
            //}
            
            return YES;
            
        }

    }
    else{
        NSLog(@"pboard types(%@) not register!",[pboard types]);
    }
    return YES;
}

@end
