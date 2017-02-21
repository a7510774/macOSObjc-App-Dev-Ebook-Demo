/*
 BuddyDetail.m
 project
 Created by author on 03/10/2015 10:07PM.
 Copyright (c) 2014 author. All rights reserved.
 */
#import "BuddyDetail.h"
#import "BuddyDetailDAO.h"
@interface BuddyDetail()
@property(nonatomic,strong)BuddyDetailDAO *dao;
@end
@implementation BuddyDetail
/*init property member var by parsing NSDictionary parameter*/
- (id)initWithDictionary:(NSDictionary *)dictionary{
    if ((self = [super init]) && (dictionary))
    {
        id value ;
        value = dictionary[@"ID"];
        if(value) _ID = [value longValue];
        
        value = dictionary[@"firstName"];
        if(value) _firstName = value;
        
        value = dictionary[@"lastName"];
        if(value) _lastName = value;
        
        value = dictionary[@"address"];
        if(value) _address = value;
        
        value = dictionary[@"birthDay"];
        if(value) _birthDay = value;
        
        value = dictionary[@"image"];
        if(value) _image = value;
        
        
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)coder{
    if ((self = [super init]))
    {
        if ([coder allowsKeyedCoding])
        {
            _ID = [coder decodeIntegerForKey:@"ID"];
            _firstName = [coder decodeObjectForKey:@"firstName"];
            _lastName = [coder decodeObjectForKey:@"lastName"];
            _address = [coder decodeObjectForKey:@"address"];
            _birthDay = [coder decodeObjectForKey:@"birthDay"];
            _image = [coder decodeObjectForKey:@"image"];
        }
        else
        {
            _ID = [[coder decodeObject]longValue];
            _firstName = [coder decodeObject];
            _lastName = [coder decodeObject];
            _address = [coder decodeObject];
            _birthDay = [coder decodeObject];
            _image = [coder decodeObject];
            
        }
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)coder {
    if ([coder allowsKeyedCoding])
    {
        [coder encodeInt64:_ID forKey:@"ID"];
        if(_firstName) [coder encodeObject:_firstName forKey:@"firstName"];
        if(_lastName) [coder encodeObject:_lastName forKey:@"lastName"];
        if(_address) [coder encodeObject:_address forKey:@"address"];
        if(_birthDay) [coder encodeObject:_birthDay forKey:@"birthDay"];
        if(_image) [coder encodeObject:_image forKey:@"image"];
    }
    else
    {
        [coder encodeValueOfObjCType:@encode(long) at:&_ID];
        if(_firstName) [coder encodeObject:_firstName];
        if(_lastName) [coder encodeObject:_lastName];
        if(_address) [coder encodeObject:_address];
        if(_birthDay) [coder encodeObject:_birthDay];
        if(_image) [coder encodeObject:_image];
        
    }
}
- (BOOL)isEqual:(BuddyDetail *)obj {
    if(![obj isKindOfClass:BuddyDetail.class])
    {
        return NO;
    }
    return (self.ID==obj.ID)
    && ([self.firstName isEqual:obj.firstName])
    && ([self.lastName isEqual:obj.lastName])
    && ([self.address isEqual:obj.address])
    && ([self.birthDay isEqual:obj.birthDay])
    && ([self.image isEqual:obj.image])
    ;
}
- (NSDictionary*)JSONKeyPathsByPropertyKey
{
    return nil;
}
-(BOOL) allowsKeyedCoding
{
    /*[self setValuesForKeysWithDictionary:jsonObject];*/
    return YES;
}
- (id)valueForUndefinedKey:(NSString *)key
{
    // subclass implementation should provide correct key value mappings for custom keys
    NSLog(@"Undefined Key: %@", key);
    return nil;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    // subclass implementation should set the correct key value mappings for custom keys
    NSLog(@"Undefined Key: %@", key);
}



@end
