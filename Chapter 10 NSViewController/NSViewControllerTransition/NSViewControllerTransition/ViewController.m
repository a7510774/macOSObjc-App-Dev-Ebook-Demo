//
//  ViewController.m
//  NSViewControllerTransition
//
//  Created by iDevFans on 2016/11/2.
//  Copyright © 2016年 macdev. All rights reserved.
//

#import "ViewController.h"
#import "PresentCustomAnimator.h"


@interface ViewController()<NSGestureRecognizerDelegate>

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSGestureRecognizer *gr = [[NSMagnificationGestureRecognizer alloc]
                               initWithTarget:self action:@selector(magnify:)];
    [self.view addGestureRecognizer:gr];
    gr.delegate = self;
    // Do any additional setup after loading the view.
}

- (IBAction)presentAsModalAction:(id)sender {
    
    NSViewController *presentVC = [self.storyboard instantiateControllerWithIdentifier:@"PresentVC"];
    
    [self presentViewControllerAsModalWindow:presentVC];

}

- (IBAction)presentAsSheetAction:(id)sender {
    
    NSViewController *presentVC = [self.storyboard instantiateControllerWithIdentifier:@"PresentVC"];
    
    [self presentViewControllerAsSheet:presentVC];
    
}

- (IBAction)presentAsPopoverAction:(NSButton*)sender {
    
    NSViewController *p = [self.storyboard instantiateControllerWithIdentifier:@"PresentVC"];
    
    [self presentViewController:p
        asPopoverRelativeToRect:sender.frame
                         ofView:self.view
                  preferredEdge:NSMinYEdge
                       behavior:NSPopoverBehaviorTransient];
}

- (IBAction)presentAsAnimatorAction:(id)sender {
    NSViewController *p = [self.storyboard instantiateControllerWithIdentifier:@"PresentVC"];
    PresentCustomAnimator *animator = [[PresentCustomAnimator alloc] init];
    [self presentViewController:p animator:animator];
}

- (IBAction)showAction:(id)sender {
    NSViewController *p = [self.storyboard instantiateControllerWithIdentifier:@"PresentVC"];
    NSViewController *toVC = [self.storyboard instantiateControllerWithIdentifier:@"ToVC"];
    //增加 2个子视图控制器
    [self addChildViewController:p];
    [self addChildViewController:toVC];
    //显示 p 视图
    [self.view addSubview:p.view];
    // 从 p 视图 切换到另外一个 toVC 视图
    [self transitionFromViewController:p toViewController:toVC options:NSViewControllerTransitionCrossfade completionHandler:nil];
}



- (void)magnify:(NSClickGestureRecognizer*)gr {
    
    switch (gr.state) {
        case NSGestureRecognizerStateBegan:
        {}
        case NSGestureRecognizerStateChanged:
        {}
        case NSGestureRecognizerStateEnded:
        {}
        case NSGestureRecognizerStateCancelled:
        {}
        default:
        {}
            
    }
}


@end
