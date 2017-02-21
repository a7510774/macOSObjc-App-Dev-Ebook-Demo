//
//  NSDictionary+safeSetValueForKey.h
//  XXXBonjourNetWork
//
//  Created by zhaojw on on 7/25/13.
//  Copyright (c) http://www.cocoahunt.com All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (safeSetValueForKey)
- (void)xx_setSafeValue:(id)value forKey:(NSString*)key;
@end
