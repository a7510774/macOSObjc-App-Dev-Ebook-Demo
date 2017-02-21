//
//  TreeNodeModel.h
//  NSOutlineView
//
//  Created by zhaojw on 15/8/30.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TreeNodeModel : NSObject
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSMutableArray *childNodes;
@end
