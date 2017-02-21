//
//  MasterViewController.m
//  MultiDelegate
//
//  Created by zhaojw on 10/3/15.
//  Copyright © 2015 zhaojw. All rights reserved.
//

#import "MasterViewController.h"
#import "BuddyDAO.h"
#import "Buddy.h"
#import "BuddyStatusManager.h"
#import "BuddyStatusMulticastDelegate.h"

NSString *kBuddySelectionChanged = @"kBuddySelectionChanged ";

@interface MasterViewController ()
@property (weak) IBOutlet NSTableView *tableView;
@property(nonatomic,strong)NSArray *buddies;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    [self fetchBuddies];
    
    
    [self addBuddyMultiDelegate];
}

- (void)dealloc {
    [self removeBuddyMultiDelegate];
}


- (void)fetchBuddies
{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
    
        BuddyDAO *buddyDAO= [[BuddyDAO alloc]init];
        
        self.buddies = [buddyDAO findAll];
        
      
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
            
            [self.tableView selectRowIndexes:[NSIndexSet indexSetWithIndex:0] byExtendingSelection:NO];
            
        });
    });
    
}


#pragma mark- NSTableViewDelegate

- ( NSView *)tableView:(NSTableView *)tableView viewForTableColumn:( NSTableColumn *)tableColumn row:(NSInteger)row {

    
    Buddy *buddy = self.buddies[row];
    
   
    NSView *result  =  [tableView makeViewWithIdentifier:@"buddy" owner:self];
    
    NSTextField *cell = result.subviews[0];
    
        
    cell.stringValue = buddy.nickName;
    
    NSString *imageName = @"online";
    if(!buddy.status){
        imageName = @"offline";
    }
    
    NSImage *image = [NSImage imageNamed:imageName];
    
    
    NSImageView *imageView = result.subviews[1];

    imageView.image = image;
    
    return result;
    
    

}


- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    
    NSInteger row = [notification.object selectedRow];
    if(row>=self.buddies.count){
        return;
    }
    
    Buddy *buddy = self.buddies[row];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:kBuddySelectionChanged object:buddy];
}


#pragma mark- NSTableViewDataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [self.buddies count];
}



#pragma maek - multiDelegate

- (void)addBuddyMultiDelegate {

    [[BuddyStatusManager sharedInstance].statusDelegate addDelegate:self delegateQueue:dispatch_get_main_queue()];
}

- (void)removeBuddyMultiDelegate {

    [[BuddyStatusManager sharedInstance].statusDelegate removeDelegate:self delegateQueue:dispatch_get_main_queue()];
}

- (void)buddyStatus:(BuddyStatusMulticastDelegate *)sender didReceiveBuddyOfflineRequest:(Buddy *)buddy {

    [self upDateBuddyStatus:buddy];
    
}

- (void)buddyStatus:(BuddyStatusMulticastDelegate *)sender didReceiveBuddyOnlineRequest:(Buddy *)buddy {
    
    [self upDateBuddyStatus:buddy];
}


- (void)upDateBuddyStatus:(Buddy *)buddy {
    
    for(Buddy *aBubby in self.buddies) {
        
        if(aBubby.ID==buddy.ID){
            aBubby.status = buddy.status;
            break;
        }
    }
    
    [self.tableView reloadData];
}
@end
