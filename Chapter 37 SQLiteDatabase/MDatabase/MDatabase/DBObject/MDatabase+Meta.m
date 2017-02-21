//
//  MDatabase+Meta.m
//  MDatabase
//
//  Created by iDevFans on 16/6/9.
//  Copyright © 2016年 http://www.macdev.io. All rights reserved.
//

#import "MDatabase+Meta.h"
#import "FMDatabaseQueue.h"
#import "FMDatabase.h"
#import "Table.h"
#import "Field.h"
@implementation MDatabase (Meta)

- (NSArray*)tables {
    NSMutableArray *tables = [NSMutableArray array];
    [self.queue inDatabase:^(FMDatabase *db) {
        NSString *sql = @"SELECT * FROM sqlite_master where type = 'table' ";
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            //NSDictionary *dict = [rs resultDictionary];
            NSString *tableName = [rs stringForColumn:@"tbl_name"];
            Table *table = [[Table alloc]init];
            table.name = tableName;
            [tables addObject:table];
        }
        [rs close];
        
        for(Table *table in tables){
            NSString *tableSQL = [[NSString alloc] initWithFormat:@" PRAGMA table_info ( %@ ) ", table.name];
            FMResultSet *rs = [db executeQuery:tableSQL];
            NSMutableArray *fields =  [NSMutableArray array];
            while ([rs next]) {
                NSDictionary *dict = [rs resultDictionary];
                Field *field= [[Field alloc]init];
                NSString *fName = [rs stringForColumn:@"name"];
                NSString *fType = [rs stringForColumn:@"type"];
                field.name = fName;
                field.type = fType;
                [fields addObject:field];
            }
            [rs close];
            table.fields = fields;
        }

    }];
    return tables;
}

@end
