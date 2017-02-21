/*
 BuddyDAO.m
 project
 Created by author on 03/10/2015 10:07PM.
 Copyright (c) 2014 author. All rights reserved.
 */
#import "BuddyDAO.h"
@implementation BuddyDAO
- (id)init{
    self = [super init];
    if (self) {
        self.tableName = @"Buddy";
        self.fldList   = [[NSArray alloc]initWithObjects:@"ID",@"nickName",@"status",nil];
        self.keyList   = [[NSArray alloc]initWithObjects:@"ID",nil];
        NSMutableSet *allFieldSet = [[NSMutableSet alloc]initWithArray:self.fldList];
        NSSet *keyFieldSet = [[NSSet alloc]initWithArray:self.keyList];
        [allFieldSet minusSet:keyFieldSet];
        self.fldExcludeKeyList = [allFieldSet allObjects];
    }
	return self;
}
@end

