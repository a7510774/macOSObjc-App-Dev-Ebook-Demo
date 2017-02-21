//
//  ViewController.m
//  OpenMacI
//
//  Created by zhaojw on 12/18/15.
//  Copyright © 2015 MacDev.io. All rights reserved.
//

#import "ViewController.h"
#import "JSONObjKit.h"
#import "XXXCentralClient.h"
#import "ClientCmdHelper.h"

#define  kServiceUUID           @"84941CC5-EA0D-4CAE-BB06-1F849CCF8495"
#define  kCharacteristicUUID    @"2BCD"



extern NSString *kCmdTypeKey ;
extern NSString *kPasswordKey ;
extern NSString *kStatusKey ;
extern NSString *kUsernameKey ;

@interface ViewController ()<XXXCentralClientDelegate>
@property(nonatomic,strong)XXXCentralClient *centralClient;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIButton *lockButton;
@property (weak, nonatomic) IBOutlet UIButton *restartButton;
@property (weak, nonatomic) IBOutlet UIButton *shutdownButton;
@property (weak, nonatomic) IBOutlet UILabel  *hostNameLabel;
@property(nonatomic,assign) BOOL     isMacSleep; //标记Mac是否处于休眠态
@property (weak, nonatomic) IBOutlet UIImageView *macImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.activityIndicatorView startAnimating];
    [self.lockButton setHidden:YES];
    [self.restartButton setHidden:YES];
    [self.shutdownButton setHidden:YES];
    self.hostNameLabel.text = @"";
    self.isMacSleep = NO;
    
    [self.centralClient start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)lockAction:(id)sender {
    NSData *CmdData = [ClientCmdHelper sleepCmdData];
    if(self.isMacSleep){
        CmdData = [ClientCmdHelper wakeupCmdData];
    }
    [self.centralClient writeData:CmdData];
    [self.centralClient pingService];
}


- (IBAction)restartAction:(id)sender {
    NSData *CmdData = [ClientCmdHelper restartCmdData];
    [self.centralClient writeData:CmdData];
    [self.centralClient pingService];
}

- (IBAction)shutdownAction:(id)sender {
    NSData *CmdData = [ClientCmdHelper shutdownCmdData];
    [self.centralClient writeData:CmdData];
    [self.centralClient pingService];
}



#pragma mark-- XXXCentralClientDelegate

- (void)centralClient:(XXXCentralClient*)centralClient didRecieveAdvertisementData:(NSDictionary*)advertisementData {
    NSString *userName = advertisementData[CBAdvertisementDataLocalNameKey];
    if(userName){
        self.hostNameLabel.text = userName;
        UIImage *image = [UIImage imageNamed:@"MacColor"];
        self.macImageView.image = image;
    }
}

- (void)centralClient:(XXXCentralClient*)centralClient didRecieveSubscribeData:(NSData*)subscribData {
    
    NSDictionary *dataDict = [subscribData xx_objectFromJSONData];
    if(!dataDict){
        return;
    }
    StatusType status = (StatusType)[dataDict[kStatusKey] integerValue];
    NSLog(@"status dataDict %@ ",dataDict);
    if(status==StatusWakeupType && self.isMacSleep){
       
        self.isMacSleep = NO;
        self.lockButton.titleLabel.text = @"  Lock  ";
        
    }
    if(status==StatusSleepType && !self.isMacSleep){
        self.isMacSleep = YES;
        self.lockButton.titleLabel.text = @"Unlock";
        
    }
}

- (void)didStartConnect:(XXXCentralClient*)centralClient {
    self.statusLabel.text = @"Connecting...";
}

- (void)didCompleteConnect:(XXXCentralClient*)centralClient {
    
    [self.activityIndicatorView stopAnimating];
    [self.activityIndicatorView setHidden:YES];
    [self.statusLabel setHidden:YES];
    [self.lockButton setHidden:NO];
    [self.restartButton setHidden:NO];
    [self.shutdownButton setHidden:NO];
 
}

#pragma mark- ivar
- (XXXCentralClient*)centralClient {
    if(!_centralClient){
        _centralClient = [[XXXCentralClient alloc]initWithServiceID:kServiceUUID characterisitcID:kCharacteristicUUID];
        _centralClient.delegate = self;
    }
    return _centralClient;
}


@end
