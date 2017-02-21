//
//  DBDatabase.m
//  Database
//
//  Created by javaliker on 15/9/9.
//  Copyright (c) 2015年 javaliker. All rights reserved.
//

#import "DBDatabase.h"

@interface DBDatabase ()
@property(nonatomic,readwrite)FMDatabase *db;
@property(nonatomic,strong)NSString *dbName;
@end

@implementation DBDatabase

+ (instancetype)sharedInstance;
{
    static DBDatabase *instace = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        instace = [[self alloc] init];
    });
    return instace;
}

- (void)dealloc
{
    [self close];
}

- (BOOL)openDBWithDBName:(NSString*)dbName
{
    self.dbName = dbName;
    
    NSString *dbPath = [self getDBPath];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL success = [fileManager fileExistsAtPath:dbPath];
    NSLog(@"\n createEditableCopyOfDatabaseIfNeeded database %@ \n",self.dbName);
    if (!success)
    {
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:self.dbName];
        success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
        if (!success) {
            NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
            return NO;
        }
        else {
            NSLog(@"\n create database success");
        }
    }
    
    self.db = [FMDatabase databaseWithPath:dbPath];
    
    if(![self.db open]){
        [self.db setShouldCacheStatements:YES];
        NSLog(@"error opening the database!");
        return NO;
    }
    return YES;
}

- (void)close
{
    [self.db close];
}

- (NSString*) getDBPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:self.dbName];
    return path;	
}

@end