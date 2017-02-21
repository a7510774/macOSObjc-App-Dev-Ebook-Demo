//
//  CodeGenerate.m
//  MDatabase
//
//  Created by iDevFans on 16/6/9.
//  Copyright © 2016年 http://www.macdev.io. All rights reserved.
//

#import "CodeGenerate.h"
#import "DMTemplateEngine.h"
#import "MDatabase+Meta.h"
#import "Table.h"
#import "Field.h"
@implementation CodeGenerate

- (void)makeCode {
    NSArray *tables = [[MDatabase sharedInstance] tables];
    if([tables count]<=0){
        return;
    }
    
    DMTemplateEngine* engine = [DMTemplateEngine engine];
    NSString *headTemplate = [self loadModelTempalte:@"Model.hp"];
    NSString *sourceTemplate = [self loadModelTempalte:@"Model.mp"];
    
    for(Table *table in tables ){
        NSDictionary *templateData = [self templateParametersWithTable:table];
        //从文件加载头文件模版
        engine.template = headTemplate;
        //头文件源码渲染并写入文件
        NSString* renderedHeadTemplate = [engine renderAgainst:templateData];
        NSLog(@"renderedHeadTemplate\n %@ ",renderedHeadTemplate);
        NSString *headFileName = [NSString stringWithFormat:@"%@.h",table.name];
        [self createFileWithName:headFileName withFileConten:renderedHeadTemplate];
        
        //从文件加载实现文件模版
        engine.template = sourceTemplate;
        //实现文件源码渲染并写入文件
        NSString* renderedSourceTemplate = [engine renderAgainst:templateData];
        NSLog(@"renderedSourceTemplate\n %@ ",renderedSourceTemplate);
        NSString *sourceFileName = [NSString stringWithFormat:@"%@.m",table.name];
        [self createFileWithName:sourceFileName withFileConten:renderedSourceTemplate];
    }
}

- (NSString*)loadModelTempalte:(NSString*)modelName {
    NSString *filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:modelName];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSError *error;
    NSString *modelContent = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    return modelContent;
}

- (NSDictionary*)templateParametersWithTable:(Table*)table {
    NSMutableDictionary* templateData = [NSMutableDictionary dictionary];
    //参数设置
    [templateData setObject:table forKey:@"table"];
    [templateData setObject:@"Demo" forKey:@"Project"];
    [templateData setObject:@"MacDev" forKey:@"Author"];
    [templateData setObject:@"2016-06-09" forKey:@"CreateDate"];
    [templateData setObject:@"www.macdev.io" forKey:@"CopyRights"];
    
    return templateData;
}

- (void)createFileWithName:(NSString*)fileName withFileConten:(NSString*)content {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileOutPath = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    //创建输出文件
    [fm createFileAtPath:fileOutPath contents:nil attributes:nil];
    NSURL *outUrl = [NSURL fileURLWithPath:fileOutPath];
    
    //保存模版生成的内容到文件
    NSError *error;
    [content writeToURL:outUrl atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if(error){
        NSLog(@"save file error %@",error);
    }
}


@end
