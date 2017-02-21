//
//  DragExportButton.h
//  ImageAassetAutomator
//
//  Created by zhaojw on 15/9/12.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol DragExportButtonDelegate <NSObject>
@optional
- (void)didFinishDragWithExportPath:(NSString*)filePath;
@end;

@interface DragExportButton : NSButton<NSDraggingDestination>
@property(weak) id<DragExportButtonDelegate> delegate;
@end
