//
//  AvatorImageView.h
//  PersonProfileDoc
//
//  Created by zhaojw on 12/17/15.
//  Copyright © 2015 zhaojw. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>
@class AvatorImageView;
@protocol AvatorUploadDelegate <NSObject>
@optional
- (void)didRequestUploadAvator:(AvatorImageView*)imageView;
@end

@interface AvatorImageView : NSImageView
@property(weak) id<AvatorUploadDelegate>delegate;
@end
