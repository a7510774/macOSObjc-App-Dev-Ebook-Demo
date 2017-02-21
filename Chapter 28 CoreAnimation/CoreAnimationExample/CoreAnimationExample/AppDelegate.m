//
//  AppDelegate.m
//  CoreAnimationExample
//
//  Created by zhaojw on 4/25/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//

#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "NSBezierPath+BezierPathQuartzUtilities.h"
@interface AppDelegate ()

@property (weak) IBOutlet NSTextField *userNameTextField;
@property (weak) IBOutlet NSWindow *window;
@property(nonatomic,strong)CALayer *layer;
@property (weak) IBOutlet NSImageView *imageView;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    NSView *view = [self.window contentView];
    view.wantsLayer = YES;
    
    
    //[self rotateAnimation];
    
    //[self transitionAnimation];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

-(void)transitionAnimation {
    
    CATransition* transition = [CATransition animation];
    
    transition.startProgress = 0.5;
    
    transition.endProgress = 1.0;
    
    transition.type = kCATransitionPush;
    
    transition.subtype = kCATransitionFromBottom;
    
    transition.duration = 1.0;
    
    [self.imageView.layer addAnimation:transition forKey:@"transition"];
    
    self.imageView.wantsLayer = YES;
    CALayer *theLayer = self.imageView.layer;
    CALayer *modelLayer = theLayer.modelLayer;
    NSLog(@"modelLayer opacity %f ",modelLayer.opacity);

    
    
}

-(IBAction)transitionAction:(id)sender {
    [self transitionAnimation];
    self.imageView.hidden = !self.imageView.hidden;
}

- (void)groupAnimation {
    
    NSView *view = [self.window contentView];
    CALayer *rootLayer = view.layer;
    
    CALayer *layer = [CALayer layer];
 
    
    layer.frame = CGRectMake(10,10, 100, 100);
    [rootLayer addSublayer:layer];
    
    CABasicAnimation *animation1 = [CABasicAnimation animation];
    animation1.keyPath = @"borderWidth";
    animation1.toValue = @(10);
    animation1.duration = 4.0;
    
    CABasicAnimation *animation2 = [CABasicAnimation animation];
    animation2.keyPath = @"backgroundColor";
    animation2.toValue = (__bridge id)[NSColor redColor].CGColor;
 
    [CATransaction begin];
 
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[animation1, animation2];
    groupAnimation.duration = 4.0;
    
    [layer addAnimation:animation1 forKey:nil];
    
    
    [CATransaction commit];
    
    
    [CATransaction setCompletionBlock:^(){
    
        self.layer.borderWidth      = 10;
        self.layer.backgroundColor  = [NSColor redColor].CGColor;
        
    }];
    
    //self.layer.borderWidth      = 10;
    //self.layer.backgroundColor  = [NSColor redColor].CGColor;
    
}



- (void)groupAnimation2 {
    
    NSView *view = [self.window contentView];
    CALayer *rootLayer = view.layer;
    
    
    
    CALayer *layer = [CALayer layer];
    self.layer  = layer;
   
    layer.frame = CGRectMake(10,10, 100, 100);
    [rootLayer addSublayer:layer];
    
    CABasicAnimation *animation1 = [CABasicAnimation animation];
    animation1.keyPath = @"borderWidth";
    animation1.toValue = @(10);
    animation1.delegate = self;
    
    CABasicAnimation *animation2 = [CABasicAnimation animation];
    animation2.keyPath = @"backgroundColor";
    animation2.toValue = (__bridge id)[NSColor redColor].CGColor;
    animation2.delegate = self;
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[animation1, animation2];
    groupAnimation.duration = 4.0;
    //groupAnimation.delegate = self;
   // groupAnimation.fillMode = kCAFillModeForwards;
    
    //groupAnimation.removedOnCompletion = NO;
    
    //groupAnimation.fillMode = kCAFillModeForwards;
    
   // self.layer.borderWidth      = 10;
    //self.layer.backgroundColor  = [NSColor redColor].CGColor;
    
    [layer addAnimation:animation1 forKey:nil];
    
    //self.layer.borderWidth      = 10;
    //self.layer.backgroundColor  = [NSColor redColor].CGColor;
    
}

-(void)animationDidStart:(CAAnimation *)anim {
    
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    self.layer.borderWidth      = 10;
    //self.layer.backgroundColor  = [NSColor redColor].CGColor;
    
}


- (void)rotateAnimation {
    
    
    NSView *view = [self.window contentView];
    CALayer *rootLayer = view.layer;
    
    
   
    //做为mask的Shape Layer
    CAShapeLayer* circleShapeLayer = [CAShapeLayer layer];
    CGMutablePathRef shapePath = CGPathCreateMutable();
    CGPathAddEllipseInRect(shapePath, nil, CGRectMake(0, 0, 160, 160));
    circleShapeLayer.path = shapePath;
  
    
    //圆形图层
    CALayer *circleLayer = [CALayer layer];
    circleLayer.frame = CGRectMake(60, 60, 160, 160);
    circleLayer.backgroundColor = [NSColor purpleColor].CGColor;
    circleLayer.mask = circleShapeLayer;
    circleLayer.masksToBounds = YES;
    [rootLayer addSublayer:circleLayer];
    
    
    //旋转的图层
    CALayer *colorLayer = [CALayer layer];
    colorLayer.frame = CGRectMake(-10,-10, 20, 20);
    colorLayer.backgroundColor = [NSColor greenColor].CGColor;
    [rootLayer addSublayer:colorLayer];
    
    //沿着圆形轨迹运行的关键帧动画
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animation];
    animation1.keyPath      = @"position";
    animation1.path         = CGPathCreateWithEllipseInRect(CGRectMake(40, 40, 200, 200), NULL);
    animation1.rotationMode = kCAAnimationRotateAuto;
    animation1.repeatCount  = 100000;
    animation1.additive     = YES;
    animation1.duration     = 2.0;
    animation1.calculationMode = kCAAnimationPaced;
    [colorLayer addAnimation:animation1 forKey:nil];

    
    //return;
    
    //create the color animation
    CABasicAnimation *animation2 = [CABasicAnimation animation];
    animation2.keyPath = @"backgroundColor";
    animation2.toValue = (__bridge id)[NSColor redColor].CGColor;
    //create group animation
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation]; groupAnimation.animations = @[animation1, animation2];
    groupAnimation.duration = 4.0;
    groupAnimation.repeatCount = NSIntegerMax;
    groupAnimation.fillMode =  kCAFillModeForwards;
    
    //add the animation to the color layer
   // [colorLayer addAnimation:groupAnimation forKey:nil];
}


- (IBAction)okAction:(id)sender {
    
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    
    animation.additive = YES;
    
    animation.values = @[@(-15),@(15),@(-10),@(10), @(-8),@(8),@(-6),@(6),@(-4),@(4)];
    
    animation.duration = 1;
    
    [self.userNameTextField.layer addAnimation:animation forKey:nil];
    
}

@end
