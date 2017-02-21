//
//  FirstViewController.m
//  NSViewControllerDemo
//
//  Created by zhaojw on 5/9/16.
//  Copyright © 2016 zhaojw. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    
    NSLog(@"self.window %@",self.view.window);
}



- (IBAction)dismiss:(id)sender {
    
    NSLog(@"self.view.window %@", self.view.window);
    
    if (self.presentingViewController) {
        [self.presentingViewController dismissViewController:self];
    } else {
        [self.view.window close];
    }
}

@end
