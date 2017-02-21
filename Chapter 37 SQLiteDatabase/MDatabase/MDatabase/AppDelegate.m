//
//  AppDelegate.m
//  MDatabase
//
//  Created by MacDev on 16/6/8.
//  Copyright © 2016年 http://www.macdev.io All rights reserved.
//

#import "AppDelegate.h"
#import "MDatabase.h"
#import "PersonDAO.h"
#import "Person.h"
#import "CodeGenerate.h"
#define  kDatabaseName   @"DatabaseDemo.sqlite"

@interface AppDelegate ()
@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    if(![[MDatabase sharedInstance]openDBWithName:kDatabaseName]){
        NSLog(@"Open Db %@ Failed!",kDatabaseName);
        return;
    }
    
    
    CodeGenerate *codeGenerate = [CodeGenerate new];
    [codeGenerate makeCode];
    
    //查询所有记录
    PersonDAO *personDAO = [[PersonDAO alloc]init];
    
    NSArray *persons = [personDAO findAll];
    
    for(Person *p in persons){
        NSLog(@"name %@",p.name);
        NSLog(@"address %@",p.address);
    }
    
    
    //修改并保存
    for(Person *p in persons){
        p.address = @"Japan";
        [p save];
    }
    
    
    persons = [personDAO findAll];
    
    for(Person *p in persons){
        NSLog(@"name %@",p.name);
        NSLog(@"new address %@",p.address);
    }
    
    
    //条件查询 name=to
    persons = [personDAO findByAttributes:@{@"name":@"to"}];
    
    for(Person *p in persons){
        NSLog(@"name %@",p.name);
    }
    
    //根据主键查询
    Person *person = [personDAO findByKey:@{@"id":@(1)}];
    //删除数据
    [person delete];

    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}



@end
