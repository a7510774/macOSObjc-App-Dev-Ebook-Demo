//
//  CollectionViewItem.m
//  NSCollectionCodeView
//
//  Created by zhaojw on 15/8/28.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import "CollectionViewItem.h"

@interface CollectionViewItem ()

@property (weak) IBOutlet NSImageView *collImageView;
@property (weak) IBOutlet NSTextField *titleField;

@end

@implementation CollectionViewItem

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    if(!self.representedObject){
        return;
    }
    
    self.collImageView.image = [self.representedObject objectForKey:@"image"];
    
    self.titleField.stringValue = [self.representedObject objectForKey:@"title"];
    
}

@end
