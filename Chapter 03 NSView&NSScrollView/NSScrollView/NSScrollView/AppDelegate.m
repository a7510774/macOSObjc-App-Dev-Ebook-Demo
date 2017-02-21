//
//  AppDelegate.m
//  NSScrollView
//
//  Created by iDevFans on 16/6/22.
//  Copyright © 2016年 http://www.macdev.io. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;

@property (weak) IBOutlet NSScrollView *scrollView;
@property (weak) IBOutlet NSClipView *clipView;
@property (unsafe_unretained) IBOutlet NSTextView *textView;


@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    [self addScrollView];
 
}

- (void)addScrollView{
    
    CGRect scrollViewFrame = CGRectMake(0, 0, 200, 200);
    NSScrollView *scrollView =  [[NSScrollView alloc]initWithFrame:scrollViewFrame];
    NSImage *image =  [NSImage imageNamed:@"screen.png"];
    
    NSImageView *imageView = [[NSImageView alloc]initWithFrame:scrollView.bounds];
    [imageView setFrameSize:image.size];
    imageView.image = image;
    
    scrollView.hasVerticalScroller = YES;
    scrollView.hasHorizontalScroller = YES;
    scrollView.documentView = imageView;
    
    [self.window.contentView addSubview:scrollView];
    
    
    NSClipView *contentView  = scrollView.contentView;
    NSPoint newScrollOrigin;
    if(self.window.contentView.isFlipped){
        newScrollOrigin = NSMakePoint(0.0,0.0);
    }
    else{
        newScrollOrigin = NSMakePoint(0.0,imageView.frame.size.height-contentView.frame.size.height);
    }
    [contentView scrollPoint:newScrollOrigin];

}


- (IBAction)scrollToRightClick:(id)sender {
    
    CGRect frame = self.scrollView.bounds;
    
    frame.origin.x = frame.origin.x -10;
    
    self.scrollView.bounds = frame;
}

- (IBAction)clipBoundsClick:(id)sender {
    
    CGRect frame = self.clipView.bounds;
    
    frame.origin.y = frame.origin.y -10;
    
    self.clipView.bounds = frame;

    NSLog(@"clipBoundsClick %@ ",  NSStringFromRect(frame));
    
}

- (IBAction)textBoundsClick:(id)sender {
    CGRect frame = self.textView.bounds;
    frame.origin.x = frame.origin.x -10;
    self.textView.bounds = frame;
}


@end
