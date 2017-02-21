//
//  AppDelegate.m
//  BonjourClient
//
//  Created by zhaojw on 15/9/10.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import "AppDelegate.h"

#include <arpa/inet.h>
#define kDomain @"local."
#define kServiceType @"_ProbeHttpService._tcp."

@interface AppDelegate ()<NSNetServiceBrowserDelegate,NSNetServiceDelegate>
@property (weak) IBOutlet NSWindow *window;
@property(nonatomic,strong)NSNetServiceBrowser *serviceBrowser;
@property(nonatomic,strong)NSMutableArray *netServices;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    _serviceBrowser = [[NSNetServiceBrowser alloc]init];
    _serviceBrowser.delegate = self;
    
    _netServices = [NSMutableArray array];
    [self start];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (void)start{
    [self.serviceBrowser searchForServicesOfType:kServiceType inDomain:kDomain];
}

- (void)stop{
    [self.serviceBrowser stop];
}

#pragma mark--NSNetServiceBrowserDelegate

- (void)netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didFindService:(NSNetService *)service moreComing:(BOOL)moreComing {
    
    //保存发现的服务
    [self.netServices addObject:service];
    //设置服务代理
    service.delegate  = self;
    //开始服务解析
    [service resolveWithTimeout:2];
    
     NSLog(@"didFindService %@",service);
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didRemoveService:(NSNetService *)service moreComing:(BOOL)moreComing{
    
    [self.netServices removeObject:service];
}

#pragma mark--NSNetServiceDelegate
- (void)netServiceDidResolveAddress:(NSNetService *)sender {
    //完成解析,取得服务的host和port
    NSLog(@"netServiceDidResolveAddress hostName %@ domain =%@  port %ld name %@ ",sender.hostName,sender.domain,sender.port,sender.name);
    
    NSArray *addresses  = sender.addresses;
    [sender startMonitoring];
    char addressBuffer[INET6_ADDRSTRLEN];
    
    //服务的IP地址
    for(NSData *data in addresses)
    {
        memset(addressBuffer, 0, INET6_ADDRSTRLEN);
        
        typedef union {
            struct sockaddr sa;
            struct sockaddr_in ipv4;
            struct sockaddr_in6 ipv6;
        } ip_socket_address;
        
        ip_socket_address *socketAddress = (ip_socket_address *)[data bytes];
        
        if (socketAddress && (socketAddress->sa.sa_family == AF_INET || socketAddress->sa.sa_family == AF_INET6))
        {
            const char *addressStr = inet_ntop(
                                               socketAddress->sa.sa_family,
                                               (socketAddress->sa.sa_family == AF_INET ? (void *)&(socketAddress->ipv4.sin_addr) : (void *)&(socketAddress->ipv6.sin6_addr)),
                                               addressBuffer,
                                               sizeof(addressBuffer));
            
            int port = ntohs(socketAddress->sa.sa_family == AF_INET ? socketAddress->ipv4.sin_port : socketAddress->ipv6.sin6_port);
            
            if (addressStr && port)
            {
                NSLog(@"Found service at %s:%d", addressStr, port);
            }
        }
    }
}

/* Sent to the NSNetService instance's delegate when an error in resolving the instance occurs. The error dictionary will contain two key/value pairs representing the error domain and code (see the NSNetServicesError enumeration above for error code constants).
 */
- (void)netService:(NSNetService *)sender didNotResolve:(NSDictionary *)errorDict {
    NSLog(@"didNotResolve error %@",errorDict);
}


- (void)netService:(NSNetService *)sender didUpdateTXTRecordData:(NSData *)data
{
    NSDictionary * infoDict = [NSNetService dictionaryFromTXTRecordData:data];
   
    NSData* v = infoDict[@"user"];
    
    NSString *str =[[NSString alloc]initWithBytes:[v bytes] length:v.length encoding:NSUTF8StringEncoding];
   
    NSLog(@"didUpdateTXTRecordData  %@",infoDict);
}
@end
