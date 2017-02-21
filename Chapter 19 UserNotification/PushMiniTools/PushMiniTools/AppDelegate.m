//
//  AppDelegate.m
//  PushMiniTools
//
//  Created by iDevFans on 2016/11/4.
//  Copyright © 2016年 macdev. All rights reserved.
//

#import "AppDelegate.h"
#import "GCDAsyncSocket.h"

NSInteger port = 2195;

typedef enum {
    APNSSockTagWrite,
    APNSSockTagRead
} APNSSockTag;


@interface AppDelegate () <GCDAsyncSocketDelegate>{
    
}
@property (unsafe_unretained) SecIdentityRef identity;
@property (weak) IBOutlet NSWindow *window;
@property (nonatomic,strong )NSString *host;
@property (nonatomic,strong )NSString *deviceToken;
@property (nonatomic,strong)GCDAsyncSocket *socket;
@property (nonatomic,assign)BOOL isConnected;
@property (nonatomic,assign)int messageID;
@property (unsafe_unretained) IBOutlet NSTextView *pushContentTextView;
@property (weak) IBOutlet NSTextField *tokenTextView;
@property (weak) IBOutlet NSButton * pushButton;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    [self buildCertificate];
}



- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}



- (void)buildCertificate {
    
    SecKeychainRef keychain;
    SecCertificateRef certificate;
    //从导出的证书文件读取数据
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"PushCertificates" ofType:@"cer"];
    NSData *certificateData = [NSData dataWithContentsOfFile:cerPath];
    //创建证书的引用
    certificate = SecCertificateCreateWithData(kCFAllocatorDefault, (__bridge CFDataRef)certificateData);
    if (certificate != NULL){
        //创建包含私钥的身份证书的引用
        OSStatus  status = SecIdentityCreateWithCertificate(keychain, certificate, &_identity);
        NSLog(@"status %d",status);
    }
    
}


- (IBAction)connectAction:(id)sender {
    
    [self connect];
    
}


- (IBAction)pushAction:(id)sender {
    
    self.deviceToken = self.tokenTextView.stringValue;
    if(self.deviceToken.length<=0){
        NSLog(@"DeviceToken is nil");
        return;
    }
    [self push];
}


- (void)push {
    
    if(!self.isConnected){
        NSLog(@"push socket channel not conected!");
        return;
    }
    
    NSData *data = [self package];
    
    [self.socket writeData:data withTimeout:2 tag:APNSSockTagWrite];
    
}


- (NSData*)package {
    NSString *content = self.pushContentTextView.string;
    NSDictionary *jsonObj = @{
                              @"aps": @{
                                      @"alert":content,
                                      @"badge":@(1),
                                      @"sound":@"default"
                                      }
                              };
    
    
    NSData *payloadData = [NSJSONSerialization dataWithJSONObject:jsonObj options:0 error:nil];
    NSLog(@"push payload %@!",jsonObj);
    
    NSMutableData *data = [NSMutableData data];
    // 消息类型
    uint8_t command = 2;
    [data appendBytes:&command length:1];
    
    // frame
    NSMutableData *frame = [NSMutableData data];
    uint8_t itemId = 0;
    uint16_t itemLength = 0;
    
    // itemId = 1   deviceToken
    itemId++;
    [frame appendBytes:&itemId length:1];
    itemLength = htons(32);
    [frame appendBytes:&itemLength length:2];
    // token
    NSMutableData *token = [NSMutableData data];
    unsigned value;
    
    NSScanner *scanner = [NSScanner scannerWithString:self.deviceToken];
    while(![scanner isAtEnd]) {
        [scanner scanHexInt:&value];
        value = htonl(value);
        [token appendBytes:&value length:sizeof(value)];
    }
    [frame appendData:token];
    
    // itemId = 2,  payload(消息内容）
    itemId++;
    [frame appendBytes:&itemId length:1];
    itemLength = htons([payloadData length]);
    [frame appendBytes:&itemLength length:2];
    [frame appendData:payloadData];
    
    // itemId = 3,  identifier（消息编号)
    itemId++;
    [frame appendBytes:&itemId length:1];
    itemLength = htons(4);
    [frame appendBytes:&itemLength length:2];
    
    // 消息编号取值
    uint32_t notificationIdentifier = (uint32_t)self.messageID++;
    [frame appendBytes:&notificationIdentifier length:4];
    
    // itemId = 4, expiration date(超期时间)
    itemId++;
    [frame appendBytes:&itemId length:1];
    // 超期时间长度
    itemLength = htons(4);
    [frame appendBytes:&itemLength length:2];
    // 时间
    uint32_t expirationDate = htonl(0);
    [frame appendBytes:&expirationDate length:4];
    
    // itemId = 5, 优先级
    itemId++;
    [frame appendBytes:&itemId length:1];
    // 优先级长度
    itemLength = htons(1);
    [frame appendBytes:&itemLength length:2];
    uint8_t priority = 10;
    [frame appendBytes:&priority length:1];
    
    uint32_t frameLength = htonl([frame length]);
    [data appendBytes:&frameLength length:4];
    
    // frame
    [data appendData:frame];
    
    return data;
}


#pragma mark--  Connection

- (void)connect {
    
    NSError *error;
    
    [self.socket connectToHost:self.host onPort:2195 error:&error];
    
    if(error) {
        NSLog(@"failed to connect: %@", error);
        return;
    }
    
    [self.socket startTLS:@{
                            (NSString *)kCFStreamSSLCertificates: @[(__bridge id)_identity],
                            (NSString *)kCFStreamSSLPeerName: self.host
                            }];
    
}

- (void)disconnect {
    
    self.isConnected = NO;
    NSLog(@"disconnect connection\n");
    [self.socket disconnect];
    self.pushButton.enabled = NO;
}



- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag {
    if (tag == APNSSockTagWrite) {
        [sock readDataToLength:6 withTimeout:-1 tag:APNSSockTagRead];
    }
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    if (tag == APNSSockTagRead) {
        uint8_t status;
        uint32_t identifier;
        
        [data getBytes:&status range:NSMakeRange(1, 1)];
        
        [data getBytes:&identifier range:NSMakeRange(2, 4)];
        
        NSString *desc = [self statusDescByCode:status];
        
        NSLog(@"push message status %@ identifier %d",desc,identifier);
        
        [sock disconnect];
    }
}

#pragma mark--GCDAsyncSocketDelegate

- (void)socketDidSecure:(GCDAsyncSocket *)sock {
    
    self.isConnected = YES;
    
    NSLog(@"secure socket connected!");
    
    self.pushButton.enabled = YES;
    
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
    
    NSLog(@"socket disconnect err %@!",err);
    
    self.isConnected = NO;
    
    self.pushButton.enabled = NO;
}



#pragma mark--

- (NSString*)statusDescByCode:(int)status {
    NSString *desc;
    switch (status) {
        case 0:
            desc = @"No errors encountered";
            break;
        case 1:
            desc = @"Processing error";
            break;
        case 2:
            desc = @"Missing device token";
            break;
        case 3:
            desc = @"Missing topic";
            break;
        case 4:
            desc = @"Missing payload";
            break;
        case 5:
            desc = @"Invalid token size";
            break;
        case 6:
            desc = @"Invalid topic size";
            break;
        case 7:
            desc = @"Invalid payload size";
            break;
        case 8:
            desc = @"Invalid token";
            break;
        case 10:
            desc = @"Shutdown";
            break;
        default:
            desc = @"None (unknown)";
            break;
    }
    return desc;
}

#pragma mark-  property vars

- (GCDAsyncSocket*)socket {
    
    if(!_socket) {
        _socket = [[GCDAsyncSocket alloc] init];
        [_socket setDelegate:self delegateQueue: dispatch_get_main_queue()];
    }
    return _socket;
}

- (NSString*)host {
    
    BOOL isSandbox = YES;
    
    NSString *host = isSandbox?@"gateway.sandbox.push.apple.com":@"gateway.push.apple.com";
    
    return host;
}


@end

