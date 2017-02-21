//
//  DBDatabase.h
//  Database
//
//  Created by javaliker on 15/9/9.
//  Copyright (c) 2015年 javaliker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"

@interface DBDatabase : NSObject

@property(nonatomic,readonly) FMDatabase *db;

+ (instancetype)sharedInstance;

- (BOOL)openDBWithDBName:(NSString*)dbName;

- (void)close;

@end