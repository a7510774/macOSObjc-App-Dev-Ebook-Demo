//
//  CDDrawView.m
//  CocoaDrawDemo
//
//  Created by zhaojw on 2/27/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//

#import "CDDrawView.h"


@interface CDDrawView ()

@property(nonatomic,strong)NSBezierPath* thePath;

@end

@implementation CDDrawView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    
    NSColor* rgbColor = [NSColor colorWithCalibratedRed:1.0 green: 0.5  blue: 0.5
                                                  alpha:1];
    
    NSColor* cmykColor = [rgbColor colorUsingColorSpace:[NSColorSpace
                                                         genericCMYKColorSpace]];
    
    
    NSColor* grayColor = [rgbColor colorUsingColorSpace:[NSColorSpace
                                                         genericGrayColorSpace]];
   
    
    
//    NSAffineTransform* xform = [NSAffineTransform transform];
//    [xform translateXBy:50.0 yBy:20.0];
//   [xform concat];
//    
//    [xform invert];
//    //应用变换
//    [xform concat];
    
   // [NSGraphicsContext saveGraphicsState];
    // Create the path and add the shapes
    NSBezierPath* clipPath = [NSBezierPath bezierPath];
    //[clipPath appendBezierPathWithRect:NSMakeRect(0.0, 0.0, 100.0, 100.0)];
    //[NSBezierPath setDefaultFlatness:20.0];
    
    [clipPath appendBezierPathWithOvalInRect:NSMakeRect(50.0, 50.0, 100.0,  100.0)];
    
    //[clipPath stroke];
    // Add the path to the clip shape.
    //[clipPath addClip];
    
    
    
    
    [[NSColor redColor] setStroke];
    [[NSColor controlBackgroundColor] setFill];
    
    
    [NSBezierPath setDefaultLineWidth:2.0];
    
    NSGraphicsContext* aContext = [NSGraphicsContext currentContext];
    
   
    
    NSRect rect = NSMakeRect(dirtyRect.origin.x, dirtyRect.origin.y, 100, 60);
    
    
    //DrawParallelogramInRect(rect,10);
    
    
    NSRect rectangleRect = NSMakeRect(100, 100, 100, 60);
   //DrawRectangle(rectangleRect);
    
    
    NSRect rect3 = NSMakeRect(200, 200, 100, 100);
    
   // DrawRoundedRect(rect3,40,40);
    
    [[NSColor blackColor] setStroke];
    
//    NSBezierPath* aPath1 = [NSBezierPath bezierPath];
//    [aPath1 setLineWidth:10.0];
//    [aPath1 moveToPoint:NSMakePoint(12.0, 20.0)];
//    [aPath1 lineToPoint:NSMakePoint(92.0, 20.0)];
//    [aPath1 setLineCapStyle:NSButtLineCapStyle];
//    [aPath1 stroke];
//    
//    NSBezierPath* aPath2 = [NSBezierPath bezierPath];
//    [aPath2 setLineWidth:10.0];
//    [aPath2 moveToPoint:NSMakePoint(12.0, 60.0)];
//    [aPath2 lineToPoint:NSMakePoint(92.0, 60.0)];
//    [aPath2 setLineCapStyle:NSRoundLineCapStyle];
//    [aPath2 stroke];
//    
//    NSBezierPath* aPath3 = [NSBezierPath bezierPath];
//    [aPath3 setLineWidth:10.0];
//    [aPath3 moveToPoint:NSMakePoint(12.0, 100.0)];
//    [aPath3 lineToPoint:NSMakePoint(92.0, 100.0)];
//    [aPath3 setLineCapStyle:NSSquareLineCapStyle];
//    [aPath3 stroke];
    
    
    
    
//    NSBezierPath* aPath1 = [NSBezierPath bezierPath];
//    [aPath1 setLineWidth:10.0];
//    [aPath1 moveToPoint:NSMakePoint(12.0, 20.0)];
//    [aPath1 lineToPoint:NSMakePoint(42.0, 40.0)];
//    [aPath1 lineToPoint:NSMakePoint(72.0, 20.0)];
//    [aPath1 setLineJoinStyle:NSMiterLineJoinStyle];
//    [aPath1 stroke];
//    
//    NSBezierPath* aPath2 = [NSBezierPath bezierPath];
//    [aPath2 setLineWidth:10.0];
//    [aPath2 moveToPoint:NSMakePoint(12.0, 60.0)];
//    [aPath2 lineToPoint:NSMakePoint(42.0, 80.0)];
//    [aPath2 lineToPoint:NSMakePoint(72.0, 60.0)];
//    [aPath2 setLineJoinStyle:NSRoundLineJoinStyle];
//    [aPath2 stroke];
//    
//    NSBezierPath* aPath3 = [NSBezierPath bezierPath];
//    [aPath3 setLineWidth:10.0];
//    [aPath3 moveToPoint:NSMakePoint(12.0, 100.0)];
//    [aPath3 lineToPoint:NSMakePoint(42.0, 120.0)];
//    [aPath3 lineToPoint:NSMakePoint(72.0, 100.0)];
//    [aPath3 setLineJoinStyle:NSBevelLineJoinStyle];
//    [aPath3 stroke];
    
    
//    [xform invert];
//    //应用变换
//    [xform concat];
    
    
    
        NSBezierPath* aPath1 = [NSBezierPath bezierPath];
        [aPath1 moveToPoint:NSMakePoint(12.0, 60.0)];
        [aPath1 lineToPoint:NSMakePoint(192.0, 60.0)];
    
        CGFloat lineDash[2];
        lineDash[0] = 2.0;
        lineDash[1] = 2.0;
        [aPath1 setLineDash:lineDash count:2 phase:0.0];
    
        //[aPath1 stroke];
    
    
    
        NSBezierPath* aPath2 = [NSBezierPath bezierPath];
        [aPath2 moveToPoint:NSMakePoint(12.0, 20.0)];
        [aPath2 lineToPoint:NSMakePoint(192.0, 20.0)];
    
        CGFloat lineDash2[4];
        lineDash2[0] = 2.0;
        lineDash2[1] = 2.0;
        lineDash2[2] = 4.0;
        lineDash2[3] = 4.0;
        [aPath2 setLineDash:lineDash2 count:4 phase:0.0];
    
        //[aPath2 stroke];
    
    
//    NSBezierPath* aPath = [NSBezierPath bezierPath];
//    [aPath moveToPoint:NSMakePoint(10.0, 10.0)];
//    [aPath lineToPoint:NSMakePoint(18.0, 110.0)];
//    [aPath lineToPoint:NSMakePoint(26.0, 10.0)];
//    [aPath setLineWidth:5.0];
//    [aPath setMiterLimit:10.0];
//    [aPath stroke];
    
    
//    NSBezierPath* aPath = [NSBezierPath bezierPath];
//    [aPath moveToPoint:NSMakePoint(10.0, 10.0)];
//    [aPath lineToPoint:NSMakePoint(180.0, 10.0)];
//    [aPath lineToPoint:NSMakePoint(100.0, 60.0)];
//    [aPath closePath];
//    [aPath stroke];

    
    NSString *str = @"RoundedRect";
    
    NSFont *font = [NSFont fontWithName:@"Palatino-Roman" size:14.0];
    NSColor *strColor = [NSColor greenColor];
    NSMutableDictionary *attrsDictionary = [NSMutableDictionary dictionary];
    
    attrsDictionary[NSFontAttributeName] = font;
    attrsDictionary[NSForegroundColorAttributeName] = strColor;
    
    NSPoint p = CGPointMake(0, 10);
   // [str drawAtPoint:p withAttributes:attrsDictionary];
    
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:@"NSMutableAttributedString"];
    
    NSRange selectedRange = NSMakeRange(0, string.length);
    
    NSURL *linkURL = [NSURL URLWithString:@"http://www.apple.com/"];

    [string addAttribute:NSLinkAttributeName
                   value:linkURL
                   range:selectedRange];
    
    [string addAttribute:NSForegroundColorAttributeName
                   value:[NSColor blueColor]
                   range:selectedRange];
    
    [string addAttribute:NSFontAttributeName
                   value:font
                   range:selectedRange];
    
    [string addAttribute:NSUnderlineStyleAttributeName
                   value:[NSNumber numberWithInt:NSUnderlineStyleSingle]
                   range:selectedRange];
    
    [string drawAtPoint:p];
    
    
    NSPoint aPoint = NSMakePoint(10.0,10.0);
    NSRect aRect = NSMakeRect(40, 40, 140.0, 140.0);

    
    NSBezierPath* thePath = [NSBezierPath bezierPathWithOvalInRect:aRect];
    //[thePath stroke];
    
    
    [NSGraphicsContext saveGraphicsState];
    
    NSShadow* theShadow = [[NSShadow alloc] init];
    [theShadow setShadowOffset:NSMakeSize(5.0, -5.0)];
    [theShadow setShadowBlurRadius:2.0];
    [theShadow setShadowColor:[[NSColor blueColor]
                               colorWithAlphaComponent:0.3]];
    [theShadow set];
    
    
    [NSBezierPath fillRect:aRect];
    
    [NSGraphicsContext restoreGraphicsState];
    
    
   
//NSFrameRect(aRect);

}



void DrawParallelogramInRect(NSRect rect, float withShift)
{
    NSBezierPath* thePath = [NSBezierPath bezierPath];
    [thePath moveToPoint:rect.origin];
    [thePath lineToPoint:NSMakePoint(rect.origin.x + withShift,  NSMaxY(rect))];
    [thePath lineToPoint:NSMakePoint(NSMaxX(rect), NSMaxY(rect))];
    [thePath lineToPoint:NSMakePoint(NSMaxX(rect) - withShift,  rect.origin.y)];
    [thePath closePath];
    
    [thePath stroke];
}

void DrawRectangle(NSRect aRect)
{
    NSRectFill(aRect);
    [NSBezierPath strokeRect:aRect];
}

void DrawRoundedRect(NSRect rect, CGFloat x, CGFloat y)
{
    NSBezierPath* thePath = [NSBezierPath bezierPath];
    [thePath appendBezierPathWithRoundedRect:rect xRadius:x yRadius:y];
    [thePath stroke];
    
   
}


- (void)saveImage {
    
    
    NSImage *viewImage = [[NSImage alloc] initWithData:[self dataWithPDFInsideRect:[self bounds]]];

    NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:[viewImage TIFFRepresentation]];
    
    NSDictionary *imageProps = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:1.0] forKey:NSImageCompressionFactor];
    NSData *imageData = [imageRep representationUsingType:NSJPEGFileType properties:imageProps];
    
    NSString *filePath = [NSString stringWithFormat:@"/Users/zhaojw/Documents/file%ld.png",22];
    
    [imageData writeToFile:filePath atomically:NO];
    
    
    return;
    NSRect r = [self frame];
    NSData* dataq = [self dataWithPDFInsideRect:r];
    NSPDFImageRep *img = [NSPDFImageRep imageRepWithData:dataq];
    NSImage *temp = [[NSImage alloc] init];
   [temp addRepresentation:img];
    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSInteger count = [img pageCount];
    
    for(NSInteger i = 0 ; i < count ; i++) {
        NSString *filePath = [NSString stringWithFormat:@"/Users/zhaojw/Documents/file%ld.png",i];
        [img setCurrentPage:i];
        NSImage *temp = [[NSImage alloc] init];
        [temp addRepresentation:img];
        NSBitmapImageRep *rep = [NSBitmapImageRep imageRepWithData:[temp TIFFRepresentation]];
        NSData *finalData = [rep representationUsingType:NSPNGFileType properties:nil];
        [fileManager createFileAtPath:filePath contents:finalData attributes:nil];
    }
}

@end
