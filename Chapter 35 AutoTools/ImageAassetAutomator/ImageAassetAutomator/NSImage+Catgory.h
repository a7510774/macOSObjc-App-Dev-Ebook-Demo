
//
//  NSImage+Catgory.h
//  ImageAassetAutomator
//
//  Created by zhaojw on 15/9/12.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSImage (Catgory)
- (NSImage*)reSize:(NSSize)resize;
- (void)saveAtPath:(NSString*)path;
@end
