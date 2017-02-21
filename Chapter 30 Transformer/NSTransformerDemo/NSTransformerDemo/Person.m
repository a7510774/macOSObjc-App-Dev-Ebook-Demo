/*
 Person.m
 project
 Created by author on 09/09/2015 10:57AM.
 Copyright (c) 2014 author. All rights reserved.
 */
#import "Person.h"
@implementation Person
/*init property member var by parsing NSDictionary parameter*/              
- (id)initWithCoder:(NSCoder *)coder{
	if ((self = [super init]))
	{
    	if ([coder allowsKeyedCoding])
	    {
            
            _name = [coder decodeObjectForKey:@"name"];  
            _address = [coder decodeObjectForKey:@"address"];  
            
        }
        else
        {
        
            _name = [coder decodeObject];  
            _address = [coder decodeObject];  
            
        
        }
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)coder {
	if ([coder allowsKeyedCoding])
	{
    
        if(_name) [coder encodeObject:_name forKey:@"name"];
        if(_address) [coder encodeObject:_address forKey:@"address"];
        
    }
    else
    {

        if(_name) [coder encodeObject:_name];
        if(_address) [coder encodeObject:_address];
       
    
    }
}

@end
