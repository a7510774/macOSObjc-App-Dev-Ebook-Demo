//
//  DBModel.m
//  Database
//
//  Created by javaliker on 15/9/9.
//  Copyright (c) 2015年 javaliker. All rights reserved.
//

#import "DBModel.h"
#import "DBDAO.h"

@interface DBModel ()
@property(nonatomic,strong)DBDAO *dao;
@end

@implementation DBModel
- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(!self){
        return nil;
    }
    return self;
}
- (DBDAO*)dao
{
    if(!_dao){
        
        NSString *selfName = NSStringFromClass([self class]);
        
        NSString *className = [NSString stringWithFormat:@"%@DAO",selfName];
        
        Class class = NSClassFromString(className);
        
        return [[class alloc]init];
    }
    return _dao;
}

- (BOOL)save
{
    return [self.dao insert:self];
}

- (BOOL)update
{
    return [self.dao update:self];
}

- (BOOL)delete
{
    return [self.dao delete:self];
}


@end
