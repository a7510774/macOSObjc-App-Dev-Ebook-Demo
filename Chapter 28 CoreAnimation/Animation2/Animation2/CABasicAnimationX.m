//
//  CABasicAnimationX.m
//  Animation2
//
//  Created by zhaojw on 4/11/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//

#import "CABasicAnimationX.h"

@implementation CABasicAnimationX
- (void)runActionForKey:(NSString *)event object:(id)anObject
              arguments:(nullable NSDictionary *)dict {
    
    
    NSLog(@" %@ %@ %@ ",event,anObject,dict);
    
    return [super runActionForKey:event object:anObject arguments:dict];
}
@end
