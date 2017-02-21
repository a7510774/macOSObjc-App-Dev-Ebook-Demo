/*
 BuddyDetail.h
 project
 Created by author on 03/10/2015 10:07PM.
 Copyright (c) 2014 author. All rights reserved.
 */
#import "DBModel.h"
@interface BuddyDetail : DBModel
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *birthDay;
@property (nonatomic, strong) NSString *image;
/*init property member var by parsing NSDictionary parameter*/
- (id)initWithDictionary:(NSDictionary *)dictionary;
/*save new model object*/

@end