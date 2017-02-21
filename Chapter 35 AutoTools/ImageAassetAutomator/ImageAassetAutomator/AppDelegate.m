//
//  AppDelegate.m
//  ImageAassetAutomator
//
//  Created by zhaojw on 15/9/12.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import "AppDelegate.h"
#import "DragImageZone.h"
#import "DragExportButton.h"
#import "NSImage+Catgory.h"
#import "JSONObjKit.h"

#define  kIPhone   @"iPhone"
#define  kIPad     @"iPad"
#define  kOSX      @"OSX"

#define  kAppIconFolderName        @"AppIcon.appiconset"
#define  kAppIconContensFileName   @"Contents.json"


typedef NS_ENUM(NSInteger,AppImageType){
    AppImageIPhoneType = 0,
    AppImageIPadType  = 1,
    AppImageiPoneIPadType  = 2,
    AppImageOSXType    = 3,

};


@interface AppDelegate ()<DragImageZoneDelegate,DragExportButtonDelegate>
@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet DragImageZone *imageDragZone;
@property (weak) IBOutlet DragExportButton *dragExportButton;
@property(nonatomic,strong)NSString *largeImagePath;
@property(nonatomic,strong)NSString *assetPath;
@property(nonatomic,strong)NSDictionary  *imageScaleConfig;
@property (weak) IBOutlet NSComboBox *platFormComboBox;
@property(nonatomic,strong)NSString *exportPath;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
   
    self.imageDragZone.delegate = self;
    
    self.dragExportButton.delegate = self;
    
    [self readImageScaleConfig];
    
    [self.dragExportButton setEnabled:NO];
}



- (void)readImageScaleConfig
{
    NSBundle *bundle = [ NSBundle mainBundle ];
    
    NSString *filePath = [ bundle pathForResource:@"imageSize" ofType:@"plist" ];
    
    NSError *error;
    NSData *data = [NSData dataWithContentsOfFile:filePath
                                          options:NSMappedRead error:&error];
   
    NSPropertyListFormat format;
    
    NSDictionary * dataMap = (NSDictionary*)[NSPropertyListSerialization propertyListWithData:data options:NSPropertyListMutableContainersAndLeaves                                     format:&format  error:&error];
    
    self.imageScaleConfig =  dataMap;

}

- (IBAction)makeAppIconAction:(id)sender
{
    
    [self makeAsserts];
   
}

- (void)makeAsserts
{
    if(!self.largeImagePath){
        return;
    }
    
    NSInteger selectedIndex = self.platFormComboBox.indexOfSelectedItem;
    
    if(selectedIndex<0){
        selectedIndex = 0;
    }
    
    AppImageType appIconType = (AppImageType)selectedIndex;
    
    //图片裁剪
    [self makeAppIconWithType:appIconType];
    
    //Contents.json文件生成
    [self makeJSONFileWithType:appIconType];
}

- (void)makeiPhoneStyleAppIcon
{
    [self makeAppIconWithType:AppImageIPhoneType];
}


- (void)makeiPadStyleAppIcon
{
    [self makeAppIconWithType:AppImageIPadType];
}


- (void)makeiPhoneIPadStyleAppIcon
{
    [self makeAppIconWithType:AppImageiPoneIPadType];
   
}

- (void)makeOSXStyleAppIcon
{
    [self makeAppIconWithType:AppImageOSXType];
    
}

- (void)makeAppIconWithType:(AppImageType)type {

    
    NSString *imageFolerPath  = [self.exportPath stringByAppendingPathComponent:kAppIconFolderName];
    
    BOOL isOK = [self createPathIfNeded:imageFolerPath];
    
    if(!isOK){
        return;
    }
    
    //清除目录,防止以前存在垃圾文件
    [self clearAllFilesAtPath:imageFolerPath];
    
    NSImage *largeImage = [[NSImage alloc]initWithContentsOfFile:self.largeImagePath];
    
    NSArray *configs = [self configItemWithType:type];
    
    for(NSDictionary *config in configs){
        
        NSDictionary *imageSizeConfig = config[@"imageSizeConfig"];
        
        NSString *imageFlag =  config[@"imageFlag"];;
        
        NSArray *keys = [imageSizeConfig allKeys];
        
        for(NSString *key in keys){
            
            NSArray *scales = imageSizeConfig[key];
            
            NSInteger size = [key integerValue];
            
            for(NSNumber *scale in scales)
            {
                int retion = [scale intValue];
                
                NSSize imageSize = NSMakeSize(size*retion, size*retion);
                
                NSImage *image = [largeImage reSize:imageSize];
                
                NSString *imageName;
                if(retion==1){
                    imageName = [NSString stringWithFormat:@"icon_%@_%ld.png",imageFlag,size];
                }
                else{
                    imageName = [NSString stringWithFormat:@"icon_%@_%ld@%dx.png",imageFlag,size,retion];
                }
                
                NSString *imagePath = [imageFolerPath stringByAppendingPathComponent:imageName];
                
                [image saveAtPath:imagePath];
                
            }
            
        }
        
    }
    
}


- (void)makeJSONFileWithType:(AppImageType)type
{
    
    NSMutableDictionary *jsonMap = [NSMutableDictionary dictionary];
    
    NSArray *configs = [self configItemWithType:type];
   
    NSMutableArray *images = [NSMutableArray array];
    
    for(NSDictionary *config in configs){
        
        NSDictionary *imageSizeConfig = config[@"imageSizeConfig"];
        
        NSString *imageFlag =  config[@"imageFlag"];;
        
        NSArray *keys = [imageSizeConfig allKeys];
        
        for(NSString *key in keys){
            
            NSArray *scales = imageSizeConfig[key];
            
            NSInteger size = [key integerValue];
            
            for(NSNumber *scale in scales)
            {
                int retion = [scale intValue];
                
                NSString *imageName;
                if(retion==1){
                    imageName = [NSString stringWithFormat:@"icon_%@_%ld.png",imageFlag,size];
                }
                else{
                    imageName = [NSString stringWithFormat:@"icon_%@_%ld@%dx.png",imageFlag,size,retion];
                }
                
                
                NSMutableDictionary *imageInfo = [NSMutableDictionary dictionary];
                
                imageInfo[@"size"] = [NSString stringWithFormat:@"%ldx%ld",size,size];
                
                imageInfo[@"idiom"] = imageFlag;
                
                imageInfo[@"filename"] = imageName;
                
                imageInfo[@"scale"] = [NSString stringWithFormat:@"%dx",retion];
                
                
                [images addObject:imageInfo];
            }
            
        }

    }
    
    
    jsonMap[@"images"] =images;
    jsonMap[@"info"] =@{
                        @"version":@1,
                         @"author":@"xcode",
                        
                        };
    
    
    NSString *imageFolerPath  = [self.exportPath stringByAppendingPathComponent:kAppIconFolderName];
  
    
    NSString *contents = [jsonMap JSONString];
    
    NSString *filePath = [imageFolerPath stringByAppendingPathComponent:kAppIconContensFileName];
    
    BOOL isOK = [self createFileIfNeeded:filePath];
    
    if(!isOK){
        return;
    }
    
    NSError *error;
    
    NSURL *url = [NSURL fileURLWithPath:filePath];
    //保存文件内容
    [contents writeToURL:url atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    if(error){
        NSLog(@"save file error %@",error);
    }
    
}

//对各个平台文件配置信息重新封装到数组中,主要是为了对iPhone,iPad同时支持的情况下处理方便
- (NSArray*)configItemWithType:(AppImageType)type
{
    NSArray *configs;
    
    if(type==AppImageIPhoneType){
        NSDictionary *config=self.imageScaleConfig[kIPhone];
        NSString *imageFlag = @"iphone";
        
        configs = @[
                    @{
                        @"imageSizeConfig":config,
                        @"imageFlag":imageFlag,
                        
                        }
                    
                    ];
    }
    
    if(type==AppImageIPadType){
        
        NSDictionary *config=self.imageScaleConfig[kIPad];
        NSString * imageFlag = @"ipad";
        
        configs = @[
                    @{
                        @"imageSizeConfig":config,
                        @"imageFlag":imageFlag,
                        
                        }
                    
                    ];
        
    }
    
    if(type==AppImageOSXType){
        
        NSDictionary *config=self.imageScaleConfig[kOSX];
        
        NSString * imageFlag = @"mac";
        
        configs = @[
                    @{
                        @"imageSizeConfig":config,
                        @"imageFlag":imageFlag,
                        
                        }
                    
                    ];
        
    }
    
    if(type==AppImageiPoneIPadType){
        
        NSDictionary *config1=self.imageScaleConfig[kIPhone];
        NSString *imageFlag1 = @"iphone";
        
        NSDictionary *config2=self.imageScaleConfig[kIPad];
        NSString *imageFlag2 = @"ipad";
        
        configs = @[
                    @{
                        @"imageSizeConfig":config1,
                        @"imageFlag":imageFlag1,
                        
                        },
                    
                    @{
                        @"imageSizeConfig":config2,
                        @"imageFlag":imageFlag2,
                        
                        }
                    
                    ];
        
    }
    
    return configs;
}

#pragma mark -   FileOperationHelper

- (BOOL)createPathIfNeded:(NSString*)path{
    
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL success = [fm fileExistsAtPath:path];
    if (!success){
        NSError *error=nil;
        [fm createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if(error){
            NSLog(@"%@", [error description]);
            return NO;
        }
    }
    return YES;
}

- (BOOL)createFileIfNeeded:(NSString*)filePath{
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL success = [fm fileExistsAtPath:filePath];
    if (!success){
        success = [fm createFileAtPath:filePath contents:nil attributes:nil];
    }
    return success;
}

- (NSArray*)readFilesAtPath:(NSString*)path{
    if(!path)
        return  nil;
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isDir, isSucess = [fm fileExistsAtPath:path isDirectory:&isDir];
    if (isSucess && isDir) {
        NSArray *array = [fm contentsOfDirectoryAtPath:path error:NULL];
        return array;
    }
    return  nil;
}

- (void)clearAllFilesAtPath:(NSString*)path
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSError *error = nil;
    if([fm fileExistsAtPath:path]){
        NSArray *files = [self readFilesAtPath:path];
        for(NSString *file in files){
            NSString *filePath =[path stringByAppendingPathComponent:file];
            [fm removeItemAtPath:filePath error:&error];
            if(error){
                NSLog(@"Removing file path =%@ Error=%@",filePath,error);
            }
        }
        
    }
}

- (NSString*) usrDocPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}


#pragma mark - DragImageZoneDelegate

- (void)didFinishDragWithFile:(NSString*)filePath
{
    NSLog(@"filePath %@ ",filePath);
    
    self.largeImagePath = filePath;
    
    [self.dragExportButton setEnabled:YES];
    
    //默认到处路径是当前用户的doc目录
    self.exportPath = [self usrDocPath];
}

#pragma mark - DragExportButtonDelegate
- (void)didFinishDragWithExportPath:(NSString*)filePath
{
    
    NSLog(@"filePath %@ ",filePath);
    /*保存用户拖放的路径
      如果路径最后已经以kAppIconFolderName定义的名字结尾,则需要删除最后的路径。
      因为后面生成图片和json文件的目录是用self.exportPath 和 kAppIconFolderName拼接的.
     */
    if([filePath hasSuffix:kAppIconFolderName])
    {
         self.exportPath = [filePath stringByDeletingLastPathComponent];
    }
    else{
         self.exportPath = filePath;
    }
    
    
   
    
}

@end
