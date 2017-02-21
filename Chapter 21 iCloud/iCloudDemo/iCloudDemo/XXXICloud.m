//
//  XXXICloud.m
//  SQL+
//
//  Created by zhang on 1/1/14.
//  Copyright (c) 2014 Helens. All rights reserved.
//

#import "XXXICloud.h"

@interface XXXICloud ()
@property(nonatomic,strong)NSFileManager *fileManager;
@property(nonatomic,strong)NSURL *ubiquityContainer;
@property(nonatomic,strong)id ubiquityToken;
@end

@implementation XXXICloud

+ (XXXICloud*)sharedInstance
{
    static XXXICloud *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

- (id)init{
    self = [super init];
    if(self){
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ubiquityIdentityChanged:)name:NSUbiquityIdentityDidChangeNotification
            object:nil];
        
        [self requestICloudContainer];

        
    }
    return self;
}
- (void)requestICloudContainer
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // remember our ubiquity container NSURL for later use
        _ubiquityContainer = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
        if (_ubiquityContainer) {
            NSLog(@"iCloud access at %@", _ubiquityContainer);
            // TODO: Load document...
            [[NSNotificationCenter defaultCenter]postNotificationName:kXXXICloudAvailableMsg object:nil];
            
            [self listFiles];
            
        } else {
            NSLog(@"No iCloud access");
        }
        // do any more initialization here...
    });
}
- (BOOL)available
{
    return (_ubiquityContainer!=nil);
}
- (NSURL*)documentsPath
{
    if(self.ubiquityContainer){
        NSURL *iCloudDocumentsURL = [self.ubiquityContainer URLByAppendingPathComponent:@"Documents"];
        
        return  iCloudDocumentsURL ;
        
    }
    return nil;
}
- (NSURL*)dataURLWithPath:(NSString*)path
{
    if(self.ubiquityContainer){
        return [[self documentsPath] URLByAppendingPathComponent:path];
    }
    return nil;
}


- (void)uploadFileWithPath:(NSString*)path; {
    
    NSError *error;
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *directoryToCopyFrom = [[searchPaths objectAtIndex:0] stringByAppendingPathComponent:@"CodeARC"];
    //directoryToCopyFrom = [searchPaths objectAtIndex:0];
    NSLog(@"Move notes to iCloud, copy from: %@",directoryToCopyFrom);
    NSString *filename;
    
    NSDirectoryEnumerator *enumeratedDirectory = [self.fileManager enumeratorAtPath:directoryToCopyFrom];
    NSURL *URLToBackup = [NSURL URLWithString:directoryToCopyFrom];
    NSLog(@"Move notes to iCloud, backup url is: %@",URLToBackup);
    
    int i =0 ;
    
    while ((filename = [enumeratedDirectory nextObject])) {
        if ([filename hasSuffix:@".sqlite"]) {
            // NEW
            NSURL *srcURL = [URLToBackup URLByAppendingPathComponent:filename isDirectory:NO];
            
            NSURL *iCloudDocumentsURL = [[self.fileManager URLForUbiquityContainerIdentifier:nil] URLByAppendingPathComponent:@"Documents"]; // Discovering iCloud URL
            NSLog(@"Move notes to iCloud, doc url is: %@",iCloudDocumentsURL);
            NSURL *destURL = [iCloudDocumentsURL URLByAppendingPathComponent:filename isDirectory:NO];
            NSLog(@"Move notes to iCloud, dest url: %@",destURL);
            
            // NEW
            
            //BOOL success = [self.fileManager setUbiquitous:YES itemAtURL:localURL destinationURL:cloudURL error:&error];
            
            if ([self.fileManager setUbiquitous:YES itemAtURL:srcURL destinationURL:destURL error:&error] == FALSE)
                NSLog(@"Notes copied to the cloud: %@", error);
            
            //NSString *path = [[searchPaths objectAtIndex:0] stringByAppendingPathComponent:@"Notes"]; // Does directory already exist?
            //[fileManager createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:&error];
            i++;
            
            if(i>10)
            {
                break;
            }
        }
    } // end WHILE statement
    
    [self performSelector:@selector(listFiles) withObject:self afterDelay:5.0];
}


- (NSArray*)fetchFilesPathWithExt:(NSString*)ext{
    
    NSDirectoryEnumerator *enumeratedDirectory = [self.fileManager enumeratorAtPath:[self documentsPath].path];
    NSString *filename;
    NSMutableArray *files = [NSMutableArray array];
    while ((filename = [enumeratedDirectory nextObject])) {
        if ([filename hasSuffix:ext] ) {
            NSString *destURLString = [[self documentsPath].path stringByAppendingPathComponent:filename];
            NSLog(@"File URL in iCloud: %@", destURLString);
            [files addObject:destURLString];
        }
    }
    return [files copy];
}

- (NSArray*)fetchFileNamesWithExt:(NSString*)ext{
    
    NSDirectoryEnumerator *enumeratedDirectory = [self.fileManager enumeratorAtPath:[self documentsPath].path];
    NSString *filename;
    NSMutableArray *files = [NSMutableArray array];
    while ((filename = [enumeratedDirectory nextObject])) {
        if ([filename hasSuffix:ext] ) {
            NSLog(@"File Name in iCloud: %@", filename);
            [files addObject:filename];
        }
    }
    return [files copy];
}

- (void)listFiles{

    NSDirectoryEnumerator *enumeratedDirectory = [self.fileManager enumeratorAtPath:[self documentsPath].path];
    NSString *filename;
    while ((filename = [enumeratedDirectory nextObject])) {
        NSString *destURLString = [[self documentsPath].path stringByAppendingPathComponent:filename];
        NSLog(@"Files in the cloud: %@", destURLString);
    }
}

- (void)ubiquityIdentityChanged:(NSNotification *)notification
{
    id token = [[NSFileManager defaultManager] ubiquityIdentityToken];
    if (token == nil)
    {
        
        
        [[NSNotificationCenter defaultCenter]postNotificationName:kXXXICloudUnAvailableMsg object:nil];
    }
    else
    {
        if ([self.ubiquityToken isEqual:token])
        {
            NSLog(@"user has stayed logged in with same account");
        }
        else
        {
            // user logged in with a different account
            NSLog(@"user logged in with a new account");
        }
        
        // store off this token to compare later
        self.ubiquityToken = token;
        
        [self requestICloudContainer];
        
    }
}


#pragma properties init

- (NSFileManager*)fileManager{
    if(!_fileManager){
        _fileManager = [NSFileManager defaultManager];
    }
    return _fileManager;
}


- (id)ubiquityToken{
    if(!_ubiquityToken){
        _ubiquityToken = [self.fileManager ubiquityIdentityToken];
    }
    return _ubiquityToken;
}

@end
