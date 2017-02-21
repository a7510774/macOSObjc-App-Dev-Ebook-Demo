//
//  AppDelegate.m
//  NSUndoManagerDemo
//
//  Created by zhaojw on 15/10/17.
//  Copyright © 2015年 zhaojw. All rights reserved.
//

#import "AppDelegate.h"
#import "NSUndoWindowController.h"
@interface AppDelegate ()
{
    NSUndoManager *_undoManager;
}

@property (weak) IBOutlet NSWindow *window;

@property (weak) IBOutlet NSTextField *firstAddParaTextField;
@property (weak) IBOutlet NSTextField *secondAddParaTextField;
@property (weak) IBOutlet NSTextField *sumTextField;

@property(nonatomic,assign)NSInteger para1;
@property(nonatomic,assign)NSInteger para2;


@property(nonatomic,strong)NSUndoWindowController *undoWindowController;

@end

@implementation AppDelegate


- (void)sendEvent:(NSEvent *)theEvent {
    NSLog(@"sendEvent %@",theEvent);
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    
   self.para1 = 1;
    
   self.para2 = 2;
    
   
    
    NSDocument *gg;
   [self compute:1 para2:2];
    
    
   // self.undoManager.groupsByEvent = NO;
    
    //[self.undoManager beginUndoGrouping];
   //[self.undoManager beginUndoGrouping];
   
    
    [[NSNotificationCenter defaultCenter] addObserverForName:NSUndoManagerCheckpointNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification* note){
        
        if(note.object==self.undoManager){
             NSLog(@"NSUndoManagerCheckpointNotification");
        }
        else{
             NSLog(@"NSUndoManagerCheckpointNotification %@",note.object);
        }
       

        
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:NSUndoManagerWillUndoChangeNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification* note){
        
        if(note.object==self.undoManager){
           NSLog(@"NSUndoManagerWillUndoChangeNotification ");
        }
        else{
            NSLog(@"NSUndoManagerWillUndoChangeNotification %@",note.object);
        }
        
    }];
    
    
    [[NSNotificationCenter defaultCenter] addObserverForName:NSUndoManagerWillRedoChangeNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification* note){
        
        if(note.object==self.undoManager){
        NSLog(@"NSUndoManagerWillRedoChangeNotification");
        }
        else{
           NSLog(@"NSUndoManagerWillRedoChangeNotification %@",note.object);
        }
        
        
    }];
    
    
    [[NSNotificationCenter defaultCenter] addObserverForName:NSUndoManagerDidUndoChangeNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification* note){
        
        if(note.object==self.undoManager){
           NSLog(@"NSUndoManagerDidUndoChangeNotification");
        }
        else {
             NSLog(@"NSUndoManagerDidUndoChangeNotification %@",note.object);
        }

        
    }];
    
    
    [[NSNotificationCenter defaultCenter] addObserverForName:NSUndoManagerDidRedoChangeNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification* note){
        
        if(note.object==self.undoManager){
           NSLog(@"NSUndoManagerDidRedoChangeNotification");
        } else {
           NSLog(@"NSUndoManagerDidRedoChangeNotification %@",note.object);
        }

        
    }];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserverForName:NSUndoManagerDidOpenUndoGroupNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification* note){
        
        if(note.object==self.undoManager){
           NSLog(@"NSUndoManagerDidOpenUndoGroupNotification");
        }
        else {
              NSLog(@"NSUndoManagerDidOpenUndoGroupNotification %@",note.object);
        }

        
    }];

    
    
    [[NSNotificationCenter defaultCenter] addObserverForName:NSUndoManagerWillCloseUndoGroupNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification* note){
        
        if(note.object==self.undoManager){
        NSLog(@"NSUndoManagerWillCloseUndoGroupNotification");

        }
        
        else {
            NSLog(@"NSUndoManagerWillCloseUndoGroupNotification %@",note.object);
        }
    }];

    
    
    [[NSNotificationCenter defaultCenter] addObserverForName:NSUndoManagerDidCloseUndoGroupNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification* note){
        
        if(note.object==self.undoManager){
        NSLog(@"NSUndoManagerDidCloseUndoGroupNotification");

        }
        else {
             NSLog(@"NSUndoManagerDidCloseUndoGroupNotification %@",note.object);
        }
        
    }];

    
    
    
}



- (IBAction)showWindowAction:(id)sender {
    
    
    [self.undoWindowController showWindow:self];
    
}

- (IBAction)computeAction:(id)sender {
    
    
    
    NSString *firstAddParaText = self.firstAddParaTextField.stringValue;
    
    NSString *secondAddParaText = self.secondAddParaTextField.stringValue;
    
    NSInteger para1 = [firstAddParaText integerValue];
    
    NSInteger para2 = [secondAddParaText integerValue];
    
    BOOL isNeedGroup = YES;
    if(self.para1 == para1 && self.para2 == para2){
        isNeedGroup =NO;
    }
    
    if(!self.undoManager.groupsByEvent){
        isNeedGroup = YES;
    }
    
    if(isNeedGroup){
        [self.undoManager beginUndoGrouping];
    }
   
    
    [self compute:para1 para2:para2];
    
    if(isNeedGroup){
        [self.undoManager endUndoGrouping ];
    }
  
    
}


- (void)compute:(NSInteger)para1 para2:(NSInteger)para2 {
    
    
    if(self.para1 == para1 && self.para2 == para2){
        
    }
    else{
        
        
       
         NSUndoManager* undoManager = [self undoManager];
        
        
        [[undoManager prepareWithInvocationTarget:self]compute:self.para1  para2:self.para2 ];
        
        NSString *title = [NSString stringWithFormat:@"%ld+%ld",self.para1,self.para2];
        
        [undoManager setActionName:title];
        
        
        
        
       //[self.window.undoManager endUndoGrouping];
        
    }
    
    
    self.para1 = para1;
    self.para2 = para2;
    
    NSString *firstAddPara  = [NSString stringWithFormat:@"%ld",self.para1];

    
    NSString *secondAddPara  = [NSString stringWithFormat:@"%ld",self.para2];
    
    NSInteger sum = para1 + para2;
    
    
    self.firstAddParaTextField.stringValue  =  firstAddPara;
    
    self.secondAddParaTextField.stringValue =  secondAddPara;
    
    self.sumTextField.stringValue = [NSString stringWithFormat:@"%ld",sum];
    
    
}

- (IBAction)groupEventEnableAction:(id)sender {
    
    [self undoManager].groupsByEvent = ![self undoManager].groupsByEvent;
    
}


- (IBAction)undoAction:(id)sender {
    
      NSUndoManager* undoManager = [self undoManager];
    
    [undoManager undoNestedGroup];
    
   // [self.undoManager canUndo];
}

- (IBAction)redoAction:(id)sender {
    
      NSUndoManager* undoManager = [self undoManager];
    
    [undoManager redo];
    
}





- (IBAction)endgroupAction:(id)sender {
    
    [self.undoManager endUndoGrouping ];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (NSUndoManager*)undoManager
{
    if(!_undoManager){
        _undoManager = self.window.undoManager      ;//[[NSUndoManager alloc]init];
    }
    return _undoManager;
}

- (NSUndoWindowController*)undoWindowController
{
    if(!_undoWindowController){
        _undoWindowController = [[NSUndoWindowController alloc]init];
    }
    return _undoWindowController;
}
@end
