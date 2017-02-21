//
//  Employee.h
//  BindDemo
//
//  Created by zhaojw on 15/9/25.
//  Copyright © 2015年 zhaojw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Employee : NSObject
@property(nonatomic,assign)NSInteger id;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,assign)NSInteger age;
@property(nonatomic,strong)NSString *address;
@end
