//
//  JSONObjKit.h
//  JSON
//
//  Created by zhaojw on 15/9/6.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JSONKit)
- (id)objectFromJSONString;
- (id)mutableObjectFromJSONString;
@end


@interface NSData (JSONKit)
- (id)objectFromJSONData;
- (id)mutableObjectFromJSONData;
@end


@interface NSArray (JSONKit)
- (NSString*)JSONString;
- (NSData*)JSONData;
@end


@interface NSDictionary (JSONKit)
- (NSString*)JSONString;
- (NSData*)JSONData;
@end