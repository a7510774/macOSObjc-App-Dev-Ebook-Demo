//
//  AppDelegate.m
//  NSURLNetworkFileHandleDemo
//
//  Created by zhaojw on 2/21/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//

#import "AppDelegate.h"
#import "Aspects.h"
@interface AppDelegate ()<NSURLConnectionDataDelegate>

@property (weak) IBOutlet NSWindow *window;

@property(nonatomic,strong)  NSFileHandle *fileHandle;//文件句柄
@property(nonatomic,strong)  NSString *filePath;//文件路径
@property (nonatomic,assign) NSInteger totalLength;//文件的总大小
@property (nonatomic,assign) NSInteger currentLength;//已接收文件数据的大小

@end

@implementation AppDelegate

-(void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    
    [NSFileHandle  aspect_hookSelector:@selector(seekToEndOfFile) withOptions:0 usingBlock:^(id info) {
        
        
        
        
        NSLog(@"Button was pressed by: %@", info);
        
    } error:NULL];
    
    
    [[NSFileHandle  class] aspect_hookSelector:@selector(fileHandleForWritingAtPath:) withOptions:0 usingBlock:^(id info, NSString *path) {
        
        
        
        
        NSLog(@"Button was pressed by: %@", path);
        
    } error:NULL];
    
    
    [NSFileHandle   aspect_hookSelector:@selector(writeData:) withOptions:0 usingBlock:^(id info, NSData *sender) {
        
        NSLog(@"Button was pressed by: %@", sender);
        
    } error:NULL];
    
    [self startDownload];
}

-(void)startDownload {
    NSURL *url = [NSURL URLWithString:@"http://devstreaming.apple.com/videos/wwdc/2015/1026npwuy2crj2xyuq11/102/102_platforms_state_of_the_union.pdf?dl=1"];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
//    url = [NSURL URLWithString:@"http://devstreaming.apple.com/videos/wwdc/2015/802mpzd3nzovlygpbg/802/802_//designing_for_apple_watch.pdf?dl=1"];
//    
    
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request  delegate:self];
}

#pragma mark-- NSURLConnectionDelegate
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    if(!self.fileHandle){
        self.fileHandle = [NSFileHandle fileHandleForWritingAtPath:self.filePath];
    }
    //1.定位到文件末尾
    [self.fileHandle seekToEndOfFile];
    //2.往文件中写入数据
    [self.fileHandle writeData:data];
    self.currentLength += data.length;
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"download File Finish ！");
    [self.fileHandle closeFile];
    self.fileHandle = nil;
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"connection recieve response  %@",response);
    self.totalLength = response.expectedContentLength;
    NSString *fileName = [[ response.URL absoluteString]lastPathComponent];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    self.filePath = [[NSHomeDirectory()
                              stringByAppendingPathComponent:@"Downloads"] stringByAppendingPathComponent:fileName];
    //创建文件
    [fileManager createFileAtPath: self.filePath contents:nil attributes:nil];
    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    if(error){
        NSLog(@"connection error %@",error);
    }
}




@end
