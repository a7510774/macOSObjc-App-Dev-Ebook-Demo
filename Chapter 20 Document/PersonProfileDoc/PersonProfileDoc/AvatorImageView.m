//
//  AvatorImageView.m
//  PersonProfileDoc
//
//  Created by zhaojw on 12/17/15.
//  Copyright © 2015 zhaojw. All rights reserved.
//

#import "AvatorImageView.h"

@implementation AvatorImageView


- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (void)mouseDown:(NSEvent *)theEvent {
    
    if(theEvent.clickCount >= 2){
    
        if(self.delegate && [self.delegate respondsToSelector:@selector(didRequestUploadAvator:)]){
            [self.delegate didRequestUploadAvator:self];
        }
        
    }
 
}


//- (NSDictionary *)infoForBinding:(NSString *)bindingName {
//
//    NSDictionary *info = bindingInfo[bindingName];
//    if (info == nil) {
//        info = [super infoForBinding:bindingName];
//    }
//    return info;
//}
//
//
//- (void)bind2:(NSString *)bindingName toObject:(id)observableController withKeyPath:(NSString *)keyPath options:(NSDictionary *)options {
//
//    
//    if ([bindingName isEqualToString:@"value"]) {
//    
//        if ([bindingInfo objectForKey:@"value"] != nil) {
//        
//            [self unbind:@"value"];
//        }
//        
//        if(!bindingInfo){
//           bindingInfo = [[NSMutableDictionary alloc] init];
//        }
//        
//        NSDictionary *bindingsData = @{ NSObservedObjectKey:observableController, NSObservedKeyPathKey:[keyPath copy] };
//        [bindingInfo setObject:bindingsData forKey:@"value"];
//        
//        
//        [super bind:bindingName toObject:observableController withKeyPath:keyPath options:options];
//    }
//    else{
//        [super bind:bindingName toObject:observableController withKeyPath:keyPath options:options];
//    }
//    
//}


@end
