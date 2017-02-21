//
//  DynamicHeightLabelViewController.m/Users/zhaojw/Documents/CocoaDemo/AutoLayout/AutoLayout/DynamicHeightLabelViewController.m
//  AutoLayout
//
//  Created by zhaojw on 1/5/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//

#import "DynamicHeightLabelViewController.h"

@interface DynamicHeightLabelViewController ()
@property (weak) IBOutlet NSTextField *textLabel;
@property(nonatomic,assign)BOOL isLargeFont;
@property(nonatomic,strong)NSTimer *timer;
@end

@implementation DynamicHeightLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.wantsLayer = YES;
    //self.view.layer.backgroundColor = [NSColor redColor].CGColor;
    // Do view setup here.
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(changeFont:) userInfo:nil repeats:YES];
    NSLog(@"self.timer %@",self.timer);
   //[self.timer fire];
}

- (IBAction)changeFont:(id)sender {
    NSFont *font = [NSFont systemFontOfSize:12];
    if(!self.isLargeFont){
        font = [NSFont systemFontOfSize:40];
    }
    self.textLabel.font = font;
    //self.isLargeFont = ~self.isLargeFont;
    
    
   
}



- (void)dealloc {
    [_timer invalidate];
    _timer = nil;
}

@end
