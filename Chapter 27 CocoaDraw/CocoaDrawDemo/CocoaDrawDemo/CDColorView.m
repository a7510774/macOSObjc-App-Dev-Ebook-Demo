//
//  CDColorView.m
//  CocoaDrawDemo
//
//  Created by zhaojw on 2/28/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//

#import "CDColorView.h"

@implementation CDColorView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    
    
  
 
    //NSRect rect = NSMakeRect(dirtyRect.origin.x, dirtyRect.origin.y, 100, 60);
    
    
   // DrawParallelogramInRect2(rect,10);
    [[NSColor blueColor]setFill];
    NSRectFill(dirtyRect);
    //[NSBezierPath strokeRect:dirtyRect];
    
    // Drawing code here.
    
    NSRect rect = NSMakeRect(0, 0, 60, 60);
    
    
    
    NSImage *canvas = [[NSImage alloc] initWithSize:rect.size];
    [canvas lockFocus];
    [[NSColor redColor]setFill];
     NSRectFill(rect);
    //[NSBezierPath strokeRect:rect];
    
    [canvas unlockFocus];
    
    
    
   
    
    
    NSImage *image =  [NSImage imageWithSize:NSMakeSize(40, 40) flipped:NO drawingHandler:^(NSRect rect) {
      
         [[NSColor redColor]setFill];
      
          NSRectFill(rect);
      
         return YES;
    }];
    
    
    [image drawAtPoint:NSMakePoint(10.0, 10.0)  fromRect: NSMakeRect(0.0, 0.0, 40, 40)
              operation: NSCompositeSourceIn
               fraction: 0.5];

    
}

- (BOOL)isFlipped {
    return YES;
}

void DrawParallelogramInRect2(NSRect rect, float withShift)
{
    NSBezierPath* thePath = [NSBezierPath bezierPath];
    [thePath moveToPoint:rect.origin];
    [thePath lineToPoint:NSMakePoint(rect.origin.x + withShift,  NSMaxY(rect))];
    [thePath lineToPoint:NSMakePoint(NSMaxX(rect), NSMaxY(rect))];
    [thePath lineToPoint:NSMakePoint(NSMaxX(rect) - withShift,  rect.origin.y)];
    [thePath closePath];
    
    [thePath stroke];
}

- (void)saveImage {
    //视图的image
    NSImage *viewImage = [[NSImage alloc] initWithData:[self dataWithPDFInsideRect:[self bounds]]];
    //获取ImageRep
    NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:[viewImage TIFFRepresentation]];
    //图象压缩比设置
    NSDictionary *imageProps = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:1.0] forKey:NSImageCompressionFactor];
    //Data数据
    NSData *imageData = [imageRep representationUsingType:NSJPEGFileType properties:imageProps];
    //文件路径
    NSString *filePath = [NSString stringWithFormat:@"/Users/my/Documents/file%d.png",22];
    //写入文件
    [imageData writeToFile:filePath atomically:NO];
    
    
   
    
}

@end
