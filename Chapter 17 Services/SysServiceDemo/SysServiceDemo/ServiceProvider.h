//
//  ServiceProvider.h
//  SysServiceDemo
//
//  Created by zhaojw on 11/19/15.
//  Copyright © 2015 zhaojw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
@interface ServiceProvider : NSObject
- (void)upperCaseText:(NSPasteboard *)pboard
          userData:(NSString *)userData error:(NSString **)error;
@end
