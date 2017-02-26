//
//  DetailViewController.m
//  MultiDelegate
//
//  Created by zhaojw on 10/3/15.
//  Copyright © 2015 zhaojw. All rights reserved.
//

#import "DetailViewController.h"
#import "Buddy.h"
#import "BuddyDetail.h"
#import "BuddyDetailDAO.h"
#import "BuddyStatusManager.h"
#import "BuddyStatusMulticastDelegate.h"
#import "NSImage+HHTint.h"

@interface DetailViewController ()
@property(weak) IBOutlet NSTextField *firstNameLabel;
@property(weak) IBOutlet NSTextField *lastNameLabel;
@property(weak) IBOutlet NSTextField *addressLabel;
@property(weak) IBOutlet NSTextField *birthdayLabel;
@property(weak) IBOutlet NSTextField *idLabel;
@property(weak) IBOutlet NSImageView *buddyImageView;

@property(nonatomic, strong) BuddyDetailDAO *buddyDetailDAO;

@property(nonatomic, strong) Buddy *buddy;
@property(nonatomic, strong) BuddyDetail *buddyDetail;
@end

extern NSString *kBuddySelectionChanged;

@implementation DetailViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self registerBuddySelectionChangedNotification];

  [self addBuddyMultiDelegate];
  // Do view setup here.
}

- (void)dealloc {
  [self removeBuddyMultiDelegate];
}

- (void)registerBuddySelectionChangedNotification {
  __weak __typeof(&*self) weakSelf = self;

  [[NSNotificationCenter defaultCenter]
      addObserverForName:kBuddySelectionChanged
                  object:nil
                   queue:[NSOperationQueue mainQueue]
              usingBlock:^(NSNotification *note) {

                __strong __typeof(&*weakSelf) strongSelf = weakSelf;
                if (!strongSelf) {
                  return;
                }

                Buddy *buddy = note.object;

                self.buddy = buddy;

                BuddyDetail *buddyDetail = [self.buddyDetailDAO findByKey:@{
                  @"ID" : @(self.buddy.ID)
                }];

                self.buddyDetail = buddyDetail;

                [self updateDetailView];

                [self updateUserImageView];

              }];
}

- (void)updateDetailView {

  self.idLabel.stringValue = [NSString stringWithFormat:@"%ld", self.buddy.ID];
  self.firstNameLabel.stringValue = self.buddyDetail.firstName;
  self.lastNameLabel.stringValue = self.buddyDetail.lastName;

  self.addressLabel.stringValue = self.buddyDetail.address;

  //    self.birthdayLabel.stringValue = self.buddyDetail.birthDay;
}

- (void)updateUserImageView {

  NSImage *image = [NSImage imageNamed:self.buddyDetail.image];

  if (self.buddy.status == 0) {
    NSImage *grayImage = [image hh_imageTintedWithColor:[NSColor grayColor]];

    self.buddyImageView.image = grayImage;
  } else {

    self.buddyImageView.image = image;
  }
}

#pragma maek - multiDelegate

- (void)addBuddyMultiDelegate {
  [[BuddyStatusManager sharedInstance].statusDelegate
        addDelegate:self
      delegateQueue:dispatch_get_main_queue()];
}

- (void)removeBuddyMultiDelegate {
  [[BuddyStatusManager sharedInstance].statusDelegate
      removeDelegate:self
       delegateQueue:dispatch_get_main_queue()];
}

- (void)buddyStatus:(BuddyStatusMulticastDelegate *)sender
    didReceiveBuddyOfflineRequest:(Buddy *)buddy {

  [self updateBuddyStutas:buddy];
}

- (void)buddyStatus:(BuddyStatusMulticastDelegate *)sender
    didReceiveBuddyOnlineRequest:(Buddy *)buddy {

  [self updateBuddyStutas:buddy];
}

- (void)updateBuddyStutas:(Buddy *)buddy {
  if (buddy.ID == self.buddy.ID) {

    self.buddy.status = buddy.status;

    [self updateUserImageView];
  }
}

#pragma mark - property vars

- (BuddyDetailDAO *)buddyDetailDAO {
  if (!_buddyDetailDAO) {
    _buddyDetailDAO = [[BuddyDetailDAO alloc] init];
  }
  return _buddyDetailDAO;
}

@end
