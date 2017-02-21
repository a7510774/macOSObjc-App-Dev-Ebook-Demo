//
//  DynamicHeightColumnsViewController.m
//  AutoLayout
//
//  Created by zhaojw on 1/5/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//

#import "DynamicHeightColumnsViewController.h"

@interface DynamicHeightColumnsViewController ()
@property (weak) IBOutlet NSTextField *firstLabel;
@property (weak) IBOutlet NSTextField *middleLabel;
@property (weak) IBOutlet NSTextField *lastLabel;
@property(nonatomic,assign)BOOL isLargeFont;
@property(nonatomic,strong)NSTimer *timer;
@end

@implementation DynamicHeightColumnsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    self.firstLabel.font = font;
    self.middleLabel.font = font;
    self.lastLabel.font = font;
    //self.isLargeFont = ~self.isLargeFont;
}



- (void)dealloc {
    [_timer invalidate];
    _timer = nil;
}

@end
