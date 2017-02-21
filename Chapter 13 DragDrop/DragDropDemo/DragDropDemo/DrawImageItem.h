//
//  DrawImageItem.h
//  DragDropDemo
//
//  Created by zhaojw on 15/10/21.
//  Copyright © 2015年 zhaojw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DrawImageItem : NSObject
@property(nonatomic,strong)NSImage *image;
@property(nonatomic,assign)NSPoint location;
@end
