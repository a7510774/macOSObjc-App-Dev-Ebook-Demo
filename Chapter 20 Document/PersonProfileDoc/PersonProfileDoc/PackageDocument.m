//
//  PackageDocument.m
//  PersonProfileDoc
//
//  Created by zhaojw on 12/17/15.
//  Copyright © 2015 zhaojw. All rights reserved.
//

#import "PackageDocument.h"

#import "PersonProfile.h"
#import "PersonProfileWindowController.h"
#import "JSONObjKit.h"

NSString *kImageFileNameKey = @"Image.png";
NSString *kTextFileNameKey = @"Text.txt";

@interface PackageDocument ()
@property(nonatomic,strong)PersonProfile *profile;
@property (strong) NSFileWrapper *documentFileWrapper;
@end

@implementation PackageDocument

- (instancetype)init {
    self = [super init];
    if (self) {
        PersonProfile *p = [[PersonProfile alloc]init];
        self.profile = p;
    }
    return self;
}

- (void)makeWindowControllers {
    PersonProfileWindowController *vc =  [[PersonProfileWindowController alloc]init];
    [self addWindowController:vc];
}


#pragma mark-- FileWrapper

- (BOOL)readFromFileWrapper:(NSFileWrapper *)fileWrapper
                     ofType:(NSString *)typeName
                      error:(NSError **)outError {
    NSDictionary *fileWrappers = [fileWrapper fileWrappers];
    NSFileWrapper *imageFileWrapper = [fileWrappers objectForKey:kImageFileNameKey];
    if (imageFileWrapper != nil) {
        NSData *imageData = [imageFileWrapper regularFileContents];
        NSImage *image = [[NSImage alloc] initWithData:imageData];
        [self.profile setImage:image];
    }
    NSFileWrapper *textFileWrapper = [fileWrappers objectForKey:kTextFileNameKey];
    if (textFileWrapper != nil) {
        NSData *textData = [textFileWrapper regularFileContents];
        
        NSString *textString = [[NSString alloc] initWithData:textData encoding:NSUTF8StringEncoding];
        NSDictionary *profileTextDic = [textString xx_objectFromJSONString];
        [self.profile setValuesForKeysWithDictionary:profileTextDic];
    }
    self.documentFileWrapper = fileWrapper;
    return YES;
    
}

- (NSFileWrapper *)fileWrapperOfType:(NSString *)typeName
                               error:(NSError **)outError {
    if (!self.documentFileWrapper) {
        NSFileWrapper * documentFileWrapper = [[NSFileWrapper alloc]initDirectoryWithFileWrappers:@{}];
        self.documentFileWrapper = documentFileWrapper;
    }
    
    NSDictionary *fileWrappers = self.documentFileWrapper.fileWrappers;
    NSImage *image = self.profile.image;
    if (![fileWrappers objectForKey:kImageFileNameKey] &&  image) {
        NSArray *imageRepresentations = [image representations];
        NSData *imageData = [NSBitmapImageRep
                             representationOfImageRepsInArray:imageRepresentations
                             usingType:NSPNGFileType
                             properties:@{}];
        if (!imageData) {
            NSBitmapImageRep *imageRep = nil;
            @autoreleasepool {
                imageData = [image TIFFRepresentation];
                imageRep = [[NSBitmapImageRep alloc] initWithData:imageData];
            }
            imageData = [imageRep representationUsingType:NSPNGFileType
                                               properties:@{}];
        }
        NSFileWrapper *imageFileWrapper = [[NSFileWrapper alloc]
                                           initRegularFileWithContents:imageData];
        [imageFileWrapper setPreferredFilename:kImageFileNameKey];
        [self.documentFileWrapper addFileWrapper:imageFileWrapper];
    }
    
    
    if (![fileWrappers objectForKey:kTextFileNameKey]) {
        
        NSMutableDictionary *profileTextDic = [NSMutableDictionary dictionary];
        if(self.profile.name){
            [profileTextDic setObject:self.profile.name forKey:@"name"];
        }
        if(self.profile.age){
            [profileTextDic setObject:@(self.profile.age) forKey:@"age"];
        }
        if(self.profile.address){
            [profileTextDic setObject:self.profile.address forKey:@"address"];
        }
        if(self.profile.mobile){
            [profileTextDic setObject:self.profile.mobile  forKey:@"mobile"];
        }
        
        NSString *str = [profileTextDic xx_JSONString];
        NSData *textData = [str
                            dataUsingEncoding:NSUTF8StringEncoding];
        NSFileWrapper *textFileWrapper = [[NSFileWrapper alloc]
                                          initRegularFileWithContents:textData];
        
        [textFileWrapper setPreferredFilename:kTextFileNameKey];
        [self.documentFileWrapper addFileWrapper:textFileWrapper];
    }
    return self.documentFileWrapper;
}

@end
