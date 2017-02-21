//
//  AppDelegate.m
//  AutoLayout
//
//  Created by zhaojw on 1/4/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//

#import "AppDelegate.h"
#import "LabelTextFieldViewController.h"
#import "DynamicHeightLabelViewController.h"
#import "FixedHeightColumnsViewController.h"
#import "DynamicHeightColumnsViewController.h"
#import "TwoEqualWidthButtonsViewController.h"
#import "ThreeEqualWidthButtonsViewController.h"
#import "TwoButtonswithEqualSpacingViewController.h"
#import "TwoButtonsSizeClassBasedLayoutsViewController.h"
#import "ImageScrollViewController.h"
#import "SimpleStackViewController.h"
#import "SimpleViewController.h"
#import "GeneralFrameViewController.h"
#import "NestedStackViewController.h"

@interface AppDelegate ()
@property (weak) IBOutlet NSView *contentView;
@property (weak) IBOutlet NSView *view;
@property (weak) IBOutlet NSWindow   *window;
@property(nonatomic,strong)NSArray   *controllers;
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,strong)NSView    *currentView;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
 
    [self.window center];
    
    [self changeView];
    
  //  self.window.contentViewController = self.controllers[self.index];
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (void)changeView {
    
    [self.currentView removeFromSuperview];
    NSViewController *vc = self.controllers[self.index];
    self.currentView = vc.view;
    [self.contentView addSubview:self.currentView];
    
    [self.contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.currentView setTranslatesAutoresizingMaskIntoConstraints:NO];

    
    
    NSLayoutConstraint *viewTop = [NSLayoutConstraint constraintWithItem:self.currentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    
 
    NSLayoutConstraint *viewBottom = [NSLayoutConstraint constraintWithItem:self.currentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    

    NSLayoutConstraint *viewLeading = [NSLayoutConstraint constraintWithItem:self.currentView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
    

    NSLayoutConstraint *viewTrailing = [NSLayoutConstraint constraintWithItem:self.currentView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0];
    
    [self.contentView addConstraint:viewTop];
    [self.contentView addConstraint:viewBottom];
    [self.contentView addConstraint:viewLeading];
    [self.contentView addConstraint:viewTrailing];
    
    
   // self.currentView.frame = self.contentView.bounds;
}

- (void)addSubView {
    
    NSView *currentView = [[NSView alloc]init];
    [self.contentView addSubview:currentView];
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    
    NSLayoutConstraint *viewTop = [NSLayoutConstraint constraintWithItem:currentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    
    
    NSLayoutConstraint *viewBottom = [NSLayoutConstraint constraintWithItem:currentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    
    
    NSLayoutConstraint *viewLeading = [NSLayoutConstraint constraintWithItem:currentView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
    
    
    NSLayoutConstraint *viewTrailing = [NSLayoutConstraint constraintWithItem:currentView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0];
    
    [self.view addConstraint:viewTop];
    [self.view addConstraint:viewBottom];
    [self.view addConstraint:viewLeading];
    [self.view addConstraint:viewTrailing];
    
    
    [self.view.topAnchor constraintEqualToAnchor:currentView.bottomAnchor constant:10].active=YES;
    

}

#pragma mark- Button Action

- (IBAction)previosAction:(id)sender {
    
    if(self.index-1 >= 0){
        self.index--;
       [self changeView];
    }
}

- (IBAction)nextAction:(id)sender {
    NSInteger count = self.controllers.count;
    if(self.index+1 <= count-1){
        self.index++;
       [self changeView];
    }
}

- (NSArray*)controllers{
    if(!_controllers){
        _controllers = @[
                         
                         [[SimpleViewController alloc]init],
                         [[LabelTextFieldViewController alloc]init],
                         [[DynamicHeightLabelViewController alloc]init],
                         [[FixedHeightColumnsViewController alloc]init],
                         [[DynamicHeightColumnsViewController alloc]init],
                         [[TwoEqualWidthButtonsViewController alloc]init],
                         [[ThreeEqualWidthButtonsViewController alloc]init],
                         [[TwoButtonswithEqualSpacingViewController alloc]init],
                         [[TwoButtonsSizeClassBasedLayoutsViewController alloc]init],
                         [[ImageScrollViewController alloc]init],
                         [[SimpleStackViewController alloc]init],
                         
                          [[GeneralFrameViewController alloc]init],
                       
                         [[NestedStackViewController alloc]init]
                         
                        ];
    }
    return _controllers;
}
@end
