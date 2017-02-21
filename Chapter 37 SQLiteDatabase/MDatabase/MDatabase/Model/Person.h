/*
 Person.h
 project
 Created by author on 09/09/2015 10:57AM.
 Copyright (c) 2014 author. All rights reserved.
 */
#import "MModel.h"
@interface Person : MModel
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, assign) NSInteger age;
/*init property member var by parsing NSDictionary parameter*/
- (id)initWithDictionary:(NSDictionary *)dictionary;
@end