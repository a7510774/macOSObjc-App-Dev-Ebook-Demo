//
//  NSImage+Catgory.m
//  ImageAassetAutomator
//
//  Created by zhaojw on 15/9/12.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import "NSImage+Catgory.h"

@implementation NSImage (Catgory)
- (void)saveAtPath:(NSString*)path{
    NSData *imageData = [self TIFFRepresentation];
    NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:imageData];
    NSDictionary *imageProps = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:1.0] forKey:NSImageCompressionFactor];
    imageData = [imageRep representationUsingType:NSPNGFileType properties:imageProps];
    [imageData writeToFile:path atomically:NO];
    
}
- (NSImage*)reSize:(NSSize)resize{
    
    float resizeWidth  = resize.width/2; // your desired width;
    float resizeHeight = resize.height/2; // your desired height;

    NSImage *resizedImage = [[NSImage alloc] initWithSize: NSMakeSize(resizeWidth, resizeHeight)];
    
    NSSize originalSize = [self size];
    
    [resizedImage lockFocus];
    [self drawInRect: NSMakeRect(0, 0, resizeWidth, resizeHeight) fromRect: NSMakeRect(0, 0, originalSize.width, originalSize.height) operation: NSCompositeSourceOver fraction: 1.0];
    [resizedImage unlockFocus];
    return resizedImage;
}



@end
