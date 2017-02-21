//
//  AppDelegate.m
//  iCloudDemo
//
//  Created by zhaojw on 15/11/16.
//  Copyright © 2015年 zhaojw. All rights reserved.
//

#import "AppDelegate.h"
#import <CloudKit/CloudKit.h>

#define kKVkey      @"key1"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;

@property(nonatomic,strong)NSFileManager *fileManager;
@property(nonatomic,strong)NSURL *ubiquityContainer;
@property(nonatomic,strong)id ubiquityToken;
@property(nonatomic,strong)NSUbiquitousKeyValueStore *keyValueStore;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ubiquityIdentityChanged:)name:NSUbiquityIdentityDidChangeNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter]
     addObserver: self
     selector: @selector (storeDidChange:)
     name: NSUbiquitousKeyValueStoreDidChangeExternallyNotification
     object: [NSUbiquitousKeyValueStore defaultStore]];
    
    [self requestICloudContainer];
    
   // CKContainer *myContainer = [CKContainer defaultContainer];
    
    NSFileManager* fileManager = [NSFileManager defaultManager];
    
    self.fileManager = fileManager;
    
    id currentiCloudToken = fileManager.ubiquityIdentityToken;
    
    if(currentiCloudToken){
        
        self.keyValueStore = [NSUbiquitousKeyValueStore defaultStore];
        
        NSString *value = [self.keyValueStore objectForKey:kKVkey];
        
        if(value){
            NSLog(@"iCloud access key =%@   value =%@",kKVkey,value);
        }
        else{
            [self.keyValueStore setObject:@"value" forKey:kKVkey];
        }
    }
  
    [[NSApplication sharedApplication] registerForRemoteNotificationTypes:(NSRemoteNotificationTypeBadge | NSRemoteNotificationTypeSound | NSRemoteNotificationTypeAlert)];
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (void)requestICloudContainer {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // remember our ubiquity container NSURL for later use
        _ubiquityContainer = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
        if (_ubiquityContainer) {
            
            NSLog(@"iCloud access at %@", _ubiquityContainer);
            
            [self.keyValueStore synchronize];
            
            NSString *value = [self.keyValueStore objectForKey:kKVkey];
            
            if(value){
                 NSLog(@"iCloud access key =%@   value =%@",kKVkey,value);
            }
            else{
                [self.keyValueStore setObject:@"value" forKey:kKVkey];
            }
            
        } else {
            NSLog(@"No iCloud access");
        }
        // do any more initialization here...
    });
}

- (void)storeDidChange:(NSNotification *)notification {
    
    
}

- (IBAction)saveFileAction:(id)sender {
    [self savaFile];
}

- (void)savaFile {
    
    NSURL *iCloudDocumentsURL = [[self.fileManager URLForUbiquityContainerIdentifier:nil] URLByAppendingPathComponent:@"Documents"];
    
    if ([self.fileManager fileExistsAtPath:[iCloudDocumentsURL path]] == NO)
    {
        NSLog(@"iCloud Documents directory does not exist");
        [self.fileManager createDirectoryAtURL:iCloudDocumentsURL withIntermediateDirectories:YES attributes:nil error:nil];
    } else {
        NSLog(@"iCloud Documents directory exists");
    }
    
    NSError *error;
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *usrDocdirectory = [[searchPaths objectAtIndex:0] stringByAppendingPathComponent:@"SwiftDemo"];
    NSURL *urlOfUserDoc = [NSURL fileURLWithPath:usrDocdirectory];
    
    NSString *filename = @"iCloudDriveFolder.png";
    
    NSURL *srcURL = [urlOfUserDoc URLByAppendingPathComponent:filename isDirectory:NO];
    NSURL *destURL = [iCloudDocumentsURL URLByAppendingPathComponent:filename isDirectory:NO];
    
    
        if (![self.fileManager setUbiquitous:YES itemAtURL:srcURL destinationURL:destURL error:&error]){
            //上传失败
            NSLog(@"error %@",error);
        }
        else{
            
            NSLog(@"thread %d", [NSThread currentThread].isMainThread );
        }
    
   
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void)
                   {
                       NSFileCoordinator* fileCoordinator = [[NSFileCoordinator alloc] initWithFilePresenter:nil];
                       [fileCoordinator coordinateReadingItemAtURL:srcURL
                                                           options:NSFileCoordinatorReadingWithoutChanges
                                                             error:nil
                                                        byAccessor:^(NSURL *newURL)
                        {
                          // NSFileManager * fileManager = [[NSFileManager alloc] init];
                            NSError * error;
                           
                            
                            
                            BOOL success = [self.fileManager setUbiquitous:YES itemAtURL:srcURL destinationURL:destURL error:&error];

                            
                            if (success) {
                                NSLog(@"Copied %@ to %@", srcURL, destURL);
                            }
                            else {
                                NSLog(@"Failed to copy %@ to %@: %@", srcURL, destURL, error.localizedDescription);
                            }
                        }];
                   });
    
    
//    if (![self.fileManager setUbiquitous:YES itemAtURL:srcURL destinationURL:destURL error:&error]){
//        //上传失败
//        NSLog(@"error %@",error);
//    }
    
}


- (void)ubiquityIdentityChanged:(NSNotification *)notification {
    
    id token = [[NSFileManager defaultManager] ubiquityIdentityToken];
    
    if (token == nil)
    {
        NSAlert *alert = [[NSAlert alloc] init];
        [alert addButtonWithTitle:@"Ok"];
        [alert setMessageText:@"iCloud Logout"];
        [alert setInformativeText:@"User logout iCloud account"];
        [alert setAlertStyle:NSInformationalAlertStyle];
        
        [alert beginSheetModalForWindow:self.window
                      completionHandler:^(NSModalResponse returnCode){
                          
                          //用户点击告警上面的按钮后的回调
                          
                      }
         ];

    }
    else
    {
        if ([self.ubiquityToken isEqual:token]){
    
            NSLog(@"user has stayed logged in with same account");
        }
        else
        {
            NSLog(@"user logged in with a new account");
        }
 
        self.ubiquityToken = token;
        
        //[self requestICloudContainer];
        
    }
}



- (void)application:(NSApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken  {
    
    const void *devTokenBytes = [deviceToken bytes];
    
    NSLog(@"deviceToken %@",deviceToken);
    
    NSString *deviceTokenStr =  [[NSString alloc] initWithData:deviceToken encoding:NSUTF8StringEncoding];
    
    NSLog(@"deviceTokenStr %@",deviceTokenStr);
}

- (void)application:(NSApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error  {
    
    NSLog(@"didFailToRegisterForRemoteNotificationsWithError error %@",error);
    
}


            



@end
