//
//  CDMainWindowController.m
//  CocoaDrawDemo
//
//  Created by zhaojw on 2/24/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//

#import "CDMainWindowController.h"
#import "CDDrawView.h"
#import "CDColorView.h"
#import "GradientView.h"
#import "ContentStateView1.h"
#import "ContentStateView2.h"
@interface CDMainWindowController ()
@property (unsafe_unretained) IBOutlet NSTextView *textView;
@property (nonatomic,strong)CDColorView *colorView;;
@property (weak) IBOutlet ContentStateView1 *stateView1;
@property (weak) IBOutlet ContentStateView2 *stateView2;


@end

@implementation CDMainWindowController

- (void)windowDidLoad {
    
    [super windowDidLoad];
    [self.window center];
    
    CGRect frame1 = NSMakeRect(0, 0, 300, 300);
    
    CDDrawView *view = [[CDDrawView alloc]initWithFrame:frame1];
    
    //[self.window.contentView addSubview:view];
    
    
    CGRect frame2 = NSMakeRect(30, 30, 150, 150);
    
    CDColorView *colorView = [[CDColorView alloc]initWithFrame:frame2];
    //self.colorView = colorView;
    //[self.window.contentView addSubview:colorView];
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    
    
    GradientView *gradientView = [[GradientView alloc]initWithFrame:frame2];
    
    [self.window.contentView addSubview:gradientView];
    
   
    
    //Draw things here.
   
}


- (IBAction)colorAction:(id)sender {
    
    NSColorWell *well = sender;
    
    NSLog(@"well color %@ ",well.color);
}


- (IBAction)changeColorButtonAction:(id)sender {
    
    NSColorPanel *panel = [NSColorPanel sharedColorPanel];
    
    [panel setTarget:self];
    
    [panel setAction:@selector(colorSelect:)];
    
    [panel orderFront:self];
}

- (IBAction)colorSelect:(id)sender {
    
    NSColorPanel *panel = sender;
    
    NSLog(@"colorSelect color %@ ",panel.color);
    
    self.textView.textColor = panel.color;
    
}

- (IBAction)saveImageAction:(id)sender {
   // [self saveImage];
    
    [self.colorView saveImage];
}
- (void)saveImage {
    NSView *view = self.window.contentView;
    NSRect r = [view frame];
    NSData* dataq = [view dataWithPDFInsideRect:r];
    NSPDFImageRep *img = [NSPDFImageRep imageRepWithData:dataq];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSInteger count = [img pageCount];
   
    for(NSInteger i = 0 ; i < count ; i++) {
        NSString *filePath = [NSString stringWithFormat:@"/Users/zhaojw/Documents/file%ld.png",i];
        [img setCurrentPage:i];
        NSImage *temp = [[NSImage alloc] init];
        [temp addRepresentation:img];
        NSBitmapImageRep *rep = [NSBitmapImageRep imageRepWithData:[temp TIFFRepresentation]];
        NSData *finalData = [rep representationUsingType:NSPNGFileType properties:nil];
        [fileManager createFileAtPath:filePath contents:finalData attributes:nil];
    }
}


- (IBAction)updateDrawAction:(id)sender {
    
    [self.stateView1 setNeedsDisplay:YES];
    
     [self.stateView2 setNeedsDisplay:YES];
    
    
}


@end
