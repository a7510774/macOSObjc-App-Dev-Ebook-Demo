//
//  TreeNode.h
//  BindTreeObject
//
//  Created by iDevFans on 2016/11/4.
//  Copyright © 2016年 macdev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TreeNode : NSObject
@property(nonatomic,strong)NSString *nodeName;//名称
@property(nonatomic,assign)NSInteger count;//子节点个数
@property(nonatomic,assign)BOOL isLeaf;//是否叶子节点
@property(nonatomic,strong)NSArray *children;//子节点
@end
