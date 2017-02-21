//
//  TextViewController.m
//  NSPageControllerDemo
//
//  Created by zhaojw on 15/9/17.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import "TextViewController.h"

@interface TextViewController ()
@property (unsafe_unretained) IBOutlet NSTextView *textView;
@end

@implementation TextViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}


- (void)updataViewWithFileName:(NSString*)fileName
{
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    
    
    NSURL *url = [NSURL fileURLWithPath:path];
    
    NSError *error;
    
    NSString *modelContent = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    
    if(modelContent){
        self.textView.string =modelContent;
    }

}
@end
