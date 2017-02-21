//
//  CmdManager.m
//  OpenMacX
//
//  Created by zhaojw on 12/18/15.
//  Copyright © 2015 zhaojw. All rights reserved.
//

#import "CmdManager.h"

@interface CmdManager ()
@property(nonatomic,copy)NSString *openCmd;
@property(nonatomic,copy)NSString *sleepCmd;
@end

@implementation CmdManager
+ (CmdManager *)sharedInstance {
    static CmdManager *instace = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        instace = [[self alloc] init];
        
    });
    return instace;
}

- (NSString*)passwordCmdScript {
    
    if(!_openCmd){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"PasswordCmd"ofType:@"strings"];
       _openCmd = [[NSString alloc] initWithContentsOfFile:path usedEncoding:NULL error:NULL];
    }
    return _openCmd;
}

- (NSString*)sleepCmdScript {
    
    if(!_sleepCmd){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"SleepCmd"ofType:@"strings"];
        _sleepCmd = [[NSString alloc] initWithContentsOfFile:path usedEncoding:NULL error:NULL];
    }
    return _sleepCmd;
  
}
@end
