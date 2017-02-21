//
//  AppDelegate.m
//  Animation2
//
//  Created by zhaojw on 4/6/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//

#import "AppDelegate.h"
#import "CABasicAnimationX.h"
#import <QuartzCore/QuartzCore.h>
@interface AppDelegate ()
@property (weak) IBOutlet NSView *layerView;

@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *textField;

@property (weak) IBOutlet NSBox *myView;

@property (weak) IBOutlet NSView *ok;
@property (weak) IBOutlet NSView *rotationView;

@property   (strong,nonatomic) CALayer *colorLayer;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
     [self.window.contentView setWantsLayer:YES];
    // [animationView.layer setAnchorPoint:NSMakePoint(0.5, 0.5)];
    
   // [self shakeAnimation];
    NSImage *image = [NSImage imageNamed:@"gradintCell"];
    self.rotationView.layer.contents = image;
    
   // [self romateAnimation];
    
    
    
    CAReplicatorLayer *copiedLayer = [CAReplicatorLayer layer];
    copiedLayer.frame = CGRectMake(0, 0, 10, 40);
    //copiedLayer.anchorPoint =  CGPointMake(0.5, 0.5);
    copiedLayer.position = CGPointMake(5, 20);
    copiedLayer.backgroundColor = [NSColor redColor].CGColor;
    copiedLayer.borderColor = [NSColor greenColor].CGColor;
    copiedLayer.borderWidth = 2.0;

    copiedLayer.instanceCount = 3;
    copiedLayer.instanceDelay = 0.3;
    copiedLayer.instanceColor = [NSColor redColor].CGColor;
    copiedLayer.instanceTransform  = CATransform3DMakeTranslation(60, 0, 0)  ;
    
   // self.layerView.wantsLayer = YES;
    
    [self.layerView.layer addSublayer:copiedLayer];
    
    
     NSLog(@" layer.delegate %@   ", self.rotationView.layer.delegate);
    
   // [self animationFillMode];
    
    //[self shuffle];
}

- (void)animationFillMode {
    CALayer *colorLayer = [[ CALayer alloc] init];
    self.colorLayer = colorLayer;
    colorLayer.position = CGPointMake(0, 0);
    colorLayer.backgroundColor = [NSColor redColor].CGColor;
    colorLayer.bounds = CGRectMake(0.0f, 0.0f, 20.0f, 20.0f);
    [self.rotationView.layer addSublayer:colorLayer];
    
    CABasicAnimationX *boundAn = [CABasicAnimationX animationWithKeyPath:@"bounds"];
    boundAn.fromValue = [NSValue valueWithRect:CGRectMake(0.0f, 0.0f, 30.0f, 30.0f)];
    boundAn.toValue = [NSValue valueWithRect:CGRectMake(0.0f, 0.0f, 60.0f, 60.0f)];
    boundAn.beginTime = 2.0f;
    boundAn.duration = 5.0f;
    boundAn.removedOnCompletion = NO;
    boundAn.delegate = self;
    boundAn.fillMode = kCAFillModeForwards;
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = [NSArray arrayWithObject:boundAn];
    group.duration = 10.0f;
    
    group.delegate =self;
    
    [colorLayer addAnimation:boundAn forKey:nil];
    
}

-(void)animationDidStart:(CAAnimation *)anim {
    
    NSSize size = self.rotationView.layer.bounds.size;
    
    NSLog(@"animationDidStart anim %@ size %@",anim,NSStringFromSize(size));
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    NSSize size = self.rotationView.layer.bounds.size;
    
    NSLog(@"animationDidStop anim %@ size %@",anim,NSStringFromSize(size));
}


- (void)displayLayer:(CALayer *)theLayer {
    NSImage *image = [NSImage imageNamed:@"gradintCell"];
    theLayer.contents =image;
}


- (void)runActionForKey:(NSString *)event object:(id)anObject
              arguments:(nullable NSDictionary *)dict {
    
    NSLog(@"anObject %@ dict %@",anObject,dict);
}


- (void)romateAnimation {
    
    self.rotationView.layer.backgroundColor = [NSColor redColor].CGColor;
    
    //CATransaction
    
    CAKeyframeAnimation *orbit = [CAKeyframeAnimation animation];
    orbit.keyPath = @"position";
    orbit.path = CFAutorelease(CGPathCreateWithEllipseInRect(CGRectMake(30, 30, 200, 200), NULL));
    orbit.duration = 4;
    orbit.additive = YES;
    orbit.repeatCount = HUGE_VALF;
    orbit.calculationMode = kCAAnimationPaced;
    orbit.rotationMode = kCAAnimationRotateAuto;
    [self.rotationView.layer addAnimation:orbit forKey:@"orbit"];
}

- (void)shakeAnimation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position.x";
    animation.values = @[ @0, @10, @-10, @10,@0 ];
    animation.keyTimes = @[ @0, @(1 / 6.0), @(3 / 6.0), @(5 / 6.0), @1 ];
    animation.duration = 0.5;
    
    animation.additive = YES;
    animation.repeatCount =30;
    
    [self.textField.layer addAnimation:animation forKey:@"shake"];
    
}

- (IBAction)startAnimation:(id)sender;



{
    //透明度
    
    //缩放1
    //    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    //    animation.duration = 2.0;
    //    animation.autoreverses = YES;
    //    animation.repeatCount = NSIntegerMax;
    //    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    //    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1, 1, 0.1)];
    //    [animationView.layer addAnimation:animation forKey:@""];
    
    //缩放2
    //    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //    animation.duration = 2.0;
    //    animation.autoreverses = YES;
    //    animation.repeatCount = NSIntegerMax;
    //    animation.fromValue = [NSNumber numberWithFloat:1.0];
    //    animation.toValue = [NSNumber numberWithFloat:0.1];
    //    [animationView.layer addAnimation:animation forKey:@""];
    
    //旋转1
    //    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    //    animation.duration = 2.0;
    //    //animation.autoreverses = YES;
    //    animation.repeatCount = NSIntegerMax;
    //    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    //    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DRotate(CATransform3DIdentity, pi, 0, 0, 1)];
    //    [animationView.layer addAnimation:animation forKey:@""];
    
    //旋转2
    //    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    //    animation.duration = 2.0;
    //    //animation.autoreverses = YES;
    //    animation.repeatCount = NSIntegerMax;
    //    animation.fromValue = [NSNumber numberWithFloat:0];
    //    animation.toValue = [NSNumber numberWithFloat:2*pi];
    //    [animationView.layer addAnimation:animation forKey:@""];
    
    
    
    //self.myView.frame = NSMakeRect(10,10,100,100);
    
    //

    
   // NSAnimatablePropertyContainer *gdg;
    

    
    
    
    
    NSAnimationContext.currentContext.allowsImplicitAnimation = YES;
    
    self.myView.wantsLayer = YES;
    
    [self.myView layoutSubtreeIfNeeded];
    
    
    self.myView.layer.backgroundColor = [NSColor redColor].CGColor;
    
     //self.myView.animator.frame = NSMakeRect(10,10,100,100);
    
    return;
    
    
    NSPoint myNewPosition = NSMakePoint(100,100);
    
    CABasicAnimation* theAnim = [CABasicAnimation animationWithKeyPath:@"position"];
    theAnim.fromValue = [NSValue valueWithPoint:self.myView.layer.position];
    theAnim.toValue = [NSValue valueWithPoint:myNewPosition];
    theAnim.duration = 3.0;
    theAnim.fillMode = kCAFillModeBoth;
    theAnim.removedOnCompletion = NO;
    //theAnim.additive = YES;
    //theAnim.cumulative = YES;
    //theAnim.repeatCount =10;
    [self.myView.layer addAnimation:theAnim forKey:@"animateFrame"];
    
    return;
    
    
    
    
    
    
    NSRect startFrame = [self.myView frame];
    NSRect endFrame = NSMakeRect(100, 100, startFrame.size.width, startFrame.size.height);
    NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:
                                self.myView,NSViewAnimationTargetKey,
                                [NSValue valueWithRect:startFrame],NSViewAnimationStartFrameKey,
                                [NSValue valueWithRect:endFrame],NSViewAnimationEndFrameKey, nil];
    NSViewAnimation *animation = [[NSViewAnimation alloc] initWithViewAnimations:[NSArray arrayWithObject:dictionary]];
    animation.duration = 2;
    [animation setAnimationBlockingMode:NSAnimationNonblockingThreaded];
    [animation setAnimationCurve:NSAnimationEaseIn];
    [animation startAnimation];
    
    
    return;
    
    
    
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext * _Nonnull context) {
        
        //context.allowsImplicitAnimation = YES;
       
        
        NSPoint myNewPosition = NSMakePoint(100,100);
        
        CABasicAnimation* theAnim = [CABasicAnimation animationWithKeyPath:@"position"];
        theAnim.fromValue = [NSValue valueWithPoint:self.myView.layer.position];
        theAnim.toValue = [NSValue valueWithPoint:myNewPosition];
        theAnim.duration = 3.0;
        [self.myView.layer addAnimation:theAnim forKey:@"animateFrame"];
        
        
        

        
        
    } completionHandler:^{
        
        NSLog(@"completionHandler");
    }
     
     ];
    
    
    return;
    
   
    
    //平移1
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
//    animation.duration = 2.0;
//    animation.autoreverses = YES;
//    animation.repeatCount = NSIntegerMax;
//    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
//    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DTranslate(CATransform3DIdentity, 100, 100, 0)];
//    [self.tt.layer addAnimation:animation forKey:@""];
    
    
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //平移2
        //[animationView.layer removeAllAnimations];
    });
    
    
}


- (void)shuffle {
    CABasicAnimation *zPosition = [CABasicAnimation animation];
    zPosition.keyPath = @"zPosition";
    zPosition.fromValue = @-1;
    zPosition.toValue = @1;
    zPosition.duration = 1.2;
    
    CAKeyframeAnimation *rotation = [CAKeyframeAnimation animation];
    rotation.keyPath = @"transform.rotation";
    rotation.values = @[ @0, @0.14, @0 ];
    rotation.duration = 1.2;
    rotation.timingFunctions = @[
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
                                 ];
    
    CAKeyframeAnimation *position = [CAKeyframeAnimation animation];
    position.keyPath = @"position";
    position.values = @[
                        [NSValue valueWithPoint:CGPointZero],
                        [NSValue valueWithPoint:CGPointMake(110, -20)],
                        [NSValue valueWithPoint:CGPointZero]
                        ];
    position.timingFunctions = @[
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
                                 ];
    position.additive = YES;
    position.duration = 1.2;
    
    
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    group.animations = @[ zPosition, rotation, position ];
    group.duration = 1.2;
    group.beginTime = 0.5;
    
    self.myView.wantsLayer = YES;
    
    [self.myView.layer addAnimation:group forKey:@"shuffle"];
    
    self.myView.layer.zPosition = 1;
}


@end
