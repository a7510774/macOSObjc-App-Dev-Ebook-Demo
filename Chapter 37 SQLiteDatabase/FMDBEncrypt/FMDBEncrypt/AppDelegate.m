//
//  AppDelegate.m
//  FMDBEncrypt
//
//  Created by zhaojw on 15/9/9.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import "AppDelegate.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "sqlite3.h"


#define kDBKEY           @"dfgdgf"
#define kDBName          @"Database.sqlite"
#define kDBEncryptName   @"DatabaseSwift2.sqlite"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end



@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    NSString *originalDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:kDBName];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *newPath = [documentsDirectory stringByAppendingPathComponent:kDBEncryptName];
    

    FMDatabase *db = [FMDatabase databaseWithPath:newPath];
    
    if (![db open]) {
        return;
    }else{
        [db setKey:kDBKEY];
    }
    
    FMResultSet *s = [db executeQuery:@"SELECT * FROM Person"];
    while ([s next]) {
        NSLog(@"%@", [s resultDictionary]);
    }
    
    
    if([db goodConnection]){
    
        const char* SQL = [[NSString stringWithFormat:@"ATTACH DATABASE '%@' AS encrypted KEY '%@';",newPath,kDBKEY] UTF8String];
        
        sqlite3 *unencrypted_DB;
        
        if (sqlite3_open([originalDBPath UTF8String], &unencrypted_DB) == SQLITE_OK) {
            
        
            sqlite3_exec(unencrypted_DB, SQL, NULL, NULL, NULL);
            
          
            sqlite3_exec(unencrypted_DB, "SELECT sqlcipher_export('encrypted');", NULL, NULL, NULL);
            
      
            sqlite3_exec(unencrypted_DB, "DETACH DATABASE encrypted;", NULL, NULL, NULL);
            
          
            sqlite3_close(unencrypted_DB);
            
            NSLog(@"newPath %@",newPath);
            
            
            FMDatabase *enDB = [FMDatabase databaseWithPath:newPath];
           
            if (![enDB open]) {
                
                enDB = nil;

                return;
            }
            else {
                [enDB setKey:kDBKEY];
            }
            
            
            FMResultSet *s = [enDB executeQuery:@"SELECT * FROM Person"];
            while ([s next]) {
                NSLog(@"%@", [s resultDictionary]);
            }
            
            
        }
        else {
            sqlite3_close(unencrypted_DB);
            
        }

    }
    
    else{
        
        FMResultSet *s = [db executeQuery:@"SELECT * FROM person"];
        while ([s next]) {
            NSLog(@"%@", [s resultDictionary]);
        }
        
    }
    
    
  
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}










@end
