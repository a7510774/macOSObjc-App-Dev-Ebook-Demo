//
//  ImageViewController.m
//  NSPageControllerDemo
//
//  Created by zhaojw on 15/9/17.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()
@property (weak) IBOutlet NSImageView *imageView;
@end

@implementation ImageViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Do view setup here.
}


- (void)updataViewWithFileName:(NSString*)fileName
{

    self.imageView.image = [NSImage imageNamed:fileName];
}
@end
