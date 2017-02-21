//
//  NSObject+Description.m
//  KVCDemo
//
//  Created by zhaojw on 15/9/22.
//  Copyright © 2015年 zhaojw. All rights reserved.
//

#import "NSObject+Description.h"


@implementation NSObject (asDictionary)

- (NSArray*)proNames
{
    unsigned int outCount, i;
    NSMutableArray *names = [NSMutableArray array];
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for(i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        if(propName) {
            NSString *propertyName = [NSString stringWithUTF8String:propName];
            [names addObject:propertyName];
        }
    }
    free(properties);
    
    return [names copy];
}


-(NSDictionary*) objectAsDictionary {
    
    NSDictionary *dict = [self dictionaryWithValuesForKeys:[self proNames]];

    return dict;
    
}


@end
