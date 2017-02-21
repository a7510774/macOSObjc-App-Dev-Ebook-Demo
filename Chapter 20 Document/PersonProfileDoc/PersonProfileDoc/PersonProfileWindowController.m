//
//  PersonProfileWindowController.m
//  PersonProfileDoc
//
//  Created by zhaojw on 12/15/15.
//  Copyright © 2015 zhaojw. All rights reserved.
//

#import "PersonProfileWindowController.h"
#import "AvatorImageView.h"
@interface PersonProfileWindowController ()<AvatorUploadDelegate>
@property (weak) IBOutlet AvatorImageView *avatorImageView;
@end

@implementation PersonProfileWindowController
- (void)windowDidLoad {
    
    [super windowDidLoad];
    [self.window center];
    self.avatorImageView.delegate = self;
}

- (NSString *)windowNibName {
    return @"PersonProfileWindowController";
}

#pragma mark- AvatorUploadDelegate

- (void)didRequestUploadAvator:(AvatorImageView*)imageView {
    [self openSelectAvatorFilePanel];
}

- (void)openSelectAvatorFilePanel {

    NSOpenPanel *openDlg = [NSOpenPanel openPanel];
    openDlg.canChooseFiles = YES ;
    openDlg.canChooseDirectories = NO;
    openDlg.allowsMultipleSelection = NO;
    openDlg.allowedFileTypes = @[@"png",@"jpeg"];
    
    [openDlg beginWithCompletionHandler: ^(NSInteger result){
        
        if(result==NSFileHandlingPanelOKButton){
            
            NSArray *fileURLs = [openDlg URLs];
            for(NSURL *url in fileURLs) {
                
                self.avatorImageView.image = [[NSImage alloc]initWithContentsOfURL:url];
                
                NSDictionary *bindInfo = [self.avatorImageView infoForBinding:@"value"];
                NSObjectController *observedObject = bindInfo[NSObservedObjectKey];
                
                id profile = observedObject.content;
                [profile setValue:self.avatorImageView.image forKey:@"image"];
                
              
            }
        }
        
    }];
}


@end
