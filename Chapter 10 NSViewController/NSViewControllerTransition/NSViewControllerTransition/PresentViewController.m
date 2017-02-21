//
//  PresentViewController.m
//  NSViewControllerTransition
//
//  Created by iDevFans on 2016/11/2.
//  Copyright © 2016年 macdev. All rights reserved.
//

#import "PresentViewController.h"

@interface PresentViewController ()

@end

@implementation PresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}
- (IBAction)dismissAction:(id)sender {
    
    if (self.presentingViewController) {
        [self dismissController:self];
    }
    else {
        [self.view.window close];
    }
}

@end


