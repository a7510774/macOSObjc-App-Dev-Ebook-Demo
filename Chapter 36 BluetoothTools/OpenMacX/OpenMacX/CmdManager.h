//
//  CmdManager.h
//  OpenMacX
//
//  Created by zhaojw on 12/18/15.
//  Copyright © 2015 zhaojw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CmdManager : NSObject
+ (CmdManager *)sharedInstance;
- (NSString*)passwordCmdScript;
- (NSString*)sleepCmdScript;
- (NSDictionary*)baseStatusCmd;
@end
