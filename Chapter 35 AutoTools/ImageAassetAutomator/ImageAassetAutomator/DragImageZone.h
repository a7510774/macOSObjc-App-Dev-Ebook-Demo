//
//  DragImageZone.h
//  ImageAassetAutomator
//
//  Created by zhaojw on 15/9/12.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@protocol DragImageZoneDelegate <NSObject>
@optional
- (void)didFinishDragWithFile:(NSString*)filePath;
@end;

@interface DragImageZone : NSImageView<NSDraggingDestination>
@property(weak) id<DragImageZoneDelegate> delegate;
@end
