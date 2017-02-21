//
//  AppDelegate.m
//  NSPageControllerDemo
//
//  Created by zhaojw on 15/9/16.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import "AppDelegate.h"
#import "TextViewController.h"
#import "ImageViewController.h"

//定义2种不同的view controller的identifier
#define  kImageType    @"image"
#define  kTextType     @"text"

@interface AppDelegate ()<NSPageControllerDelegate>
@property (weak) IBOutlet  NSWindow *window;
@property (weak) IBOutlet  NSView *pageView;
@property(nonatomic,strong)NSPageController *pageController;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
   
    //设置pageController的view视图
    self.pageController.view = self.pageView;
    
    NSArray *datas = @[
                       @{@"fileName":@"1.png",@"type":@"image"  },
                       @{ @"fileName":@"5.txt",@"type":@"text"   },

                       @{ @"fileName":@"3.png",@"type":@"image"   },
                       @{ @"fileName":@"4.txt",@"type":@"text"   },
                                             @{@"fileName":@"2.png",@"type":@"image"    },
                       @{ @"fileName":@"6.txt",@"type":@"text"   },
                       
                       ];
    
    [self.pageController setTransitionStyle:NSPageControllerTransitionStyleStackBook];
    self.pageController.arrangedObjects = datas;
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    
    return YES;
}


- (IBAction)preAction:(id)sender
{
    [self.pageController navigateBack:sender];
}


- (IBAction)nextAction:(id)sender
{
     [self.pageController navigateForward:sender];
}

- (NSPageController*)pageController
{
    if(!_pageController){
        _pageController = [[NSPageController alloc]init];
        _pageController.delegate = self;
    }
    return _pageController;
}

#pragma mark- NSPageControllerDelegate


- (NSString *)pageController:(NSPageController *)pageController identifierForObject:(id)object;
{
    NSDictionary *fileData = object;
    
    NSString *type = fileData[@"type"];
    
    return type;

}


- (NSViewController *)pageController:(NSPageController *)pageController viewControllerForIdentifier:(NSString *)identifier;
{
    if(!identifier){
        return nil;
    }
    if([identifier isEqualToString:kImageType]) {
        ImageViewController *imageViewController = [[ImageViewController alloc]init];
        
        return imageViewController;
    }
    TextViewController *textViewController = [[TextViewController alloc]init];
    
    return textViewController;
}


- (NSRect)pageController:(NSPageController *)pageController frameForObject:(id)object;
{
    return NSInsetRect(pageController.view.bounds, 10, 10);
}


- (void)pageController:(NSPageController *)pageController prepareViewController:(NSViewController *)viewController withObject:(id)object;
{
    
    if(!object){
        return;
    }
    NSDictionary *fileData = object;
    
    NSString *fileName = fileData[@"fileName"];
    
    NSString *identifier = fileData[@"type"];
    
    if([identifier isEqualToString:kImageType]) {
        
        ImageViewController *imageViewController = (ImageViewController*)viewController;
        
        [imageViewController updataViewWithFileName:fileName];
    }
    else{
        
        TextViewController *textViewController = (TextViewController*)viewController;
        
        [textViewController updataViewWithFileName:fileName];
    }
    
}


- (void)pageControllerDidEndLiveTransition:(NSPageController *)pageController;
{
    [pageController completeTransition];
}


@end
