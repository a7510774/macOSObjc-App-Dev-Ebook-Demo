//
//  AppDelegate.m
//  NSCollectionView
//
//  Created by zhaojw on 15/8/28.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()<NSCollectionViewDelegate>
@property (weak) IBOutlet NSCollectionView *collectionView;
@property (weak) IBOutlet NSWindow *window;
@property(nonatomic,strong)NSArray *content;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
   
    NSImage *computerimage = [NSImage imageNamed:NSImageNameComputer];
    
    NSImage *folderimage = [NSImage imageNamed:NSImageNameFolder];
    
    NSImage *homeimage = [NSImage imageNamed:NSImageNameHomeTemplate];
    
    NSImage *listimage = [NSImage imageNamed:NSImageNameListViewTemplate];
    
    NSImage *networkimage = [NSImage imageNamed:NSImageNameNetwork];
    
    NSImage *shareimage = [NSImage imageNamed:NSImageNameShareTemplate];
    
    NSDictionary *item1 =@{
                           
                           @"title":@"computer",
                           
                           @"image":computerimage
                           
                           };
    
    
    NSDictionary *item2 =@{
                           
                           @"title":@"folder",
                           
                           @"image":folderimage
                           
                           };
    
    
    NSDictionary *item3 =@{
                           
                           @"title":@"home",
                           
                           @"image":homeimage
                           
                           };
    
    
    NSDictionary *item4 =@{
                           
                           @"title":@"list",
                           
                           @"image":listimage
                           
                           };
    
    
    NSDictionary *item5 =@{
                           
                           @"title":@"network",
                           
                           @"image":networkimage
                           
                           };
    
    
    NSDictionary *item6 =@{
                           
                           @"title":@"share",
                           
                           @"image":shareimage
                           
                           };
    
    
    self.content = @[
                 
                 item1,
                 item2,
                 item3,
                 item4,
                 item5,
                 item6
                 
                 ];
    
    
    self.collectionView.content = self.content;
    
    
    self.collectionView.delegate = self;
    
    
    
    
    
}

- (void)collectionView:(NSCollectionView *)collectionView didSelectItemsAtIndexPaths:(NSSet<NSIndexPath *> *)indexPaths {
    
    NSLog(@"NSCollectionView");
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
