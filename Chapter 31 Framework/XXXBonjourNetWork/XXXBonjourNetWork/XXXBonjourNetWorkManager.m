//
//  XXXBonjourNetWorkManager.m
//  XXXAirInterface
//
//  by zhaojw on 1/4/14.
//  Copyright (c) 2014 http://www.cocoahunt.com. All rights reserved.
//
#import <Cocoa/Cocoa.h>
#import "XXXBonjourNetWorkManager.h"
#import "Constant.h"
#import "NSDictionary+safeSetValueForKey.h"
#import "JSONObjKit.h"
@interface XXXBonjourNetWorkManager ()
            <NSNetServiceBrowserDelegate,
            NSNetServiceDelegate>
@property(nonatomic,strong)NSNetServiceBrowser *netBrowser;
@property(nonatomic,strong)NSMutableArray *netServices;
@property(nonatomic,strong)NSString *bonjourHttpTcpType;
@property(nonatomic,strong)NSString *domain;
@end

@implementation XXXBonjourNetWorkManager

+ (XXXBonjourNetWorkManager*)sharedInstance {
    static XXXBonjourNetWorkManager* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}


+ (void)load {
    NSLog(@"Injecting Bonjour NetWork loader");
    @autoreleasepool {
        //[[ProbeServerManager sharedInstance] start ];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationDidFinishLaunching:) name:NSApplicationDidFinishLaunchingNotification object:nil];
    }
}
+ (void)applicationDidFinishLaunching:(NSNotification *)note {
    [[XXXBonjourNetWorkManager sharedInstance] start ];
}

- (id)initWithType:(NSString*)type domain:(NSString *)domain {

    self = [super init];
    if (self) {
        // Initialization code here.
        _netServices = [NSMutableArray arrayWithCapacity:4];
        _netBrowser = [[NSNetServiceBrowser alloc]init];
        _netBrowser.delegate = self;
        _domain = domain;
        _bonjourHttpTcpType = type;
    }
    return self;
}
- (id)init {

    return [self initWithType:kBonjourProbeHttpTcpType domain:kLocalDomain];
   
}

- (void)start {
    [_netBrowser searchForServicesOfType:self.bonjourHttpTcpType inDomain:self.domain];
}
- (void)stop {
    [_netBrowser stop];
}
- (void)netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didFindService:(NSNetService *)service moreComing:(BOOL)moreComing {
    NSLog(@"BonjourNetWorkManager Service didFind service = %@",
         service);
    [self.netServices addObject:service];
    [service setDelegate:self];
    [service resolveWithTimeout:1];
    
    
    NSMutableDictionary *hostInfo =  [self hostDictionaryFormat:service.name];

    if(service.port>0){
        [hostInfo xx_setSafeValue:@(service.port) forKey:@"port"];
    }
    [hostInfo xx_setSafeValue:service.hostName forKey:@"hostName"];
    [hostInfo xx_setSafeValue:@(NO) forKey:@"available"];
    [hostInfo xx_setSafeValue:@(XXXBonjourNetWorkFindService) forKey:@"broadcastType"];
    [self broadcastService:service hostInfo:hostInfo];

}
- (void)netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didRemoveService:(NSNetService *)service moreComing:(BOOL)moreComing {
    NSLog(@"BonjourNetWorkManager Service didRemove service = %@",
         service);

    NSMutableDictionary *hostInfo =  [self hostDictionaryFormat:service.name];
    if(service.port>0){
        [hostInfo xx_setSafeValue:@(service.port) forKey:@"port"];
    }
    [hostInfo xx_setSafeValue:service.hostName forKey:@"hostName"];
    [hostInfo xx_setSafeValue:@(NO) forKey:@"available"];
    [hostInfo xx_setSafeValue:@(XXXBonjourNetWorkRemoveService) forKey:@"broadcastType"];
    [self broadcastService:service hostInfo:hostInfo];
    [self.netServices removeObject:service];
}
-(void)netServiceDidResolveAddress:(NSNetService *)service {
	NSLog(@"BonjourNetWorkManager Service resolved. service=%@",
         service);
    
    NSMutableDictionary *hostInfo =  [self hostDictionaryFormat:service.name];
    if(service.port>0){
        [hostInfo xx_setSafeValue:@(service.port) forKey:@"port"];
    }
    [hostInfo xx_setSafeValue:service.hostName forKey:@"hostName"];
    [hostInfo xx_setSafeValue:@(YES) forKey:@"available"];
    [hostInfo xx_setSafeValue:@(XXXBonjourNetWorkResolveAddress) forKey:@"broadcastType"];
    [self broadcastService:service hostInfo:hostInfo];
    [self.netServices addObject:service];
    
}
- (void)netService:(NSNetService *)service didNotResolve:(NSDictionary *)errorDict {

    NSLog(@"BonjourNetWorkManager Service didNotResolve service = %@",
          service);
    
    NSMutableDictionary *hostInfo =  [self hostDictionaryFormat:service.name];
    if(service.port>0){
        [hostInfo xx_setSafeValue:@(service.port) forKey:@"port"];
    }
    [hostInfo xx_setSafeValue:service.hostName forKey:@"hostName"];
    [hostInfo xx_setSafeValue:@(NO) forKey:@"available"];
    [hostInfo xx_setSafeValue:@(XXXBonjourNetWorkNotResolveAddress) forKey:@"broadcastType"];
    
    [self broadcastService:service hostInfo:hostInfo];
    
    [self.netServices removeObject:service];
}

/* Sent to the NSNetService instance's delegate when the instance's previously running publication or resolution request has stopped.
 */
- (void)netServiceDidStop:(NSNetService *)service {

    NSLog(@"BonjourNetWorkManager Service DidStop service=%@",service);
    NSMutableDictionary *hostInfo = [self hostDictionaryFormat:service.name];
    [hostInfo xx_setSafeValue:@(service.port) forKey:@"port"];
    [hostInfo xx_setSafeValue:service.hostName forKey:@"hostName"];
    [hostInfo xx_setSafeValue:@(NO) forKey:@"available"];
    [hostInfo xx_setSafeValue:@(XXXBonjourNetWorkStop) forKey:@"broadcastType"];
    
    [self broadcastService:service hostInfo:hostInfo];
    [self.netServices removeObject:service];
}

- (void)broadcastService:(NSNetService*)aService hostInfo:(NSDictionary*)hostInfo {

    NSNetService *service = aService;
    NSString *UUID = service.name;
    assert(UUID);
    NSLog(@"broadcastService hostInfo =%@",hostInfo);
    [[NSNotificationCenter defaultCenter]postNotificationName:kAirInterfaceBonjourNetWorkChangedMsg object:hostInfo
     
     ];
    
}
- (NSMutableDictionary*)hostDictionaryFormat:(NSString*)hostName {

    NSDictionary *hostMap = [hostName xx_objectFromJSONString];
    
    NSString *ip = hostMap[@"i"];
    NSNumber *port = hostMap[@"p"];
    NSString *UUID = hostMap[@"a"];
    NSNumber *simulator = hostMap[@"s"];
    
    NSMutableDictionary *retMap =  [NSMutableDictionary dictionary];
    
    [retMap xx_setSafeValue:ip forKey:@"ip"];
    if([port integerValue]>0){
        [retMap xx_setSafeValue:port forKey:@"port"];
    }
    [retMap xx_setSafeValue:UUID forKey:@"UUID"];
    [retMap xx_setSafeValue:simulator forKey:@"isSimulator"];
    return retMap;
}
                                                                                   
@end
