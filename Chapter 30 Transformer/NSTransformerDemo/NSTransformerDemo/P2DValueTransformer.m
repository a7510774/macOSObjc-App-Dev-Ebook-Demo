//
//  P2DValueTransformer.m
//  NSTransformerDemo
//
//  Created by zhaojw on 11/25/15.
//  Copyright © 2015 zhaojw. All rights reserved.
//

#import "P2DValueTransformer.h"
#import "Person.h"
@implementation P2DValueTransformer

+ (void) initialize
{
    P2DValueTransformer *fToCTransformer = [[self alloc]init];
    [NSValueTransformer setValueTransformer:fToCTransformer
                                    forName:@"FahrenheitToCelsiusTransformer"];

}

+ (Class)transformedValueClass
{
    return [NSString class];
}

+ (BOOL)allowsReverseTransformation
{
    return NO;

}

- (id)transformedValue:(id)value
{
    Person *p = value;
    
    return p.name;
}


@end
