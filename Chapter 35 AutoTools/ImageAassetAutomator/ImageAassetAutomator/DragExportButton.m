//
//  DragExportButton.m
//  ImageAassetAutomator
//
//  Created by zhaojw on 15/9/12.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import "DragExportButton.h"

@implementation DragExportButton

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self) {
        [self registerForDraggedTypes:[NSArray arrayWithObjects:
                                       NSFilenamesPboardType, nil]];
        
       // [self dropAreaFadeOut];
    }
    
    return self;
    
}
- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self registerForDraggedTypes:[NSArray arrayWithObjects:
                                       NSFilenamesPboardType, nil]];
        
        //[self dropAreaFadeOut];
    }
    
    return self;
}

- (void)dropAreaFadeIn
{
    //[self setAlphaValue:1.0];
}

- (void)dropAreaFadeOut
{
    //[self setAlphaValue:0.2];
}

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender {
    NSPasteboard *pboard;
    NSDragOperation sourceDragMask;
    
    NSLog(@"drag operation entered");
    sourceDragMask = [sender draggingSourceOperationMask];
    pboard = [sender draggingPasteboard];
    
    if ( [[pboard types] containsObject:NSFilenamesPboardType] ) {
        
        [self dropAreaFadeIn];
        
        if (sourceDragMask & NSDragOperationLink) {
            return NSDragOperationLink;
        } else if (sourceDragMask & NSDragOperationCopy) {
            return NSDragOperationCopy;
        }
    }
    return NSDragOperationNone;
}

- (void) draggingExited: (id <NSDraggingInfo>) info
{
    NSLog(@"drag operation finished");
    
    [self dropAreaFadeOut];
}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender
{
    NSPasteboard *pboard = [sender draggingPasteboard];
    
    NSLog(@"drop now");
    [self dropAreaFadeOut];
    
    if ( [[pboard types] containsObject:NSFilenamesPboardType] ) {
        
        NSArray *files = [pboard propertyListForType:NSFilenamesPboardType];
        
        NSInteger numberOfFiles = [files count];
        
        if(numberOfFiles>0)
        {
            NSString *filePath = [files objectAtIndex:0];
            
            
            if(self.delegate){
                [self.delegate didFinishDragWithExportPath:filePath];
            }
            
            
            return YES;
            
            
        }
        else{
            NSLog(@"drag file num =0 return!");
        }
    }
    else{
        NSLog(@"pboard types(%@) not register!",[pboard types]);
    }
    return YES;
    
}

@end
