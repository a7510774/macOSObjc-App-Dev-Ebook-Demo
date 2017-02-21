/*
 PersonDAO.m
 project
 Created by author on 09/09/2015 10:57AM.
 Copyright (c) 2014 author. All rights reserved.
 */
#import "PersonDAO.h"
@implementation PersonDAO
- (id)init{
    self = [super init];
    if (self) {
        self.tableName = @"Person";
        self.fldList   = [[NSArray alloc]initWithObjects:@"id",@"name",@"address",@"age",nil];
        self.keyList   = [[NSArray alloc]initWithObjects:@"id",nil];
        NSMutableSet *allFieldSet = [[NSMutableSet alloc]initWithArray:self.fldList];
        NSSet *keyFieldSet = [[NSSet alloc]initWithArray:self.keyList];
        [allFieldSet minusSet:keyFieldSet];
        self.fldExcludeKeyList = [allFieldSet allObjects];
    }
	return self;
}
@end

