//
//  AppDelegate.m
//  XPCDemo
//
//  Created by zhaojw on 11/20/15.
//  Copyright © 2015 zhaojw. All rights reserved.
//

#import "AppDelegate.h"
#import "HelperProtocol.h"

@interface AppDelegate  ()
@property (weak) IBOutlet NSWindow *window;
@property(nonatomic,strong)NSXPCConnection *connectionToService;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
  
    
}

- (void)returnnCaseString:(NSString *)aString {
    NSLog(@"returnnCaseString %@",aString);
}
- (IBAction)connect:(id)sender {
  
    _connectionToService = [[NSXPCConnection alloc] initWithServiceName:@"com.cocoahunt.Helper"];
    
    _connectionToService.remoteObjectInterface = [NSXPCInterface interfaceWithProtocol:@protocol(HelperProtocol)];
    

    _connectionToService.exportedInterface = [NSXPCInterface interfaceWithProtocol:@protocol(HelperLogProtocol)];
    
    _connectionToService.exportedObject = self;
    
    
    [_connectionToService resume];
    
    
    [[_connectionToService remoteObjectProxy] upperCaseString:@"hellos" withReply:^(NSString *aString) {
        // We have received a response. Update our text field, but do it on the main thread.
        
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            NSLog(@"Result string was: %@", aString);
            
        }];
        // We're done with the connection at this point, so we should invalidate it.
        //[_connectionToService invalidate];
        
    }];
    
}
- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
