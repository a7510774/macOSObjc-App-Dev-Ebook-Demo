/*
 Buddy.m
 project
 Created by author on 03/10/2015 10:07PM.
 Copyright (c) 2014 author. All rights reserved.
 */
#import "Buddy.h"
@interface Buddy()
@end
@implementation Buddy
/*init property member var by parsing NSDictionary parameter*/
- (id)initWithDictionary:(NSDictionary *)dictionary{
	if ((self = [super init]) && (dictionary))
	{
        id value ;
        value = dictionary[@"ID"];
        if(value) _ID = [value longValue];  

        value = dictionary[@"nickName"];
        if(value) _nickName = value;  

        value = dictionary[@"status"];
        if(value) _status = [value boolValue];

  
    }
    return self;  
}               
- (id)initWithCoder:(NSCoder *)coder{
	if ((self = [super init]))
	{
    	if ([coder allowsKeyedCoding])
	    {
            _ID = [coder decodeIntegerForKey:@"ID"];
            _nickName = [coder decodeObjectForKey:@"nickName"];  
            _status = [coder decodeBoolForKey:@"status"];
        }
        else
        {
            _ID = [[coder decodeObject]longValue];
            _nickName = [coder decodeObject];  
            _status = [[coder decodeObject]boolValue];
        
        }
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)coder {
	if ([coder allowsKeyedCoding])
	{
        [coder encodeInt64:_ID forKey:@"ID"];
        if(_nickName) [coder encodeObject:_nickName forKey:@"nickName"];
        [coder encodeBool:_status forKey:@"status"];
    }
    else
    {
        [coder encodeValueOfObjCType:@encode(long) at:&_ID];
        if(_nickName) [coder encodeObject:_nickName];
        [coder encodeValueOfObjCType:@encode(BOOL) at:&_status];
    
    }
}
- (BOOL)isEqual:(Buddy *)obj {
    if(![obj isKindOfClass:Buddy.class])
    { 
        return NO;
    }
    return (self.ID==obj.ID)
    && ([self.nickName isEqual:obj.nickName])
    && (self.status==obj.status)
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
