//
//  DBDAO.m
//  Database
//
//  Created by javaliker on 15/9/9.
//  Copyright (c) 2015年 javaliker. All rights reserved.
//

#import "DBDAO.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "DBDatabase.h"
#import <sqlite3.h>
#import <objc/runtime.h>
#import "DBModel.h"
#import "Basic.h"

@interface DBDAO ()

@property(nonatomic,readwrite)NSInteger count;/*numbers of record in table*/
@property(nonatomic,assign)FMDatabase *db;
- (NSArray*)sqlQueryFetch:(FMResultSet*)rs;
- (id)findByModel:(id)model;

@end

@implementation DBDAO

/*init database */
- (id)init{
    self = [super init];
    if(self){
        _db = [DBDatabase sharedInstance].db;
        if(!_db){
            return  nil;
        }
    }
    return self;
}

/*return record total number*/
- (NSInteger)rowNumbers{
    if(!self.tableName){
        return 0;
    }
    NSString *sql =[NSString stringWithFormat:@"SELECT count(*) as count FROM %@", self.tableName];
    FMResultSet *rs = [self.db executeQuery:sql];
    _count = 0;
    if([rs next]) {
        _count  = [rs intForColumnIndex:0];
    }
    [rs close];
    return _count;
}
- (NSInteger)pageNumberWithSize:(NSInteger)pageSize;
{
    if(!self.tableName){
        return 0;
    }
    XXXAssert(pageSize>0);
    NSString *sql =[NSString stringWithFormat:@"SELECT count(*) as count FROM %@", self.tableName];
    FMResultSet *rs = [self.db executeQuery:sql];
    _count = 0;
    if([rs next]) {
        _count  = [rs intForColumnIndex:0];
    }
    [rs close];
    if(_count>0){
        return ceil(_count/pageSize);
    }
    else{
        return 0;
    }
}
/*insert a record*/
- (BOOL)insert:(id)model{
    if(!model){
        return NO;
    }
    
    NSInteger keyCount = [self.keyList count];
    if(keyCount>0){
        NSString *key = self.keyList[0];
        NSInteger keyID = [[model valueForKey:key]integerValue];
        if(keyID==0){
            keyID = [[self findMaxKey]integerValue]+1;
            [model setValue:@(keyID) forKey:key];
        }
    }
    //if(pro.ID==0){
    //pro.ID = [[self.dao findMaxKey]integerValue]+1;
    //}
    if([self findByKey:model]){
        DLog(@"info:add %@ exsist!\n",self.tableName);
        return [self update:model];
    }
    NSMutableString *vals = [[NSMutableString alloc]initWithCapacity:10];
    NSInteger fieldCount = [self.fldList count];
    for(NSInteger i =0 ;i < fieldCount;i++){
        if(i!=fieldCount-1){
            [vals appendString:@"?,"];
        }
        else{
            [vals appendString:@"?"];
        }
    }
    NSString *fieldString = [self.fldList componentsJoinedByString:@","];
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (%@) VALUES ( %@ )",self.tableName,fieldString,vals];
    DLog(@"insert sql=%@",sql)
    NSMutableArray *args=[[NSMutableArray alloc]initWithCapacity:10];
    for(NSInteger i =0 ;i < fieldCount;i++){
        NSString *mapkey = [self.fldList objectAtIndex:i];
        id value = [model valueForKey:mapkey];
        if(!value){
            value = [NSNull null];
        }
        [args addObject:value];
    }

   
    BOOL  isOK = [self.db executeUpdate:sql withArgumentsInArray:args];
        DLog("insert lastErrorMessage =%@",[self.db lastErrorMessage]);
    
    return isOK;
}
/*update a record*/
- (BOOL)update:(id)model{
    if(!model){
        return NO;
    }
    if(![self findByKey:model]){
        DLog(@"info:no exsist update Model!\n");
        return NO;
    }
    NSMutableString *wheres = [[NSMutableString alloc]initWithCapacity:10];
    NSInteger keyCount = [self.keyList count];
    NSMutableString *fieldVals = [[NSMutableString alloc]initWithCapacity:10];
    NSMutableArray *args=[NSMutableArray arrayWithCapacity:5];
    NSInteger fieldCount = [self.fldExcludeKeyList count];
    for(NSInteger i =0 ;i < fieldCount;i++){
        NSString *fName = [self.fldExcludeKeyList objectAtIndex:i];
        if(i!=fieldCount-1){
            [fieldVals appendFormat:@"%@ = ? , ",fName];
        }
        else{
            [fieldVals appendFormat:@"%@ = ? ",fName];
            
        }
        id value = [model valueForKey:fName];
        if(!value){
            value = [NSNull null];
        }
        [args addObject:value];
    }
    if(fieldCount<=0){
        for(NSInteger i =0 ;i < keyCount;i++){
            NSString *fName = [self.keyList objectAtIndex:i];
            if(i!=keyCount-1){
                
                [fieldVals appendFormat:@"%@ = ? , ",fName];
            }
            else{
                [fieldVals appendFormat:@"%@ = ? ",fName];
                
            }
            id value = [model valueForKey:fName];
            if(!value){
                value = [NSNull null];
            }
            [args addObject:value];
        }
    }
    
    for(NSInteger i =0 ;i < keyCount;i++){
        NSString *fName = [self.keyList objectAtIndex:i];
        if(i!=keyCount-1){
            
            [wheres appendFormat:@"%@ = ? AND ",fName];
        }
        else{
            [wheres appendFormat:@"%@ = ? ",fName];
            
        }
        id value = [model valueForKey:fName];
        if(!value){
            value = [NSNull null];
        }
        [args addObject:value];
    }
    NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET %@ WHERE %@ ",self.tableName,fieldVals,wheres];
    
    DLog(@"update sql=%@",sql);
    
    BOOL isOK = [self.db executeUpdate:sql withArgumentsInArray:args];
        DLog("update lastErrorMessage =%@",[self.db lastErrorMessage]);

    return isOK;
    
}
/*delete a record*/
- (BOOL)delete:(id)model{
    if(!model){
        return NO;
    }
    if(![self findByKey:model]){
        DLog(@"info:no exsist delete model!\n");
        return NO;
    }
    NSMutableString *wheres = [[NSMutableString alloc]initWithCapacity:10];
    NSInteger keyCount = [self.keyList count];
    for(NSInteger i =0 ;i < keyCount;i++){
        NSString *fName = [self.keyList objectAtIndex:i];
        if(i!=keyCount-1){
            
            [wheres appendFormat:@"%@ = ? AND ",fName];
        }
        else{
            [wheres appendFormat:@"%@ = ? ",fName];
            
        }
    }
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM  %@ WHERE %@ ",self.tableName,wheres];
    NSMutableArray *args=[[NSMutableArray alloc]initWithCapacity:10];
    for(NSInteger i =0 ;i < keyCount;i++){
        NSString *mapkey = [self.keyList objectAtIndex:i];
        id value = [model valueForKey:mapkey];
        [args addObject:value];
    }
    DLog(@"delete sql=%@",sql);
    BOOL isOK  = [self.db executeUpdate:sql withArgumentsInArray:args];
        DLog("delete lastErrorMessage =%@",[self.db lastErrorMessage]);
    
    return isOK;
}

/*execute  sql update in table*/
- (BOOL)sqlUpdate:(NSString*)sql{
   
    return [self.db executeUpdate:sql];;
}
/*execute  sql update in table*/
- (BOOL)sqlUpdate:(NSString*)sql withArgumentsInArray:(NSArray*)args{
    if(args.count>0){
        return [self.db executeUpdate:sql withArgumentsInArray:args];
    }
    else{
        return [self.db executeUpdate:sql withArgumentsInArray:nil];
    }
}
/*execute  sql update in table*/
- (BOOL)sqlUpdate:(NSString*)sql withParameterDictionary:(NSDictionary*)dics{
    NSInteger count =dics.allKeys.count;
    if(!dics || count==0){
        return  [self.db executeUpdate:sql];
    }
    return [self.db executeUpdate:sql withParameterDictionary:dics];
}
/*execute  sql query in table*/
- (NSArray*)sqlQuery:(NSString*)sql{
    FMResultSet *rs = [self.db executeQuery:sql];
    return [self sqlQueryFetch:rs];
}
/*execute  sql query in table*/
- (NSArray*)sqlQuery:(NSString*)sql  withArgumentsInArray:(NSArray*)args{
    FMResultSet *rs;
    if(args.count>0){
        rs = [self.db executeQuery:sql withArgumentsInArray:args];
    }
    else{
        rs = [self.db executeQuery:sql];
    }
    return [self sqlQueryFetch:rs];
}
/*execute  sql query in table*/
- (NSArray*)sqlQuery:(NSString*)sql  withParameterDictionary:(NSDictionary*)dics{
    NSInteger count =dics.allKeys.count;
    if(!dics || count==0){
        return  [self sqlQuery:sql];
    }
    FMResultSet *rs = [self.db executeQuery:sql withParameterDictionary:dics];
    return [self sqlQueryFetch:rs];
}

/*delete all record*/
- (BOOL)removeAll;
{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM  %@ ",self.tableName];
    DLog(@"clearAll sql=%@",sql);
    
    BOOL  isOK = [self.db executeUpdate:sql];
    DLog("clearAll lastErrorMessage =%@",[self.db lastErrorMessage]);
    
    return isOK;
}
/*fetch all record*/
- (NSArray*)findAll{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM  %@  ",self.tableName];
    DLog(@"findAll sql=%@",sql);
    FMResultSet *rs = [self.db executeQuery:sql];
    return [self sqlQueryFetch:rs];
}
/*fetch record By Primary Key Field*/
- (id)findByKey:(id)key{
    if([key isKindOfClass:[NSClassFromString(self.tableName) class]]){
        return  [self findByModel:key];
    }
    else if([key isKindOfClass:[NSDictionary class]]) {
        id retModel = [[NSClassFromString(self.tableName) alloc] init];
        NSInteger keyCount = self.keyList.count;
        for(NSInteger i =0 ;i < keyCount;i++){
            NSString *mapkey = [self.keyList objectAtIndex:i];
            id value = [key valueForKey:mapkey];
            [retModel setValue:value forKey:mapkey];
        }
        return  [self findByModel:retModel];
        
    }
    else{
        id retModel = [[NSClassFromString(self.tableName) alloc] init];
        NSInteger keyCount = self.keyList.count;
        for(NSInteger i =0 ;i < keyCount;i++){
            NSString *mapkey = [self.keyList objectAtIndex:i];
            [retModel setValue:key forKey:mapkey];
        }
        return  [self findByModel:retModel];
    }
    
}
- (id)findByModel:(id)model{
    if(!model){
        return nil;
    }
    NSInteger keyCount = [self.keyList count];
    if(keyCount<=0){
        DLog(@"table no primary key field!");
        return nil;
    }
    NSMutableString *wheres = [[NSMutableString alloc]initWithCapacity:10];
    for(NSInteger i =0 ;i < keyCount;i++){
        NSString *fName = [self.keyList objectAtIndex:i];
        if(i!=keyCount-1){
            
            [wheres appendFormat:@"%@ = ? AND ",fName];
        }
        else{
            [wheres appendFormat:@"%@ = ? ",fName];
            
        }
    }
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM  %@  WHERE %@ ",self.tableName,wheres];
    NSMutableArray *args=[[NSMutableArray alloc]initWithCapacity:10];
    for(NSInteger i =0 ;i < keyCount;i++){
        NSString *mapkey = [self.keyList objectAtIndex:i];
        id value = [model valueForKey:mapkey];
        [args addObject:value];
    }
    DLog(@"findByKey sql=%@",sql);
    
    FMResultSet *rs = [self.db executeQuery:sql withArgumentsInArray:args];
    if ([rs next]) {
        id retModel = [[NSClassFromString(self.tableName) alloc] init];
        for(NSString  *mapkey in self.fldList){
            id obj=[rs objectForColumnName: mapkey];
            if([obj isEqual:[NSNull null]]){
                continue;
            }
            [retModel setValue:obj forKey:mapkey];
        }
        [rs close];
       
        return retModel ;
    }
    return nil;
}
/*fetch records for given attributes*/
- (NSArray*)findByAttributes:(NSDictionary*)Attributes{
    NSMutableString *wheres = [[NSMutableString alloc]initWithCapacity:10];
    NSInteger keyCount = [Attributes.allKeys count];
    if(keyCount<=0){
        DLog(@"findByAttributes :  attribute parameter is null  !");
        return nil;
    }
    for(NSInteger i =0 ;i < keyCount;i++){
        NSString *fName = [Attributes.allKeys objectAtIndex:i];
        if(i!=keyCount-1){
            [wheres appendFormat:@"%@ = :%@ AND ",fName,fName];
        }
        else{
            [wheres appendFormat:@"%@ = :%@ ",fName,fName];
        }
    }
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM  %@  WHERE %@ ",self.tableName,wheres];
    DLog(@"findByAttributes sql=%@",sql);
    FMResultSet *rs = [self.db executeQuery:sql withParameterDictionary:Attributes];
    return [self sqlQueryFetch:rs];
}
/*fetch records based on the index of pages*/
- (NSArray*)findByPage:(NSInteger)index pageSize:(NSInteger)pageSize{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM  %@  LIMIT %ld OFFSET %ld ",self.tableName,pageSize,pageSize*index];
    DLog(@"findByPage sql=%@ pageindex=%ld",sql,index);
    FMResultSet *rs = [self.db executeQuery:sql];
    return [self sqlQueryFetch:rs];
}
- (NSArray*)sqlQueryFetch:(FMResultSet*)rs{
    NSMutableArray *modles  = [[NSMutableArray alloc]initWithCapacity:10];
    while ([rs next]) {
        id model = [[NSClassFromString(self.tableName) alloc] init];
        for(NSString  *mapkey in self.fldList){
            id obj=[rs objectForColumnName: mapkey];
            if([obj isEqual:[NSNull null]]){
                continue;
            }
            [model setValue:obj forKey:mapkey];
        }
      
        [modles addObject:model];
    }
    [rs close];
    if(modles.count>0){
        return  modles;
    }
    return nil;
}
/*fetch MAX(column) By Primary Key Field*/
- (id)findMaxKey
{
    NSInteger keyCount = [self.keyList count];
    if(keyCount<=0){
        DLog(@"table no primary key field!");
        return @(1);
    }
    NSString *sql = [NSString stringWithFormat:@"SELECT max(%@) FROM  %@  ",self.keyList[0],self.tableName];
    DLog(@"findMaxKey sql=%@",sql);
    FMResultSet *rs = [self.db executeQuery:sql];
    id maxValue = @(1);
    if ([rs next]) {
        maxValue = [rs objectForColumnIndex:0];
        if(maxValue && ![maxValue isEqual:[NSNull null]]){
            [rs close];
            return maxValue;
        }
    }
    [rs close];
    return @(1);
}
@end
