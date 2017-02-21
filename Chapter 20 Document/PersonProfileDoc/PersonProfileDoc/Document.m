//
//  Document.m
//  PersonProfileDoc
//
//  Created by zhaojw on 12/15/15.
//  Copyright © 2015 zhaojw. All rights reserved.
//

#import "Document.h"
#import "PersonProfile.h"
#import "PersonProfileWindowController.h"
#import "PackageDocument.h"

@interface Document ()
@property(nonatomic,strong)PersonProfile *profile;
@end

@implementation Document

- (instancetype)init {
    self = [super init];
    if (self) {
        
         PersonProfile *p = [[PersonProfile alloc]init];
        
         self.profile = p;
    }
    return self;
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController {
    [super windowControllerDidLoadNib:aController];
}

+ (BOOL)autosavesInPlace {
    return YES;
}

- (void)makeWindowControllers {
    
    PersonProfileWindowController *vc =  [[PersonProfileWindowController alloc]init];
    
    [self addWindowController:vc];
}


-(BOOL)writeToURL:(NSURL *)url ofType:(NSString *)typeName error:(NSError **)outError{
    if([typeName isEqualToString:@"macdev.io.pdata"]){
        return [super writeToURL:url ofType:typeName error:outError];
    }
    
    if([typeName isEqualToString:@"macdev.io.pxdata"]){
        PackageDocument *pdoc = [[PackageDocument alloc]init];
        [pdoc setValue:self.profile forKey:@"profile"];
        return  [pdoc writeToURL:url ofType:typeName error:outError];
    }
    return YES;
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError {

    return [self.profile docData];
 
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError {
    
    if(data) {
        self.profile = [PersonProfile profileFromData:data];
        if(self.profile){
            return YES;
        }
    }
    
    return NO;
}




@end
