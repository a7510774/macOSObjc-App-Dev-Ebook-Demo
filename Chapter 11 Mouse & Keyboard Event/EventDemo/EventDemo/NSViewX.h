//
//  NSViewX.h
//  EventDemo
//
//  Created by zhaojw on 15/10/13.
//  Copyright © 2015年 zhaojw. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSViewX : NSView
@property (nullable, weak) id target; // Target is weak for zeroing-weak compatible objects in apps linked on 10.10 or later. Otherwise the behavior of this property is 'assign’.
@property (nullable) SEL action;
@end
