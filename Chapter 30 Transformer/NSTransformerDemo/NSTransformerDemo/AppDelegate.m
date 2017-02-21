//
//  AppDelegate.m
//  NSTransformerDemo
//
//  Created by zhaojw on 11/25/15.
//  Copyright © 2015 zhaojw. All rights reserved.
//

#import "AppDelegate.h"
#import "Person.h"
#import "P2DValueTransformer.h"
#import "DataField.h"
#import "TypeMapValueTransformer.h"
@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;

@property(nonatomic,strong)Person *p;

@property(nonatomic,strong)NSValueTransformer *negateBooleanTransformer;

@property(nonatomic,strong)NSValueTransformer *isNilTransformer;

@property(nonatomic,strong)NSValueTransformer *isNotNilTransformer;

@property(nonatomic,strong)NSValueTransformer *unarchiveFromDataTransformer;

@property(nonatomic,strong)NSValueTransformer *keyedUnarchiveFromDataTransformer;

@property(nonatomic,strong)DataField *dateField;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    self.unarchiveFromDataTransformer = [NSValueTransformer valueTransformerForName:@"FahrenheitToCelsiusTransformer"];
    
    
    BOOL isYes = YES;
    
    NSNumber *isRet = [self.negateBooleanTransformer transformedValue:@(isYes)];
    
    NSLog(@"isRet %@", isRet);
    
    NSNumber *isReverseRet = [self.negateBooleanTransformer transformedValue:isRet];
    
    NSLog(@"isReverseRet %@", isReverseRet);
    
    
    Person *p = [[Person alloc]init];
    p.name = @"John";
    p.address = @"Marly";
    
    self.p = p;
    
    
    NSDictionary *pdic = @{
                           @"id":@(1),
                           @"nickName":@"Jock",
                           @"status":@(0)
                           };
    
    NSLog(@"pdic %@", pdic);
    
    NSData *data = [NSArchiver archivedDataWithRootObject: p];
    
    Person *p1 = [self.unarchiveFromDataTransformer transformedValue:data ];
    
    NSLog(@"p1 %@",p1.name);
    
    
    
    
    DataField *field = [[DataField alloc]init];
    field.type = DBDateDataType;
    field.name = @"userName";
    
    self.dateField = field;
    
    TypeMapValueTransformer *typeMapValueTransformer = [[TypeMapValueTransformer alloc]init];
    
    NSString *typeString = [typeMapValueTransformer transformedValue:@(DBDateDataType)];
    
    DBDataType type = [typeMapValueTransformer reverseTransformedValue:@"Int"];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}



#pragma mark--  ComboBox

- (IBAction)selectionChaned:(id)sender {
    NSComboBox *comboBox = sender;
    NSInteger selectedIndex = comboBox.indexOfSelectedItem;
    NSString *selectedContent = comboBox.stringValue;
    NSLog(@"selectedContent %@ at index %ld",selectedContent,selectedIndex);
    
    
    NSLog(@"Data type %d",self.dateField.type);
    
}



#pragma mark--  Defalt ValueTransformer

- (NSValueTransformer*)negateBooleanTransformer {
    if(!_negateBooleanTransformer){
        _negateBooleanTransformer = [NSValueTransformer valueTransformerForName:NSNegateBooleanTransformerName];
    }
    return _negateBooleanTransformer;
}

- (NSValueTransformer*)isNilTransformer {
    if(!_isNilTransformer){
        _isNilTransformer = [NSValueTransformer valueTransformerForName:NSIsNilTransformerName];
    }
    return _isNilTransformer;
}

- (NSValueTransformer*)isNotNilTransformer{
    if(!_isNotNilTransformer){
        _isNotNilTransformer = [NSValueTransformer valueTransformerForName:NSIsNotNilTransformerName];
    }
    return _isNotNilTransformer;
}

- (NSValueTransformer*)unarchiveFromDataTransformer {
    if(!_unarchiveFromDataTransformer){
        _unarchiveFromDataTransformer = [NSValueTransformer valueTransformerForName:NSUnarchiveFromDataTransformerName];
    }
    return _unarchiveFromDataTransformer;
}


- (NSValueTransformer*)keyedUnarchiveFromDataTransformer {
    if(!_keyedUnarchiveFromDataTransformer){
        _unarchiveFromDataTransformer = [NSValueTransformer valueTransformerForName:NSUnarchiveFromDataTransformerName];
    }
    return _unarchiveFromDataTransformer;
}


@end
