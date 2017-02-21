//
//  Helper.m
//  Helper
//
//  Created by zhaojw on 11/20/15.
//  Copyright © 2015 zhaojw. All rights reserved.
//

#import "Helper.h"

@implementation Helper

// This implements the example protocol. Replace the body of this class with the implementation of this service's protocol.
- (void)upperCaseString:(NSString *)aString withReply:(void (^)(NSString *))reply {
    NSString *response = [aString uppercaseString];
    
    [[self.xpcConnection remoteObjectProxy] logString:aString];
    
    reply(response);
}

@end
