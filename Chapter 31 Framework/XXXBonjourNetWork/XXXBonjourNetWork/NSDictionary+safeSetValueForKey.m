//
//  NSDictionary+safeSetValueForKey.m
//  XXXBonjourNetWork
//
//  Created by zhaojw on on 7/25/13.
//  Copyright (c) http://www.cocoahunt.com All rights reserved.
//

#import "NSDictionary+safeSetValueForKey.h"

@implementation NSDictionary (safeSetValueForKey)
- (void)xx_setSafeValue:(id)value forKey:(NSString*)key
{
    if(value){
        [self setValue:value forKey:key];
    }
    else{
        NSLog(@"setSafeValue Error : key =%@ value null!",key);
    }
}
@end
