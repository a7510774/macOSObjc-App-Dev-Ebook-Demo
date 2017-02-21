//
//  XXXICloud.h
//  SQL+
//
//  Created by zhang on 1/1/14.
//  Copyright (c) 2014 Helens. All rights reserved.
//

#import <Foundation/Foundation.h>

#define  kXXXICloudAvailableMsg    @"XXXICloudAvailableMsg"

#define  kXXXICloudUnAvailableMsg    @"XXXICloudUnAvailableMsg"

@interface XXXICloud : NSObject
+ (XXXICloud*)sharedInstance;
- (NSURL*)documentsPath;
- (NSURL*)dataURLWithPath:(NSString*)path;
- (void)listFiles;
- (NSArray*)fetchFilesPathWithExt:(NSString*)ext;
- (NSArray*)fetchFileNamesWithExt:(NSString*)ext;
- (BOOL)available;
@end
