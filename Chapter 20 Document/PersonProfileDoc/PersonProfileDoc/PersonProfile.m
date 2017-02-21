//
//  PersonProfile.m
//  PersonProfileDoc
//
//  Created by zhaojw on 12/15/15.
//  Copyright © 2015 zhaojw. All rights reserved.
//

#import "PersonProfile.h"

#define  kPersonKey    @"PersonKey"

@implementation PersonProfile

//Decode archived data
- (id)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        _name = [coder decodeObjectForKey:@"name"];
        _age = [coder decodeIntegerForKey:@"age"];
        _address = [coder decodeObjectForKey:@"address"];
        _mobile = [coder decodeObjectForKey:@"mobile"];
        _image = [coder decodeObjectForKey:@"image"];
    }
    return self;
}

//Encode instance properties data
- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeInteger: self.age forKey:@"age"];
    [coder encodeObject:self.address forKey:@"address"];
    [coder encodeObject:self.mobile forKey:@"mobile"];
    [coder encodeObject:self.image forKey:@"image"];
}

//instantiate class from unarchivered data
+ (instancetype)profileFromData:(NSData *)data {
    
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]
                                     initForReadingWithData:data];
    PersonProfile *aPerson = [unarchiver decodeObjectForKey:kPersonKey];
    return aPerson;
}

//Archive instance 
- (NSData*)docData {
    
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]
                                 initForWritingWithMutableData:data];
    [archiver encodeObject:self forKey:kPersonKey];
    [archiver finishEncoding];
    
    return data;
}
@end
