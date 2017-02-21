//
//  AppDelegate.m
//  SandboxFile
//
//  Created by zhaojw on 15/9/8.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import "AppDelegate.h"


#define  kFilePath @"kFilePath"


@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;

@property (weak) IBOutlet NSTextField *filePathField;

@property (unsafe_unretained) IBOutlet NSTextView *textView;


@end


typedef void (^SBFileAccessBlock)();

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *path = [defaults objectForKey:kFilePath];     
    //如果文件路径不存在,不做任何处理
    if(!path){
        return ;
    }
    
    
    __block NSError *error;
    
    //文件路径显示
    
    self.filePathField.stringValue = path;
    
    
    NSURL *url = [NSURL fileURLWithPath:path];
    
    
    [self accessFileURL:url withBlock:^(){
        
        //读取文件内容
        
        NSString *string = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
        
        if(!error){
            self.textView.string = string;
        }
        
    }];
    
   
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (IBAction)openFileAction:(id)sender {
    
    NSOpenPanel *openDlg = [NSOpenPanel openPanel];
    
    openDlg.canChooseFiles = YES ;
    
    openDlg.canChooseDirectories = YES;
    
    openDlg.allowsMultipleSelection = YES;
    
    openDlg.allowedFileTypes = @[@"txt"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [openDlg beginWithCompletionHandler: ^(NSInteger result){
        
        if(result==NSFileHandlingPanelOKButton){
            
            NSArray *fileURLs = [openDlg URLs];
            
            for(NSURL *url in fileURLs) {
                
                NSError *error;
                
                //保存文件路径
                [defaults setObject:url.path forKey:kFilePath];
                
                [defaults synchronize];
                
                
                self.filePathField.stringValue = url.path;
                
                
                [self persistPermissionURL:url];
                
                //读取文件内容
                NSString *string = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
                
                if(!error){
                    self.textView.string = string;
                }
                
            }
        }
        
    }];

}


- (IBAction)saveFileAction:(id)sender {
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //获取文件路径
    NSString *path = [defaults objectForKey:kFilePath];  ;
    
    if(!path){
        return ;
    }
    
    NSString *text = self.textView.string;
    
    NSError *error;

    NSURL *url = [NSURL fileURLWithPath:path];
    //保存文件内容
    [text writeToURL:url atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    if(error){
        NSLog(@"save file error %@",error);
    }
    
    
}



- (void)persistPermissionPath:(NSString *)path {
    [self persistPermissionURL:[NSURL fileURLWithPath:path]];
}

- (void)persistPermissionURL:(NSURL *)url {
    // store the sandbox permissions
    //NSData *bookmarkData = [url bookmarkDataWithOptions:NSURLBookmarkCreationWithSecurityScope includingResourceValuesForKeys:nil relativeToURL:nil error:NULL];
    
    NSData *bookmarkData = [url bookmarkDataWithOptions:NSURLBookmarkCreationWithSecurityScope includingResourceValuesForKeys:nil relativeToURL:nil error:NULL];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    NSLog(@"persistPermissionURL bookmarkData %@ ",bookmarkData);
    
    if (bookmarkData) {
        
        [defaults setObject:bookmarkData forKey:url.path];
        
        [defaults synchronize];
    }
}



- (BOOL)accessFileURL:(NSURL *)fileUrl  withBlock:(SBFileAccessBlock)block {
    
    NSURL *allowedUrl = nil;
    
    // standardize the file url and remove any symlinks so that the url we lookup in bookmark data would match a url given by the askPermissionForUrl method
   // fileUrl = [[fileUrl URLByStandardizingPath] URLByResolvingSymlinksInPath];
    
    // lookup bookmark data for this url, this will automatically load bookmark data for a parent path if we have it
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *bookmarkData = [defaults objectForKey:fileUrl.path];
    
    
    NSLog(@"accessFileURL bookmarkData %@ ",bookmarkData);
    
    if (bookmarkData) {
        // resolve the bookmark data into an NSURL object that will allow us to use the file
        BOOL bookmarkDataIsStale;
        allowedUrl = [NSURL URLByResolvingBookmarkData:bookmarkData options:NSURLBookmarkResolutionWithSecurityScope|NSURLBookmarkResolutionWithoutUI relativeToURL:nil bookmarkDataIsStale:&bookmarkDataIsStale error:NULL];
        // if the bookmark data is stale, we'll create new bookmark data further down
        if (bookmarkDataIsStale) {
            bookmarkData = nil;
        }
    }
    
   
    
    // if we have no bookmark data, we need to create it, this may be because our bookmark data was stale, or this is the first time being given permission
    if ( !bookmarkData) {
        [self persistPermissionURL:allowedUrl];
    }
    
    // execute the /block with the file access permissions
    @try {
        [allowedUrl startAccessingSecurityScopedResource];
        block();
    } @finally {
        [allowedUrl stopAccessingSecurityScopedResource];
    }
    
    return YES;
}

@end
