//
//  TestViewController.m
//  NSViewControllerDemo
//
//  Created by zhaojw on 15/9/15.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import "TestViewController.h"

#import "SecondViewController.h"
#import "FirstViewController.h"

@interface TestViewController ()
@property (weak) IBOutlet NSComboBox *comboBox;
@property (weak) IBOutlet NSView *mainView;
@property(nonatomic,strong)NSViewController *currentController;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    NSLog(@"viewDidLoad");
    

    [self initiateControllers];
    
    [self.comboBox selectItemAtIndex:0];
    [self changeViewController:0];
}

- (void)initiateControllers {
   
    NSViewController *vc1 = [[FirstViewController alloc]init];
    NSViewController *vc2 = [[SecondViewController alloc]init];
    
    [self addChildViewController:vc1];
    [self addChildViewController:vc2];
    
}




-(IBAction)selectionChaned:(id)sender {
    NSComboBox *comboBox = sender;
    NSInteger selectedIndex = comboBox.indexOfSelectedItem;
    NSString *selectedContent = comboBox.stringValue;
    NSLog(@"selectedContent %@ at index %ld",selectedContent,selectedIndex);
    [self changeViewController:selectedIndex];
}


-(void)changeViewController:(NSInteger)index {
    [[_currentController view] removeFromSuperview];
    _currentController = [[self childViewControllers]objectAtIndex:index];
    [self.mainView addSubview:[_currentController view]];
    
    [[_currentController view] setFrame:[self.mainView bounds]];
    [[_currentController view] setAutoresizingMask:NSViewWidthSizable|NSViewWidthSizable];
    
}

@end
