//
//  DragImageItem.h
//  DragDropDemo
//
//  Created by zhaojw on 15/10/21.
//  Copyright © 2015年 zhaojw. All rights reserved.
//
@import AppKit;
#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString*  kImagePboardType;

@interface DragImageItem : NSObject <NSPasteboardReading>
@property(nonatomic,strong)NSData *data;
@end
