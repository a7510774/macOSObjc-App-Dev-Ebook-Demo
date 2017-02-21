//
//  NSUndoWindowController.m
//  NSUndoManagerDemo
//
//  Created by zhaojw on 15/10/18.
//  Copyright © 2015年 zhaojw. All rights reserved.
//

#import "NSUndoWindowController.h"

@interface NSUndoWindowController ()

@property (weak) IBOutlet NSTextField *firstAddParaTextField;
@property (weak) IBOutlet NSTextField *secondAddParaTextField;
@property (weak) IBOutlet NSTextField *sumTextField;

@property(nonatomic,assign)NSInteger para1;
@property(nonatomic,assign)NSInteger para2;

@property (nonatomic,strong)NSUndoManager *undoManager;
@end

@implementation NSUndoWindowController

- (NSString*)windowNibName {
    return @"NSUndoWindowController";
}


- (void)windowDidLoad {
    [super windowDidLoad];
    self.para1 = 1;
    self.para2 = 2;
    [self computePara1:1 para2:2];
}


- (IBAction)computeAction:(id)sender {
    
    NSString *firstAddParaText = self.firstAddParaTextField.stringValue;
    NSString *secondAddParaText = self.secondAddParaTextField.stringValue;
    NSInteger para1 = [firstAddParaText integerValue];
    NSInteger para2 = [secondAddParaText integerValue];
   
    [self computePara1:para1 para2:para2];
  
}

-(void)computePara1:(NSInteger)para1 para2:(NSInteger)para2 {
    
    if(self.para1 == para1 && self.para2 == para2){
        
    }
    else{
        //注册Undo操作
        [[self.undoManager prepareWithInvocationTarget:self]computePara1:self.para1  para2:self.para2 ];
        
        NSString *title = [NSString stringWithFormat:@"%ld+%ld",self.para1,self.para2];
        [self.undoManager setActionName:title];
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


- (IBAction)undoAction:(id)sender {
    [self.undoManager undo];
}

- (IBAction)redoAction:(id)sender {
    [self.undoManager redo];
}


- (NSUndoManager*)undoManager {
    if(!_undoManager){
        _undoManager = self.window.undoManager;
    }
    return _undoManager;
}


@end
