//
//  AppDelegate.m
//  OpenSavePanel
//
//  Created by zhaojw on 15/8/27.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (unsafe_unretained) IBOutlet NSTextView *textView;
@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (IBAction)openFilePanel:(id)sender
{
    NSOpenPanel *openDlg = [NSOpenPanel openPanel];
    
    openDlg.canChooseFiles = YES ;
    
    openDlg.canChooseDirectories = YES;
    
    openDlg.allowsMultipleSelection = YES;
    
    openDlg.allowedFileTypes = @[@"txt"];
    
    [openDlg beginWithCompletionHandler: ^(NSInteger result){
        
        if(result==NSFileHandlingPanelOKButton){
            
            NSArray *fileURLs = [openDlg URLs];
            
            for(NSURL *url in fileURLs) {
                
                NSError *error;
                
                NSString *string = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
                
                if(!error){
                    self.textView.string = string;
                }
                
            }
        }
        
    }];
}


- (IBAction)saveFilePanel:(id)sender
{
   
    NSSavePanel *saveDlg = [[NSSavePanel alloc]init];
   
    saveDlg.title = @"Save File";
   
    saveDlg.message = @"Save My File";
    
    saveDlg.allowedFileTypes = @[@"txt"];
   
    saveDlg.nameFieldStringValue = @"my";
    
    [saveDlg beginWithCompletionHandler: ^(NSInteger result){
       
        if(result==NSFileHandlingPanelOKButton){
            
            NSURL  *url =[saveDlg URL];
            
            NSLog(@"filePath url%@",url);
            
            NSString *text = self.textView.string;
            
            NSError *error;
            
            [text writeToURL:url atomically:YES encoding:NSUTF8StringEncoding error:&error];
            
            if(error){
                NSLog(@"save file error %@",error);
            }
        }
        
    }];
    
}

@end
