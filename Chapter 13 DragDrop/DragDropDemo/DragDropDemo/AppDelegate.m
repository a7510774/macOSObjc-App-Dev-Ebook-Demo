//
//  AppDelegate.m
//  DragDropDemo
//
//  Created by zhaojw on 15/10/20.
//  Copyright (c) 2015年 zhaojw. All rights reserved.
//

#import "AppDelegate.h"
#import "DragSourceView.h"
#import "DragDestinationView.h"
#import "DragOutlineWindowController.h"
@interface AppDelegate ()<NSDraggingSource>

@property (weak) IBOutlet DragSourceView *sourceView;

@property (weak) IBOutlet DragDestinationView *destinationView;

@property (weak) IBOutlet NSWindow *window;

@property(nonatomic,strong)DragOutlineWindowController *dragOutlineWindowController;

@end

@implementation AppDelegate

- (BOOL)application:(NSApplication *)sender openFile:(NSString *)filename {
    
    NSLog(@"filename %@",filename);
    
    return YES;
}
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    
    [self showOutlineViewWindow:nil];
    
    //return;
    
    self.sourceView.dragSourceDelegate = self;
    
    self.destinationView.wantsLayer = YES;
    self.destinationView.layer.borderColor = [NSColor blueColor].CGColor;
    self.destinationView.layer.borderWidth = 1;
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

#pragma mark-- Action

- (IBAction)showOutlineViewWindow:(id) sender{
    [self.dragOutlineWindowController showWindow:self];
}


#pragma mark-- NSDraggingSource Protocol

- (NSDragOperation)draggingSession:(NSDraggingSession *)session sourceOperationMaskForDraggingContext:(NSDraggingContext)context {
    return NSDragOperationGeneric;
}


- (void)draggingSession:(NSDraggingSession *)session willBeginAtPoint:(NSPoint)screenPoint {
    
    NSLog(@"draggingSession Begin screenPoint %@",NSStringFromPoint(screenPoint));
    
}
- (void)draggingSession:(NSDraggingSession *)session movedToPoint:(NSPoint)screenPoint {
    
     NSLog(@"draggingSession Move screenPoint %@",NSStringFromPoint(screenPoint));
    
}
- (void)draggingSession:(NSDraggingSession *)session endedAtPoint:(NSPoint)screenPoint operation:(NSDragOperation)operation {
    
     NSLog(@"draggingSession End screenPoint %@",NSStringFromPoint(screenPoint));
}


- (DragOutlineWindowController*)dragOutlineWindowController {
    if(!_dragOutlineWindowController) {
        _dragOutlineWindowController = [[DragOutlineWindowController alloc]init];
    }
    return _dragOutlineWindowController;
}

@end
