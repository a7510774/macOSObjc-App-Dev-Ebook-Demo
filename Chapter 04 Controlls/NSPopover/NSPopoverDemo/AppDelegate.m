//
//  AppDelegate.m
//  NSPopoverDemo
//
//  Created by zhaojw on 15/9/18.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import "AppDelegate.h"
#import "ShareViewController.h"
#import "FeedbackViewController.h"
@interface AppDelegate ()
@property (weak) IBOutlet NSWindow *window;
@property(nonatomic,strong)NSPopover *sharePopover;
@property(nonatomic,strong)NSPopover *feedBackPopover;
@property(nonatomic,strong)ShareViewController *shareViewController;
@property(nonatomic,strong)FeedbackViewController *feedbackViewController;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}



- (IBAction)sharePopover:(id)sender
{
    NSButton *button = sender;
    //显示在button 下面
    [self.sharePopover showRelativeToRect:[button bounds] ofView:button preferredEdge:NSRectEdgeMaxY];
}


- (IBAction)feedbackAction:(id)sender
{
    NSButton *button = sender;
     //显示在button 上面
    [self.feedBackPopover showRelativeToRect:[button bounds] ofView:button preferredEdge:NSRectEdgeMinY];
}


- (NSPopover*)sharePopover
{
    if(!_sharePopover){
        _sharePopover = [[NSPopover alloc]init];
        _sharePopover.contentViewController = self.shareViewController;
         _sharePopover.behavior = NSPopoverBehaviorTransient;
       //_sharePopover.appearance = NSPopoverAppearanceHUD;
        
    }
    return _sharePopover;
}

- (NSPopover*)feedBackPopover
{
    if(!_feedBackPopover){
        _feedBackPopover = [[NSPopover alloc]init];
        _feedBackPopover.contentViewController = self.feedbackViewController;
        _feedBackPopover.behavior = NSPopoverBehaviorSemitransient;
  
    }
    
    return _feedBackPopover;
}


- (ShareViewController*)shareViewController
{
    if(!_shareViewController){
        _shareViewController = [[ShareViewController alloc]init];
    }
    return _shareViewController;
}


- (FeedbackViewController*)feedbackViewController
{
    if(!_feedbackViewController){
        _feedbackViewController = [[FeedbackViewController alloc]init];
    }
    return _feedbackViewController;
}

@end
