//
//  Helper.h
//  Helper
//
//  Created by zhaojw on 11/20/15.
//  Copyright © 2015 zhaojw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HelperProtocol.h"

// This object implements the protocol which we have defined. It provides the actual behavior for the service. It is 'exported' by the service to make it available to the process hosting the service over an NSXPCConnection.
@interface Helper : NSObject <HelperProtocol>

@property (weak) NSXPCConnection *xpcConnection;

@end
