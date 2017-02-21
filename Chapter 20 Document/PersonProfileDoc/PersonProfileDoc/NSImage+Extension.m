//
//  NSImage+Extension.m
//  PersonProfileDoc
//
//  Created by zhaojw on 12/16/15.
//  Copyright © 2015 zhaojw. All rights reserved.
//

#import "NSImage+Extension.h"
#import "Base64.h"
@implementation NSImage(Extension)
- (NSImage*)fx_fromBase64Data:(NSString*)base64StrData {
    
    NSData *tiffData = [base64StrData base64DecodedData];
    
    NSImage *image = [[NSImage  alloc] initWithData:tiffData];
    
    return image;
}

- (NSString*)fx_toBase64String {
    
   // NSArray *keys = [NSArray arrayWithObject:@"NSImageCompressionFactor"];
   // NSArray *objects = [NSArray arrayWithObject:@"1.0"];
   // NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    
    NSDictionary *imageProps = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:0.9] forKey:NSImageCompressionFactor];
    

    NSBitmapImageRep *imageRep = [[NSBitmapImageRep alloc] initWithData:[self TIFFRepresentation]];
    
    NSData *tiffData = [imageRep representationUsingType:NSPNGFileType properties:imageProps];
    
    return [tiffData base64EncodedString];
}

@end
