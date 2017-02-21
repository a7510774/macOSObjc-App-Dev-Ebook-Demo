/*
 BuddyDetailDAO.m
 project
 Created by author on 03/10/2015 10:07PM.
 Copyright (c) 2014 author. All rights reserved.
 */
#import "BuddyDetailDAO.h"
@implementation BuddyDetailDAO
- (id)init{
    self = [super init];
    if (self) {
        self.tableName = @"BuddyDetail";
        self.fldList   = [[NSArray alloc]initWithObjects:@"ID",@"firstName",@"lastName",@"address",@"birthDay",@"image",nil];
        self.keyList   = [[NSArray alloc]initWithObjects:@"ID",nil];
        NSMutableSet *allFieldSet = [[NSMutableSet alloc]initWithArray:self.fldList];
        NSSet *keyFieldSet = [[NSSet alloc]initWithArray:self.keyList];
        [allFieldSet minusSet:keyFieldSet];
        self.fldExcludeKeyList = [allFieldSet allObjects];
    }
	return self;
}
@end

