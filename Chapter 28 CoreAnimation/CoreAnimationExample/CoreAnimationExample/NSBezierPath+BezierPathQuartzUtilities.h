//
//  NSBezierPath+BezierPathQuartzUtilities.h
//  AnimationDemo
//
//  Created by zhaojw on 3/24/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <AppKit/NSBezierPath.h>

@interface  NSBezierPath (BezierPathQuartzUtilities)
- (CGPathRef)quartzPath;
@end
