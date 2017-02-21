//
//  TypeMapValueTransformer.h
//  NSTransformerDemo
//
//  Created by zhaojw on 11/29/15.
//  Copyright © 2015 zhaojw. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, DBDataType) {
    DBBoolDataType=1,//default value start from 1 
    DBStringDataType,
    DBIntDataType,
    DBDateDataType,
    DBBlobDataType,
};


extern NSString* const kTypeMapValueTransformerName ;

@interface TypeMapValueTransformer : NSValueTransformer

@end
