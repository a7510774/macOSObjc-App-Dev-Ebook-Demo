//
//  ViewController.m
//  BindTreeObject
//
//  Created by iDevFans on 2016/11/4.
//  Copyright © 2016年 macdev. All rights reserved.
//

#import "ViewController.h"
#import "TreeController.h"
@interface ViewController ()
@property (strong) IBOutlet TreeController *treeController;
@property(nonatomic,strong) NSMutableArray   *treeNodes;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configData];
}

- (void)configData{
    NSMutableDictionary *mNode = [self.treeController newObject];
    
    self.treeNodes = [NSMutableArray array];
    [self.treeNodes addObject:mNode];
    
    NSDictionary *options = @{ NSAllowsEditingMultipleValuesSelectionBindingOption:@YES };
    [self.treeController bind:@"contentArray"
                     toObject:self
                  withKeyPath:@"treeNodes"
                      options:options];
}

@end
