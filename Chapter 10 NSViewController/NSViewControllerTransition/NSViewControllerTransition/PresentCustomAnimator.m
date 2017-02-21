//
//  PresentCustomAnimator.m
//  NSViewControllerDemo
//
//  Created by zhaojw on 5/9/16.
//  Copyright © 2016 zhaojw. All rights reserved.
//

#import "PresentCustomAnimator.h"

@implementation PresentCustomAnimator

- (void)animatePresentationOfViewController:(NSViewController *)viewController fromViewController:(NSViewController *)fromViewController {
    NSViewController* bottomVC = fromViewController;
    NSViewController* topVC = viewController;
 
    topVC.view.wantsLayer = YES;
    topVC.view.alphaValue = 0;
    
    [bottomVC.view addSubview:topVC.view];
   
    topVC.view.layer.backgroundColor = [NSColor grayColor].CGColor;
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        context.duration = 0.5;
        topVC.view.animator.alphaValue = 1;
    } completionHandler:nil];
    
}

- (void)animateDismissalOfViewController:(NSViewController *)viewController fromViewController:(NSViewController *)fromViewController {
    NSViewController* topVC = viewController;
    topVC.view.wantsLayer = YES;
  
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        context.duration = 0.5;
        topVC.view.animator.alphaValue = 0;
    } completionHandler:^{
        [topVC.view removeFromSuperview];
    }];
}

@end
