//
//  SimpleViewController.m
//  AutoLayout
//
//  Created by zhaojw on 1/7/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//

#import "SimpleViewController.h"

@interface SimpleViewController ()
@property (weak) IBOutlet NSView *customView;

@end

@implementation SimpleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customView.wantsLayer = YES;
    self.customView.layer.backgroundColor = [NSColor purpleColor].CGColor;
    // Do view setup here.
}

@end
