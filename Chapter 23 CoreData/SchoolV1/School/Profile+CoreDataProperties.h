//
//  Profile+CoreDataProperties.h
//  School
//
//  Created by zhaojw on 1/2/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Profile.h"

NS_ASSUME_NONNULL_BEGIN

@interface Profile (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *address;
@property (nonatomic) NSTimeInterval birthday;
@property (nullable, nonatomic, retain) NSString *homephone;
@property (nullable, nonatomic, retain) NSData *photo;
@property (nullable, nonatomic, retain) Students *student;

@end

NS_ASSUME_NONNULL_END
