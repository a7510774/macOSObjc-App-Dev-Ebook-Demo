//
//  AppDelegate.m
//  EventDemo
//
//  Created by zhaojw on 15/10/13.
//  Copyright © 2015年 zhaojw. All rights reserved.
//

#import "AppDelegate.h"
#import "NSViewX.h"
@interface AppDelegate ()
@property (weak) IBOutlet NSViewX *view;


@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = [NSColor redColor].CGColor;
    
    NSResponder *ff;
    
    NSWindow *hh;
    
    NSResponder *d;
    
    NSEvent *ee;
    
    
    NSButton *dgdg;
    
    
    dgdg.target = self;
    
    
   // NSApp *app;
    
    NSEvent *add;
    
    
    BOOL (^test)(id obj, NSUInteger idx, BOOL *stop );
    
    test = ^(id obj, NSUInteger idx, BOOL *stop ){
        return YES;
    };
    
    int x = 123;
    void (^printXandY)(int) = ^(int y) {
        printf("%d %d\n", x, y);
    };
    
    
    
    
    NSEvent* (^handler) (NSEvent* event);
    
    handler =  ^  (NSEvent *theEvent) {
        
        return theEvent;
        
    };
    
    id eventMonitor = [NSEvent addLocalMonitorForEventsMatchingMask:NSKeyDownMask handler: ^  (NSEvent *theEvent) {
        
        return theEvent;
        
    }
];
    
    
    self.view.target =self;
    
    self.view.action = @selector(btnClicked:);
    
   // self.view setact
    
    
}

- (IBAction)btnClicked:(id)sender {
    
    NSLog(@"btnClicked");
    
}



- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
