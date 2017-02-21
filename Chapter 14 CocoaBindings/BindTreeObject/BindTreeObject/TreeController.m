//
//  TreeController.m
//  BindTreeObject
//
//  Created by iDevFans on 2016/11/4.
//  Copyright © 2016年 macdev. All rights reserved.
//

#import "TreeController.h"

@implementation TreeController

- (NSMutableDictionary*)newObject {
    NSMutableDictionary *node  = [NSMutableDictionary dictionary];
    node[@"name"]=  @"Group";
    NSMutableArray *children=[NSMutableArray array];;
    node[@"children"]=  children;
    NSMutableDictionary *m1  = [NSMutableDictionary dictionary];
    
    m1[@"name"]=  @"m1";
    [children addObject:m1];
    
    NSMutableDictionary *m2  = [NSMutableDictionary dictionary];
    m2[@"name"]=  @"m2";
    [children addObject:m2];
    
    return node;
}

@end
