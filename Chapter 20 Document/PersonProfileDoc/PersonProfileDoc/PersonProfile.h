//
//  PersonProfile.h
//  PersonProfileDoc
//
//  Created by zhaojw on 12/15/15.
//  Copyright © 2015 zhaojw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonProfile : NSObject
@property(nonatomic,copy)NSString    *name;
@property(nonatomic,assign)NSInteger age;
@property(nonatomic,copy)NSString    *address;
@property(nonatomic,copy)NSString    *mobile;
@property(nonatomic,strong)NSImage   *image;
- (NSData*)docData;//Archive instance 
+ (instancetype)profileFromData:(NSData *)data;//instantiate class from unarchivered data
@end
