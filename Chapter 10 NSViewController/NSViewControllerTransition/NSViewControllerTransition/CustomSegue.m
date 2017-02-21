//
//  CustomSegue.m
//  NSViewControllerTransition
//
//  Created by iDevFans on 2016/11/2.
//  Copyright © 2016年 macdev. All rights reserved.
//

#import "CustomSegue.h"
#import "PresentCustomAnimator.h"

@implementation CustomSegue

- (void)perform {
    
    NSViewController *sourceViewController = self.sourceController;
    NSViewController *destinationController = self.destinationController;
    
    PresentCustomAnimator *animator = [[PresentCustomAnimator alloc] init];
  
    [sourceViewController presentViewController:destinationController animator:animator];
    
}

@end
