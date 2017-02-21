/*
 Buddy.h
 project
 Created by author on 03/10/2015 10:07PM.
 Copyright (c) 2014 author. All rights reserved.
 */
#import "DBModel.h"
@interface Buddy : DBModel
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, assign) BOOL status;
/*init property member var by parsing NSDictionary parameter*/
- (id)initWithDictionary:(NSDictionary *)dictionary;

@end