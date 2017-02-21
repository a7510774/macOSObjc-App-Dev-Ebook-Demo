//
//  JSONObjKit.m
//  JSON
//
//  Created by zhaojw on 15/9/6.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import "JSONObjKit.h"

@implementation NSString (JSONKit)

- (id)mutableObjectFromJSONString
{
    id obj = [self objectFromJSONString];
    id retObj;
    if([obj isKindOfClass:[NSArray class]]){
        retObj = [NSMutableArray arrayWithArray:obj];
    }
    if([obj isKindOfClass:[NSDictionary class]]){
        retObj = [NSMutableDictionary dictionaryWithDictionary:obj];
    }
    return retObj;
}

- (id)objectFromJSONString
{
    NSError *error = nil;
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    id jsonDict = [NSJSONSerialization JSONObjectWithData:data
                                                  options:NSJSONReadingAllowFragments
                                                    error:&error];
    if(!jsonDict) {
        
        NSLog(@"%@", error);
        return nil;
    }
    return jsonDict;

}

@end


@implementation NSData (JSONKit)
- (id)objectFromJSONData
{
     NSError *error = nil;
    
    id jsonDict = [NSJSONSerialization JSONObjectWithData:self
                                                  options:NSJSONReadingAllowFragments
                                                    error:&error];
    if(!jsonDict) {
        
        NSLog(@"%@", error);
        return nil;
    }
    return jsonDict;
}
- (id)mutableObjectFromJSONData
{
    id obj = [self objectFromJSONData];
    id retObj;
    if([obj isKindOfClass:[NSArray class]]){
        retObj = [NSMutableArray arrayWithArray:obj];
    }
    if([obj isKindOfClass:[NSDictionary class]]){
        retObj = [NSMutableDictionary dictionaryWithDictionary:obj];
    }
    return retObj;
    
}
@end


@implementation NSArray (JSONKit)
- (NSString*)JSONString{
    NSError *writeError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&writeError];
    if(!writeError){
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonString;
    }
    else{
        NSLog(@"NSArray JSON Failed:%@ Error=%@",self,writeError);
    }
    return nil;
}
- (NSData*)JSONData{
    NSError *writeError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&writeError];
    if(!writeError){
        return jsonData;
    }
    return nil;
}


@end


@implementation NSDictionary (JSONKit)
- (NSString*)JSONString{
    NSError *writeError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&writeError];
    if(!writeError){
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonString;
    }
    else{
        NSLog(@"NSDictionary JSON Failed:%@ Error=%@",self,writeError);
    }
    return nil;
}
- (NSData*)JSONData{
    NSError *writeError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&writeError];
    if(!writeError){
        return jsonData;
    }
    NSLog(@"JSONData Failed:%@ Error=%@",self,writeError);
    return nil;
}

@end
