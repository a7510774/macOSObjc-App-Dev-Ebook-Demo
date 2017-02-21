//
//  DBDAO.h
//  Database
//
//  Created by javaliker on 15/9/9.
//  Copyright (c) 2015年 javaliker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "DBDatabase.h"
#import <objc/runtime.h>

@interface DBDAO : NSObject


@property(nonatomic,readonly)NSInteger count;/*numbers of record in table*/
@property(nonatomic,copy)NSString  *tableName;/*table name*/
@property(nonatomic,strong)NSArray *fldList;/*all coulumn list*/
@property(nonatomic,strong)NSArray *keyList;/*primary key coulumn list*/
@property(nonatomic,strong)NSArray *fldExcludeKeyList;/*coulumn list */


/*return record total number*/
- (NSInteger)rowNumbers;

/* return page number according to page size */
- (NSInteger)pageNumberWithSize:(NSInteger)pageSize;

/*insert a record*/
- (BOOL)insert:(id)model;

/*update a record*/
- (BOOL)update:(id)model;

/*delete a record*/
- (BOOL)delete:(id)model;

/*execute  sql update in table*/
- (BOOL)sqlUpdate:(NSString*)sql;

/*execute  sql update in table*/
- (BOOL)sqlUpdate:(NSString*)sql withArgumentsInArray:(NSArray*)args;

/*execute  sql update in table*/
- (BOOL)sqlUpdate:(NSString*)sql withParameterDictionary:(NSDictionary*)dics;

/*execute  sql query in table*/
- (NSArray*)sqlQuery:(NSString*)sql;

/*execute  sql query in table*/
- (NSArray*)sqlQuery:(NSString*)sql  withArgumentsInArray:(NSArray*)args;

/*execute  sql query in table*/
- (NSArray*)sqlQuery:(NSString*)sql  withParameterDictionary:(NSDictionary*)dics;

/*delete all record*/
- (BOOL)removeAll;

/*fetch all record*/
- (NSArray*)findAll;

/*fetch record By Primary Key Field*/
- (id)findByKey:(id)key;

/*fetch MAX(column) By Primary Key Field*/
- (id)findMaxKey;

/*fetch records for given attributes*/
- (NSArray*)findByAttributes:(NSDictionary*)Attributes;

/*fetch records based on the index of pages*/
- (NSArray*)findByPage:(NSInteger)index pageSize:(NSInteger)pageSize;
@end
