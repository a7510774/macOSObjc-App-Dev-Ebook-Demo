//
//  DragImageItem.m
//  DragDropDemo
//
//  Created by zhaojw on 15/10/21.
//  Copyright © 2015年 zhaojw. All rights reserved.
//

#import "DragImageItem.h"

//PboardType拖放类型
NSString*  kImagePboardType = @"com.idev.imageDrag";

@implementation DragImageItem


#pragma mark--  NSPasteboardReading

+ (NSArray *)readableTypesForPasteboard:(NSPasteboard *)pasteboard {
    return @[kImagePboardType];
}

- (id)initWithPasteboardPropertyList:(id)propertyList ofType:(NSString *)type {

    if ((self = [super init])) {
        _data = propertyList;
    }
    return self;
}

@end
