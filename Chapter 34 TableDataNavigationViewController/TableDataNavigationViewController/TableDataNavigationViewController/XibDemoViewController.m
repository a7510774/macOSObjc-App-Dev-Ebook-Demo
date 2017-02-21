//
//  XibDemoViewController.m
//  TableDataNavigationViewController
//
//  Created by MacDev on 16/6/13.
//  Copyright © 2016年 http://www.macdev.io All rights reserved.
//

#import "XibDemoViewController.h"

@interface XibDemoViewController ()
@property (weak) IBOutlet DataNavigationView *navigationView;
@property (weak) IBOutlet NSTableView *testTableView;

@end

@implementation XibDemoViewController

- (id)init {
    self = [super initWithNibName:@"XibDemoViewController" bundle:nil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}


- (NSTableView*)tableXibView{
    return self.testTableView;
}

- (DataNavigationView*)dataNavigationXibView{
    return self.navigationView;
}


@end
