//
//  TreeNodeModel.m
//  NSOutlineView
//
//  Created by zhaojw on 15/8/30.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import "TreeNodeModel.h"

@implementation TreeNodeModel



- (NSMutableArray*)childNodes
{
    if(!_childNodes){
        _childNodes = [NSMutableArray array];
    }
    
    return _childNodes;
}

@end
