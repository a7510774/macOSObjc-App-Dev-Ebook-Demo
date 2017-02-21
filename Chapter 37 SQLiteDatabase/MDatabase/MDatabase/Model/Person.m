/*
 Person.m
 project
 Created by author on 09/09/2015 10:57AM.
 Copyright (c) 2014 author. All rights reserved.
 */
#import "Person.h"
@implementation Person
/*init property member var by parsing NSDictionary parameter*/
- (id)initWithDictionary:(NSDictionary *)dictionary{
	if ((self = [super init]) && (dictionary))
	{
        id value ;
        value = dictionary[@"id"];
        if(value) _id = [value longValue];  

        value = dictionary[@"name"];
        if(value) _name = value;  

        value = dictionary[@"address"];
        if(value) _address = value;  

        value = dictionary[@"age"];
        if(value) _age = [value longValue];  

  
    }
    return self;  
}               
- (id)initWithCoder:(NSCoder *)coder{
	if ((self = [super init]))
	{
    	if ([coder allowsKeyedCoding])
	    {
            _id = [coder decodeIntegerForKey:@"id"];
            _name = [coder decodeObjectForKey:@"name"];  
            _address = [coder decodeObjectForKey:@"address"];  
            _age = [coder decodeIntegerForKey:@"age"];
        }
        else
        {
            _id = [[coder decodeObject]longValue];
            _name = [coder decodeObject];  
            _address = [coder decodeObject];  
            _age = [[coder decodeObject]longValue];
        
        }
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)coder {
	if ([coder allowsKeyedCoding])
	{
        [coder encodeInt64:_id forKey:@"id"];
        if(_name) [coder encodeObject:_name forKey:@"name"];
        if(_address) [coder encodeObject:_address forKey:@"address"];
        [coder encodeInt64:_age forKey:@"age"];
    }
    else
    {
        [coder encodeValueOfObjCType:@encode(long) at:&_id];
        if(_name) [coder encodeObject:_name];
        if(_address) [coder encodeObject:_address];
        [coder encodeValueOfObjCType:@encode(long) at:&_age];
    
    }
}
- (BOOL)isEqual:(Person *)obj {
    if(![obj isKindOfClass:Person.class])
    { 
        return NO;
    }
    return (self.id==obj.id)
    && ([self.name isEqual:obj.name])
    && ([self.address isEqual:obj.address])
    && (self.age==obj.age)
    ;
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
