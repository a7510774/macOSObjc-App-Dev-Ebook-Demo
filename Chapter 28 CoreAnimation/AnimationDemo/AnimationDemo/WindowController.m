//
//  WindowController.m
//  AnimationDemo
//
//  Created by zhaojw on 3/14/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//

#import "WindowController.h"
#import <QuartzCore/QuartzCore.h>
#import "NSBezierPath+BezierPathQuartzUtilities.h"
#import "BabyLayer.h"
#import <Appkit/Appkit.h>
#import <Foundation/NSValue.h>

#import "CustomView.h"

@interface WindowController ()
@property (weak) IBOutlet CustomView *drawRectView;
@property (weak) IBOutlet NSImageView *imageView;
@property (weak) IBOutlet NSImageView *layerView;
@property (weak) IBOutlet NSImageView *leftView;
@property (weak) IBOutlet NSView *rightView;
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,strong) CAShapeLayer *shapeLayer;
@property (nonatomic,strong) CALayer *blueLayer;
@end

@implementation WindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    [self.window center];
    
    NSAnimation *fh
    ;
    
    NSView   *dgd33;
    
    NSViewAnimation *vv;
    
    
    CATransaction *dg;
    
    NSAffineTransform *dgd;
    
    
    NSView *dgdgf;
    
   

    CALayer *ll;
    
    
    
    CGImageSourceRef  *sgsdf;
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    
    
    self.drawRectView.wantsLayer = YES;
    
    CALayer *blueLayer = [BabyLayer layer];
    blueLayer.frame = CGRectMake(0, 0, 100.0f, 100.0f);
    blueLayer.borderWidth =1;
    blueLayer.backgroundColor =[NSColor yellowColor].CGColor;
    //blueLayer.delegate = self;
    
    self.layerView.wantsLayer = YES;
    
    [self.layerView.layer addSublayer:blueLayer];
    
    self.blueLayer = blueLayer;
    
    
    
    
    //return;
    
    
  

    
    CAGradientLayer *gradientLayer         = [CAGradientLayer layer];
    gradientLayer.frame    = CGRectMake(0, 0, 200, 200);
    
    gradientLayer.colors = @[(id)[NSColor greenColor].CGColor,
                           (id)[NSColor redColor].CGColor,
                           (id)[NSColor cyanColor].CGColor,
                           (id)[NSColor purpleColor].CGColor,
                           (id)[NSColor blueColor].CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    
    
   
    
    
//    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    pathAnimation.duration = 5.0;
//    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
//    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
//    [ self.shapeLayer addAnimation:pathAnimation forKey:nil];
//     shapeLayer.strokeEnd = 1;
//    return;
    
    //self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(animationAction:) userInfo:nil repeats:YES];
    
    //[[NSRunLoop currentRunLoop]addTimer: self.timer  forMode:NSRunLoopCommonModes];
    //[blueLayer setNeedsDisplay];
    
    [self drawLine];
    //[self drawCircle];
}

- (void)runActionForKey:(NSString *)event object:(id)anObject
              arguments:(nullable NSDictionary *)dict {
    
    NSLog(@"anObject %@ dict %@",anObject,dict);
}

- (void)drawLine {
    
    CAShapeLayer *shapeLayer  = [CAShapeLayer layer];
    shapeLayer.frame    = CGRectMake(0, 0, 200, 200);
    
    CGMutablePathRef fillPath = CGPathCreateMutable();
    //CGPathAddRect(fillPath, NULL, shapeLayer.bounds);
    CGPathMoveToPoint(fillPath, NULL, 0, 20);
    CGPathAddLineToPoint(fillPath, NULL, 200, 20);
    shapeLayer.fillColor = [NSColor blueColor].CGColor;
    shapeLayer.backgroundColor =  [NSColor redColor].CGColor;
    shapeLayer.borderWidth = 2;
    shapeLayer.path = fillPath;
    shapeLayer.strokeStart = 0;
    shapeLayer.strokeEnd = 0;
    
    shapeLayer.strokeColor = [NSColor greenColor].CGColor;
    self.shapeLayer = shapeLayer;
    
    [self.layerView.layer addSublayer:shapeLayer];
    
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(animationAction:) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop]addTimer: self.timer  forMode:NSRunLoopCommonModes];
    
}

- (void)drawCircle {
    
    CAShapeLayer *shapeLayer  = [CAShapeLayer layer];
    shapeLayer.frame    = CGRectMake(0, 0, 200, 200);
    CGMutablePathRef fillPath = CGPathCreateMutable();
    CGPathAddEllipseInRect(fillPath, NULL, CGRectMake(10, 10, 180, 180));
    shapeLayer.fillColor = [NSColor clearColor].CGColor;
    //shapeLayer.backgroundColor =  [NSColor clearColor].CGColor;
    shapeLayer.borderWidth = 2;
    shapeLayer.path        = fillPath;
    shapeLayer.strokeStart = 0.0;
    shapeLayer.strokeEnd   = 0.0;
    shapeLayer.strokeColor = [NSColor greenColor].CGColor;
    self.shapeLayer = shapeLayer;
    
    [self.layerView.layer addSublayer:shapeLayer];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(animationAction:) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop]addTimer: self.timer  forMode:NSRunLoopCommonModes];
    
}

- (void)animationAction:(id)sender {
    if(self.shapeLayer.strokeEnd<1.0){
         self.shapeLayer.strokeEnd += 0.1;
    }
    else{
        [self.timer invalidate];
    }
}

- (void)displayLayer:(CALayer *)theLayer {
    NSImage *image = [NSImage imageNamed:@"gradintCell"];
    theLayer.contents =image;
}


- (void)drawLayer:(CALayer *)theLayer inContext:(CGContextRef)theContext {
    
    //draw a blue rectangle
    CGContextSetLineWidth(theContext, 4.0f);
    CGContextSetStrokeColorWithColor(theContext, [NSColor greenColor].CGColor);
    CGContextSetFillColorWithColor(theContext, [NSColor blueColor].CGColor);
    CGContextFillRect(theContext, theLayer.bounds);
    
}


- (IBAction)actionAnimation:(id)sender {
    
   // [self animationBorderChanged];
    
    
    self.drawRectView.animator.lineColor = [NSColor yellowColor];
    
    //self.imageView.wantsLayer = YES;
    
    //[self animationOpacity];
    
    return;
    
    
    
    NSBezierPath *bezierPath = [[NSBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(0, 150)];
    [bezierPath curveToPoint:CGPointMake(300, 150)                                                              controlPoint1:CGPointMake(75, 0) controlPoint2:CGPointMake(225, 300)];
    //draw the path using a CAShapeLayer
   
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = [bezierPath quartzPath];
    pathLayer.fillColor = [NSColor clearColor].CGColor;
    pathLayer.strokeColor = [NSColor redColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    [self.layerView.layer addSublayer:pathLayer];
    //add a colored layer
    CALayer *colorLayer = [CALayer layer];
    colorLayer.frame = CGRectMake(0, 0, 64, 64);
    colorLayer.position = CGPointMake(0, 150);
    colorLayer.backgroundColor = [NSColor greenColor].CGColor;
    [self.layerView.layer addSublayer:colorLayer];
    
    //create the position animation
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animation];
    animation1.keyPath = @"position";
    animation1.path = [bezierPath quartzPath];
    animation1.rotationMode = kCAAnimationRotateAuto;
    //create the color animation
    CABasicAnimation *animation2 = [CABasicAnimation animation];
    animation2.keyPath = @"backgroundColor";
    animation2.toValue = (__bridge id)[NSColor redColor].CGColor;
    //create group animation
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation]; groupAnimation.animations = @[animation1, animation2]; groupAnimation.duration = 4.0;
    //add the animation to the color layer
    [colorLayer addAnimation:groupAnimation forKey:nil];
    
    
    return;
    
    float opacity= self.imageView.layer.opacity ;
    
    CALayer *theLayer = self.imageView.layer;
    
    
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [NSColor greenColor].CGColor;
    layer.frame = CGRectMake(0, 0, 100, 100);
    [theLayer addSublayer:layer];
    
    layer.frame = CGRectOffset(layer.frame, 100, 0);
    
    
//    NSImage *image = [NSImage imageNamed:@"gradintCell"];
//    //add it directly to our view's layer
//    layer.contents =image;
    
    
    CGAffineTransform transform;
    
    
    return;
    
    [CATransaction begin];
    
    [CATransaction setValue:[NSNumber numberWithFloat:5.0f]
                     forKey:kCATransactionAnimationDuration];
    
      if(opacity>0){
          
           theLayer.opacity = 0.0;
      }
      else {
           theLayer.opacity = 1.0;
      }
    
    [CATransaction commit];
}

- (void)animationOpacity {
    
    
    self.blueLayer.opacity = 0.1;
    
    return;
    
    self.imageView.wantsLayer = YES;
    float opacity= self.imageView.layer.opacity ;
  
    CALayer *theLayer = self.imageView.layer;
    if(opacity>0){
        //self.imageView.layer.opacity = 0;
        
        CABasicAnimation* fadeAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
        fadeAnim.fromValue = [NSNumber numberWithFloat:1.0];
        fadeAnim.toValue = [NSNumber numberWithFloat:0.0];
        fadeAnim.duration = 1.0;
        [theLayer addAnimation:fadeAnim forKey:@"opacity"];
        // Change the actual data value in the layer to the final value.
        theLayer.opacity = 0.0;
        
    }
    else{
        //self.imageView.layer.opacity = 1.0;
        
        CABasicAnimation* fadeAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
        fadeAnim.fromValue = [NSNumber numberWithFloat:0.0];
        fadeAnim.toValue = [NSNumber numberWithFloat:1.0];
        fadeAnim.duration = 1.0;
        [theLayer addAnimation:fadeAnim forKey:@"opacity"];
        // Change the actual data value in the layer to the final value.
        theLayer.opacity = 1.0;
    }
    
    self.imageView.wantsLayer = YES;
   
    
    CALayer *modelLayer = theLayer.modelLayer;
    NSLog(@"modelLayer opacity %f ",modelLayer.opacity);
    
    CALayer *presentationLayer = theLayer.presentationLayer;
    NSLog(@"presentationLayer opacity %f ",presentationLayer.opacity);
    
    
}

- (void)animationPath {
    
    self.imageView.wantsLayer = YES;
    
    CALayer *theLayer = self.imageView.layer;
    
    CGMutablePathRef thePath = CGPathCreateMutable();
    CGPathMoveToPoint(thePath,NULL,40.0,40.0);
    CGPathAddCurveToPoint(thePath,NULL,40.0,100.0,
                          120.0,200.0,
                          120.0,40.0);
 
    CAKeyframeAnimation * theAnimation;
    
    theAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position.y"];
    theAnimation.path=thePath;
    theAnimation.duration=2.0;
    // Add the animation to the layer.
    [theLayer addAnimation:theAnimation forKey:@"position"];
}



- (void)animationBorderChanged {
    
    self.imageView.wantsLayer = YES;
    
    
    
    CATransition* transition = [CATransition animation];
    transition.startProgress = 0;
    transition.endProgress = 1.0;
    transition.type = kCATransitionMoveIn;
    
    transition.subtype = kCATransitionFromRight;
    transition.duration = 1.0;
    // Add the transition animation to both layers
    [self.imageView.layer addAnimation:transition forKey:@"transition"];
    
   
    
    
    
    
    return;
    
    
    CALayer *theLayer = self.imageView.layer;
    
    CAKeyframeAnimation* widthAnim = [CAKeyframeAnimation
                                      animationWithKeyPath:@"borderWidth"];
    NSArray* widthValues = [NSArray arrayWithObjects:@1.0, @10.0, @5.0, @30.0, @0.5,
                            @15.0, @2.0, @50.0, @0.0, nil];
    widthAnim.values = widthValues;
    widthAnim.calculationMode = kCAAnimationPaced;
    // Animation 2
    CAKeyframeAnimation* colorAnim = [CAKeyframeAnimation
                                      animationWithKeyPath:@"borderColor"];
    NSArray* colorValues = [NSArray arrayWithObjects:(id)[NSColor greenColor].CGColor, (id)[NSColor redColor].CGColor, (id)[NSColor blueColor].CGColor, nil];
    colorAnim.values = colorValues;
    colorAnim.calculationMode = kCAAnimationPaced;
    
    CAAnimationGroup* group = [CAAnimationGroup animation];
    group.animations = [NSArray arrayWithObjects: widthAnim, nil];
    group.duration = 5.0;
    [theLayer addAnimation:group forKey:@"BorderChanges"];
}

- (IBAction)swapAction:(id)sender {
    
    
    [self.leftView.layer setAnchorPoint:NSMakePoint(0.5, 0.5)];
    
    self.leftView.wantsLayer = YES;

   
//    NSPoint myNewPosition = NSMakePoint(100,100);
//    
//    CABasicAnimation* theAnim = [CABasicAnimation animationWithKeyPath:@"position"];
//    theAnim.fromValue = [NSValue valueWithPoint:self.leftView.layer.position];
//    theAnim.toValue = [NSValue valueWithPoint:myNewPosition];
//     theAnim.duration = 3.0;
//    [self.leftView.layer addAnimation:theAnim forKey:@"animateFrame"];
//    
    
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
        animation.duration = 2.0;
        animation.autoreverses = YES;
    
        //animation.repeatCount = NSIntegerMax;
        animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    
        animation.toValue = [NSValue valueWithCATransform3D:CATransform3DTranslate(CATransform3DIdentity, 100, 100, 0)];
    
        [self.leftView.layer addAnimation:animation forKey:@""];
    
   
 }


- (IBAction)swapAction2:(id)sender {
    
    
    
    
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext * _Nonnull context) {
        
        //context.allowsImplicitAnimation = YES;
        NSRect frame0=self.leftView.frame;
        NSRect frame1=self.rightView.frame;
        //self.leftView.frame=frame1;
        //self.rightView.frame=frame0;
        
        
        [[self.leftView animator] setFrame:frame1];
        
        [[self.rightView animator] setFrame:frame0];
        
        
    } completionHandler:^{
        
    }
     
     ];
    
    NSSplitView *dgdg;
    
    
}

- (IBAction)drawTest:(id)sender {
    
    NSRect r1 = NSMakeRect(0, 10, 20, 20);
    
    NSRect r2 = NSMakeRect(20, 30, 20, 20);
    
    
    [self.drawRectView setNeedsDisplayInRect:r1];
    
     [self.drawRectView setNeedsDisplayInRect:r2];
    
    
    CATextLayer *dgd;
    
    
    CATextLayer *textLayer = [[CATextLayer alloc] init];
    [textLayer setFontSize:14.0];
    [textLayer setContentsScale:[[NSScreen mainScreen] backingScaleFactor]];
    [textLayer setFrame:CGRectMake(0, 0, 80, 50)];
    [textLayer setString:@"text string"];
    [textLayer setAlignmentMode:kCAAlignmentCenter];
    [textLayer setBackgroundColor:[[NSColor clearColor] CGColor]];
    [textLayer setForegroundColor:[[NSColor blackColor] CGColor]];
   
    [self.leftView.layer addSublayer:textLayer];
    
    
}




@end
