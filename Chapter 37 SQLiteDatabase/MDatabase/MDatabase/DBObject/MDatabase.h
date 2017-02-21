//
//  MDatabase.h
//  MDatabase
//
//  Created by MacDev on 16/6/8.
//  Copyright © 2016年 http://www.macdev.io All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMDatabaseQueue;
@interface MDatabase : NSObject
@property(nonatomic,readonly) FMDatabaseQueue *queue;
+ (instancetype)sharedInstance;
- (BOOL)openDBWithName:(NSString*)dbName;
- (void)close;
@end
