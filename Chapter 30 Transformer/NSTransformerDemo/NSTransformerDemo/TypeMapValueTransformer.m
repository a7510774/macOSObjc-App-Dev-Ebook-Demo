//
//  TypeMapValueTransformer.m
//  NSTransformerDemo
//
//  Created by zhaojw on 11/29/15.
//  Copyright © 2015 zhaojw. All rights reserved.
//

#import "TypeMapValueTransformer.h"

static NSString *DBTypeString(DBDataType type) {
    static dispatch_once_t onceToken;
    static NSDictionary *types;
    dispatch_once(&onceToken, ^{
        types = @{
                    @(DBBoolDataType)   : @"Bool",
                    @(DBStringDataType) : @"String",
                    @(DBIntDataType)    : @"Int",
                    @(DBDateDataType)   : @"Date",
                    @(DBBlobDataType)   : @"Blob",
                };
        
    });
    return types[@(type)];
}

static DBDataType DBType(NSString * type) {
    static dispatch_once_t onceMethodToken;
    static NSDictionary *typeReverseMap;
    dispatch_once(&onceMethodToken, ^{
        
        typeReverseMap = @{
                              @"Bool"   :@(DBBoolDataType),
                              @"String" :@(DBStringDataType),
                              @"Int"    :@(DBIntDataType),
                              @"Date"   :@(DBDateDataType),
                              @"Blob"   :@(DBBlobDataType),
                             
                              };
        
    });
    return (DBDataType)([typeReverseMap[(type)] integerValue]);
}


 NSString* const kTypeMapValueTransformerName = @"TypeMapValueTransformerName";

@implementation TypeMapValueTransformer


+ (void) initialize
{
    TypeMapValueTransformer *transformer = [[self alloc]init];
    [NSValueTransformer setValueTransformer:transformer
                                    forName:kTypeMapValueTransformerName];
    
}

+ (Class)transformedValueClass {

    return [NSString class];
}

+ (BOOL)allowsReverseTransformation {

    return YES;
    
}

- (id)transformedValue:(id)value {

    DBDataType type = (DBDataType)[value integerValue];
    
    return DBTypeString(type);
    
}

-(id)reverseTransformedValue:(id)value {
    
    NSString *type = value;
    
    return @(DBType(type));
}

@end
