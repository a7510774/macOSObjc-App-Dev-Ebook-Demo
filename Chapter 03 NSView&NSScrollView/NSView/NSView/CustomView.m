//
//  CustomView.m
//  NSViewCustom
//
//  Created by zhaojw on 15/11/9.
//  Copyright © 2015年 zhaojw. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    [[NSColor blueColor] setFill];
    
    NSBezierPath* thePath = [NSBezierPath bezierPathWithOvalInRect:dirtyRect];
    [thePath stroke];
    
    NSRect  bounds = [self bounds];
    NSBezierPath *roundedShape = [NSBezierPath bezierPath];
    [roundedShape appendBezierPathWithRoundedRect:bounds xRadius:20 yRadius:20];
    [roundedShape fill];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.borderColor = [NSColor greenColor].CGColor;
        self.layer.borderWidth = 2;
        self.layer.cornerRadius = 20;
}

- (BOOL)becomeFirstResponder {
    return YES;
}

- (void)mouseDown:(NSEvent *)theEvent {
    [super mouseDown:theEvent];
    NSPoint locationInWindow = theEvent.locationInWindow;
    NSPoint locationInView = [self convertPoint:locationInWindow toView:nil];
 
    NSLog(@"window point: %@",NSStringFromPoint(locationInWindow));
    NSLog(@"view point: %@",NSStringFromPoint(locationInView));
    
}

- (void)saveSelfAsImage {
    [self lockFocus];
    NSImage *image = [[NSImage alloc]initWithData:[self dataWithPDFInsideRect:self.bounds]];
    [self unlockFocus];
    NSData *imageData = image.TIFFRepresentation;
    
    //创建文件
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *path = @"/Users/idevfans/Documents/myCapture.png";
    [fm createFileAtPath:path contents:imageData attributes:nil];
    
    //保存结束后自动定位到文件路径
    NSURL *fileURL = [NSURL fileURLWithPath: path];
    [[NSWorkspace sharedWorkspace] activateFileViewerSelectingURLs:@[ fileURL ]];
}


- (void)saveScrollViewAsImage {
    [self lockFocus];
    NSRect r = [self frame];
    NSData* dataq = [self dataWithPDFInsideRect:r];
    [self unlockFocus];
    NSString *path = @"/Users/idevfans/Documents/myCapture.png";
    NSPDFImageRep *img = [NSPDFImageRep imageRepWithData:dataq];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSInteger count = [img pageCount];
    // 一般情况下 count 为 1 ，所以只会循环一次。因此规定一个 path 路径是可以的
    for(NSInteger i = 0 ; i < count ; i++) {
        [img setCurrentPage:i];
        NSImage *temp = [[NSImage alloc] init];
        [temp addRepresentation:img];
        NSBitmapImageRep *rep = [NSBitmapImageRep imageRepWithData:[temp TIFFRepresentation]];
        NSData *finalData = [rep representationUsingType:NSPNGFileType properties:@{}];
        [fileManager createFileAtPath:path contents:finalData attributes:nil];
    }
    
    //定位到文件路径
    NSURL *fileURL = [NSURL fileURLWithPath: path];
    [[NSWorkspace sharedWorkspace] activateFileViewerSelectingURLs:@[ fileURL ]];
}

@end
